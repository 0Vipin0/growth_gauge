#!/usr/bin/env bash
# =============================================================================
# validateTemplates.sh
#
# Validates that every exercise referenced by the workout templates exists in
# the exercise catalog, runs integrity checks on both seed files, and prints a
# tabular summary of the current exercise and template data.
#
# Usage:
#   ./validateTemplates.sh [exercise_file] [template_file] [options]
#
# Options:
#   --strict      Treat warnings as failures (exit 1)
#   --show-all    Also print the full exercise usage table
#   --no-color    Disable coloured output
#   -h, --help    Show this help
#
# Exit codes: 0 = passed, 1 = validation failed, 2 = usage / input error
# Requirements: bash, awk (gawk / mawk / BSD awk), sort, comm, mktemp
# =============================================================================
set -euo pipefail
export LC_ALL=C

DEFAULT_EXERCISE_FILE="./lib/features/catalog/infrastructure/seed/exercise_seed_data.dart"
DEFAULT_TEMPLATE_FILE="./lib/features/template/infrastructure/seed/workout_template_seed_data.dart"

STRICT=0
SHOW_ALL=0
NO_COLOR_FLAG=0
POSITIONAL=()

usage() {
    sed -n '2,/^set -/p' "$0" | sed '$d' | grep -v '^# =\{10,\}' | sed 's/^# \{0,1\}//'
}

for arg in "$@"; do
    case "$arg" in
        --strict)   STRICT=1 ;;
        --show-all) SHOW_ALL=1 ;;
        --no-color) NO_COLOR_FLAG=1 ;;
        -h|--help)  usage; exit 0 ;;
        -*)         echo "[ERROR] Unknown option: $arg"; usage; exit 2 ;;
        *)          POSITIONAL+=("$arg") ;;
    esac
done

EXERCISE_FILE="${POSITIONAL[0]:-$DEFAULT_EXERCISE_FILE}"
TEMPLATE_FILE="${POSITIONAL[1]:-$DEFAULT_TEMPLATE_FILE}"

# Fall back to searching the project when the default locations do not exist.
find_seed() {
    find . \( -name build -o -name .dart_tool -o -name .git -o -name node_modules \) -prune -o \
        -type f -name "$1" -print 2>/dev/null | head -n 1
}
if [[ ! -f "$EXERCISE_FILE" && -z "${POSITIONAL[0]:-}" ]]; then
    found="$(find_seed exercise_seed_data.dart || true)"
    [[ -n "$found" ]] && EXERCISE_FILE="$found"
fi
if [[ ! -f "$TEMPLATE_FILE" && -z "${POSITIONAL[1]:-}" ]]; then
    found="$(find_seed workout_template_seed_data.dart || true)"
    [[ -n "$found" ]] && TEMPLATE_FILE="$found"
fi

if [[ ! -f "$EXERCISE_FILE" ]] || [[ ! -f "$TEMPLATE_FILE" ]]; then
    echo "[ERROR] Could not find input files."
    echo "        Exercise file: $EXERCISE_FILE $([[ -f "$EXERCISE_FILE" ]] && echo '(found)' || echo '(NOT FOUND)')"
    echo "        Template file: $TEMPLATE_FILE $([[ -f "$TEMPLATE_FILE" ]] && echo '(found)' || echo '(NOT FOUND)')"
    echo "Usage: ./validateTemplates.sh [exercise_file] [template_file] [--strict] [--show-all] [--no-color]"
    exit 2
fi

# Colours (only on a terminal, and only when not disabled)
RED=""; GREEN=""; YELLOW=""; CYAN=""; RESET=""
if [[ -t 1 && -z "${NO_COLOR:-}" && "$NO_COLOR_FLAG" -eq 0 ]]; then
    RED=$'\033[31m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; CYAN=$'\033[36m'; RESET=$'\033[0m'
fi

TMP="$(mktemp -d 2>/dev/null || mktemp -d -t validate)"
trap 'rm -rf "$TMP"' EXIT
TAB=$'\t'

# -----------------------------------------------------------------------------
# awk parser: exercise seed file
# Emits: EX id name equipment regions patterns primary missingFields var
#        DECL var   |   REG var
# -----------------------------------------------------------------------------
read -r -d '' EX_AWK <<'AWK' || true
function unq(s,   qch, i, c, out) {
    qch = substr(s, 1, 1); out = ""
    for (i = 2; i <= length(s); i++) {
        c = substr(s, i, 1)
        if (c == "\\") { out = out substr(s, i + 1, 1); i++; continue }
        if (c == qch) break
        out = out c
    }
    return out
}
function getq(line, key,   re, rest) {
    re = "(^|[^A-Za-z0-9_])" key ":[ \t]*[\"']"
    if (!match(line, re)) return ""
    rest = substr(line, RSTART + RLENGTH - 1)
    return unq(rest)
}
function addtok(s, kind,   t) {
    while (match(s, /(EquipmentType|BodyRegion|MovementPattern|MuscleGroup)\.[A-Za-z0-9_]+/)) {
        t = substr(s, RSTART, RLENGTH); sub(/^[A-Za-z]+\./, "", t)
        lst[kind] = (lst[kind] == "" ? t : lst[kind] "," t)
        s = substr(s, RSTART + RLENGTH)
    }
}
function reset() {
    id = ""; name = ""; lst["equip"] = ""; lst["region"] = ""; lst["pattern"] = ""; lst["primary"] = ""
    coll = ""; fs = 0; fe = 0; fc = 0; fb = 0; hasEquip = 0
}
function flush(   miss, eq) {
    if (!indecl) return
    miss = ""
    if (!fs) miss = miss (miss == "" ? "" : ",") "setup"
    if (!fe) miss = miss (miss == "" ? "" : ",") "execution"
    if (!fc) miss = miss (miss == "" ? "" : ",") "cues"
    if (!fb) miss = miss (miss == "" ? "" : ",") "breathing"
    eq = lst["equip"]
    if (!hasEquip && ismove) eq = "bodyweight"
    print "EX", id, name, (eq == "" ? "-" : eq), (lst["region"] == "" ? "-" : lst["region"]), \
          (lst["pattern"] == "" ? "-" : lst["pattern"]), (lst["primary"] == "" ? "-" : lst["primary"]), \
          (miss == "" ? "-" : miss), var
    print "DECL", var
    indecl = 0
}
BEGIN { OFS = "\t"; indecl = 0; inall = 0 }
{ sub(/\r$/, "") }
/get all => \[/ { inall = 1; next }
inall && /^  \];/ { inall = 0; next }
inall {
    if (match($0, /^[ \t]*_[A-Za-z0-9_]+,/)) {
        v = substr($0, RSTART, RLENGTH); sub(/^[ \t]*/, "", v); sub(/,.*/, "", v)
        print "REG", v
    }
    next
}
match($0, /static final _[A-Za-z0-9_]+ = (Exercise|_movement)\(/) {
    flush()
    v = substr($0, RSTART, RLENGTH); sub(/^static final /, "", v); sub(/ = .*/, "", v)
    var = v; ismove = ($0 ~ /= _movement\(/) ? 1 : 0
    reset(); indecl = 1
    next
}
indecl {
    if (id == "" && $0 ~ /(^|[^A-Za-z0-9_])id:/) id = getq($0, "id")
    if (name == "" && $0 ~ /^[ \t]*name:/) name = getq($0, "name")
    k = ""
    if ($0 ~ /^[ \t]*(bodyRegions|regions):/) k = "region"
    else if ($0 ~ /^[ \t]*(movementPatterns|patterns):/) k = "pattern"
    else if ($0 ~ /^[ \t]*(primaryMuscles|primary):/) k = "primary"
    else if ($0 ~ /^[ \t]*(requiredEquipment|equipment):/) { k = "equip"; hasEquip = 1 }
    if (k != "") coll = k
    if (coll != "") { addtok($0, coll); if ($0 ~ /\]/) coll = "" }
    if ($0 ~ /^[ \t]*(setupInstructions|setup):/) fs = 1
    if ($0 ~ /^[ \t]*(executionInstructions:|execution:[ \t]*(const[ \t]*)?\[)/) fe = 1
    if ($0 ~ /^[ \t]*(techniqueCues|cues):/) fc = 1
    if ($0 ~ /^[ \t]*(breathingInstructions|breathing):/) fb = 1
    if ($0 ~ /^  \);[ \t]*$/) flush()
}
END { flush() }
AWK

# -----------------------------------------------------------------------------
# awk parser: template seed file
# Emits: TPL idx var tid name currentRev revId revTemplateId blocks items sets uniqueEx
#        REF idx templateName exerciseId comment | NID kind id idx
#        ZERO idx name | DECL var | REG var
# -----------------------------------------------------------------------------
read -r -d '' TPL_AWK <<'AWK' || true
function unq(s,   qch, i, c, out) {
    qch = substr(s, 1, 1); out = ""
    for (i = 2; i <= length(s); i++) {
        c = substr(s, i, 1)
        if (c == "\\") { out = out substr(s, i + 1, 1); i++; continue }
        if (c == qch) break
        out = out c
    }
    return out
}
function getq(line, key,   re, rest) {
    re = "(^|[^A-Za-z0-9_])" key ":[ \t]*[\"']"
    if (!match(line, re)) return ""
    rest = substr(line, RSTART + RLENGTH - 1)
    return unq(rest)
}
function cnt(line, pat,   tmp) { tmp = line; return gsub(pat, "&", tmp) }
function reset(   k) {
    tid = ""; name = ""; curRid = ""; revId = ""; revTid = ""; st = ""
    blocks = 0; items = 0; sets = 0; uniq = 0
    for (k in seen) delete seen[k]
}
function flush() {
    if (!inb) return
    print "TPL", ntpl, var, tid, name, curRid, revId, revTid, blocks, items, sets, uniq
    print "DECL", var
    inb = 0
}
BEGIN { OFS = "\t"; inb = 0; inall = 0; ntpl = 0 }
{ sub(/\r$/, "") }
/get all => \[/ { inall = 1; next }
inall && /^  \];/ { inall = 0; next }
inall {
    if (match($0, /^[ \t]*_[A-Za-z0-9_]+,/)) {
        v = substr($0, RSTART, RLENGTH); sub(/^[ \t]*/, "", v); sub(/,.*/, "", v)
        print "REG", v
    }
    next
}
match($0, /static final _[A-Za-z0-9_]+ = TemplateSeedBundle\(/) {
    flush()
    v = substr($0, RSTART, RLENGTH); sub(/^static final /, "", v); sub(/ = .*/, "", v)
    var = v; ntpl++; reset(); inb = 1
    next
}
inb {
    line = $0
    if (line ~ /WorkoutTemplateRevision\(/) st = "rev"
    else if (line ~ /WorkoutTemplate\(/) st = "tpl"
    if (line ~ /WorkoutBlock\(/) st = "blk"
    if (st == "tpl") {
        if (tid == "") tid = getq(line, "id")
        if (name == "") name = getq(line, "name")
        if (curRid == "") curRid = getq(line, "currentRevisionId")
    } else if (st == "rev") {
        if (revId == "") revId = getq(line, "id")
        if (revTid == "") revTid = getq(line, "templateId")
    }
    blocks += cnt(line, "WorkoutBlock\\(")
    items  += cnt(line, "TemplateItem\\(")
    sets   += cnt(line, "TargetSet\\(")
    rest = line
    while (match(rest, /id:[ \t]*'(block|item|ts)-[^']*'/)) {
        tok = substr(rest, RSTART, RLENGTH)
        kind = tok; sub(/^id:[ \t]*'/, "", kind); sub(/-.*/, "", kind)
        val = tok; sub(/^id:[ \t]*'/, "", val); sub(/'$/, "", val)
        print "NID", kind, val, ntpl
        rest = substr(rest, RSTART + RLENGTH)
    }
    ex = getq(line, "exerciseId")
    if (ex != "") {
        c = ""; p = index(line, "//")
        if (p > 0) { c = substr(line, p + 2); sub(/^[ \t]+/, "", c) }
        print "REF", ntpl, name, ex, c
        if (!(ex in seen)) { seen[ex] = 1; uniq++ }
    }
    if (line ~ /targetReps:[ \t]*0([^0-9.]|$)/) print "ZERO", ntpl, name
    if (line ~ /^  \);[ \t]*$/) flush()
}
END { flush() }
AWK

# -----------------------------------------------------------------------------
# awk table renderer: reads TSV (first row = header) from stdin
#   $1 title   $2 alignment string (l/r per column)   $3 max column width
# -----------------------------------------------------------------------------
read -r -d '' TABLE_AWK <<'AWK' || true
function rep(ch, n,   s) { s = ""; while (n-- > 0) s = s ch; return s }
function fit(s) { if (length(s) > maxw) return substr(s, 1, maxw - 3) "..."; return s }
function cell(s, w, al,   n) {
    n = w - length(s)
    if (al == "r") return rep(" ", n) s
    return s rep(" ", n)
}
BEGIN { FS = "\t"; nr = 0; nc = 0 }
{
    nr++
    if (NF > nc) nc = NF
    for (c = 1; c <= NF; c++) { v[nr, c] = fit($c); if (length(v[nr, c]) > w[c]) w[c] = length(v[nr, c]) }
}
END {
    if (title != "") printf "\n %s\n", title
    if (nr == 0) { print " (none)"; exit }
    sep = "+"
    for (c = 1; c <= nc; c++) sep = sep rep("-", w[c] + 2) "+"
    print sep
    for (r = 1; r <= nr; r++) {
        line = "|"
        for (c = 1; c <= nc; c++) {
            al = (r == 1) ? "l" : substr(aligns, c, 1)
            line = line " " cell(v[r, c], w[c], al) " |"
        }
        print line
        if (r == 1) print sep
    }
    print sep
}
AWK

# table <title> <aligns> <maxw>   (TSV on stdin)
table() { awk -v title="$1" -v aligns="$2" -v maxw="${3:-48}" "$TABLE_AWK"; }

# -----------------------------------------------------------------------------
# Parse both files
# -----------------------------------------------------------------------------
awk -F'\t' "$EX_AWK"  "$EXERCISE_FILE" > "$TMP/ex_all.tsv"
awk -F'\t' "$TPL_AWK" "$TEMPLATE_FILE" > "$TMP/tpl_all.tsv"

awk -F'\t' '$1=="EX"'   "$TMP/ex_all.tsv"  > "$TMP/ex.tsv"
awk -F'\t' '$1=="DECL"' "$TMP/ex_all.tsv"  | cut -f2 | sort > "$TMP/ex_decl.txt"
awk -F'\t' '$1=="REG"'  "$TMP/ex_all.tsv"  | cut -f2 | sort > "$TMP/ex_reg.txt"
awk -F'\t' '$1=="TPL"'  "$TMP/tpl_all.tsv" > "$TMP/tpl.tsv"
awk -F'\t' '$1=="REF"'  "$TMP/tpl_all.tsv" > "$TMP/refs.tsv"
awk -F'\t' '$1=="NID"'  "$TMP/tpl_all.tsv" > "$TMP/nid.tsv"
awk -F'\t' '$1=="ZERO"' "$TMP/tpl_all.tsv" > "$TMP/zero.tsv"
awk -F'\t' '$1=="DECL"' "$TMP/tpl_all.tsv" | cut -f2 | sort > "$TMP/tpl_decl.txt"
awk -F'\t' '$1=="REG"'  "$TMP/tpl_all.tsv" | cut -f2 | sort > "$TMP/tpl_reg.txt"

count_lines() { if [[ -s "$1" ]]; then wc -l < "$1" | tr -d ' '; else echo 0; fi; }

cut -f2 "$TMP/ex.tsv"   | grep -v '^$' | sort -u > "$TMP/def_ids.txt" || true
cut -f4 "$TMP/refs.tsv" | grep -v '^$' | sort -u > "$TMP/used_ids.txt" || true
comm -13 "$TMP/def_ids.txt" "$TMP/used_ids.txt" > "$TMP/missing_ids.txt"
comm -23 "$TMP/def_ids.txt" "$TMP/used_ids.txt" > "$TMP/orphan_ids.txt"

EX_ROWS=$(count_lines "$TMP/ex.tsv")
DEF_COUNT=$(count_lines "$TMP/def_ids.txt")
USED_COUNT=$(count_lines "$TMP/used_ids.txt")
MISSING_COUNT=$(count_lines "$TMP/missing_ids.txt")
ORPHAN_COUNT=$(count_lines "$TMP/orphan_ids.txt")
TPL_COUNT=$(count_lines "$TMP/tpl.tsv")
REF_COUNT=$(count_lines "$TMP/refs.tsv")
MISSING_REFS=$(awk -F'\t' 'NR==FNR{m[$1]=1;next} ($4 in m)' "$TMP/missing_ids.txt" "$TMP/refs.tsv" | wc -l | tr -d ' ')
BLOCKS=$(awk -F'\t' '{s+=$9} END{print s+0}' "$TMP/tpl.tsv")
ITEMS=$(awk -F'\t' '{s+=$10} END{print s+0}' "$TMP/tpl.tsv")
SETS=$(awk -F'\t' '{s+=$11} END{print s+0}' "$TMP/tpl.tsv")

if [[ "$EX_ROWS" -eq 0 ]]; then
    echo "[ERROR] No exercise definitions were found in: $EXERCISE_FILE"; exit 2
fi
if [[ "$TPL_COUNT" -eq 0 ]]; then
    echo "[ERROR] No template definitions were found in: $TEMPLATE_FILE"; exit 2
fi

# -----------------------------------------------------------------------------
# Integrity checks -> duplicates.tsv (Type, Value, Detail)
# -----------------------------------------------------------------------------
: > "$TMP/dupes.tsv"
dupes_of() { # <label> <file with one value per line>
    sort "$2" | uniq -c | awk -v t="$1" '$1>1 { n=$1; $1=""; sub(/^ /,""); print t "\t" $0 "\t" n " occurrences" }' >> "$TMP/dupes.tsv"
}
cut -f2 "$TMP/ex.tsv"  > "$TMP/l_ex_ids.txt";   dupes_of "Exercise ID" "$TMP/l_ex_ids.txt"
cut -f3 "$TMP/ex.tsv"  > "$TMP/l_ex_names.txt"; dupes_of "Exercise name" "$TMP/l_ex_names.txt"
cut -f4 "$TMP/tpl.tsv" > "$TMP/l_t_ids.txt";    dupes_of "Template ID" "$TMP/l_t_ids.txt"
cut -f5 "$TMP/tpl.tsv" > "$TMP/l_t_names.txt";  dupes_of "Template name" "$TMP/l_t_names.txt"
cut -f7 "$TMP/tpl.tsv" > "$TMP/l_r_ids.txt";    dupes_of "Revision ID" "$TMP/l_r_ids.txt"
for kind in block item ts; do
    awk -F'\t' -v k="$kind" '$2==k {print $3}' "$TMP/nid.tsv" > "$TMP/l_nid_$kind.txt"
    dupes_of "Nested ID ($kind)" "$TMP/l_nid_$kind.txt"
done
cat "$TMP/ex_decl.txt" "$TMP/tpl_decl.txt" > "$TMP/l_vars.txt"; dupes_of "Static variable" "$TMP/l_vars.txt"

DUP_EX_ID=$(awk -F'\t' '$1=="Exercise ID"' "$TMP/dupes.tsv" | wc -l | tr -d ' ')
DUP_EX_NAME=$(awk -F'\t' '$1=="Exercise name"' "$TMP/dupes.tsv" | wc -l | tr -d ' ')
DUP_T_ID=$(awk -F'\t' '$1=="Template ID"' "$TMP/dupes.tsv" | wc -l | tr -d ' ')
DUP_T_NAME=$(awk -F'\t' '$1=="Template name"' "$TMP/dupes.tsv" | wc -l | tr -d ' ')
DUP_REV=$(awk -F'\t' '$1=="Revision ID"' "$TMP/dupes.tsv" | wc -l | tr -d ' ')
DUP_NESTED=$(awk -F'\t' '$1 ~ /^Nested ID/' "$TMP/dupes.tsv" | wc -l | tr -d ' ')
DUP_VARS=$(awk -F'\t' '$1=="Static variable"' "$TMP/dupes.tsv" | wc -l | tr -d ' ')

# Revision consistency: currentRevisionId == revision id, revision.templateId == template id
REV_MISMATCH=$(awk -F'\t' '($6 != $7) || ($4 != $8)' "$TMP/tpl.tsv" | wc -l | tr -d ' ')

# Registration in all[]
comm -23 "$TMP/ex_decl.txt" "$TMP/ex_reg.txt" > "$TMP/ex_unreg.txt"
comm -13 "$TMP/ex_decl.txt" "$TMP/ex_reg.txt" > "$TMP/ex_undecl.txt"
comm -23 "$TMP/tpl_decl.txt" "$TMP/tpl_reg.txt" > "$TMP/tpl_unreg.txt"
comm -13 "$TMP/tpl_decl.txt" "$TMP/tpl_reg.txt" > "$TMP/tpl_undecl.txt"
EX_UNREG=$(count_lines "$TMP/ex_unreg.txt");   EX_UNDECL=$(count_lines "$TMP/ex_undecl.txt")
TPL_UNREG=$(count_lines "$TMP/tpl_unreg.txt"); TPL_UNDECL=$(count_lines "$TMP/tpl_undecl.txt")
awk '{print "Exercise not in all[]\t" $0 "\tdeclared but never registered"}'   "$TMP/ex_unreg.txt"   >> "$TMP/dupes.tsv"
awk '{print "Exercise all[] entry\t" $0 "\tregistered but not declared"}'      "$TMP/ex_undecl.txt" >> "$TMP/dupes.tsv"
awk '{print "Template not in all[]\t" $0 "\tdeclared but never registered"}'   "$TMP/tpl_unreg.txt"  >> "$TMP/dupes.tsv"
awk '{print "Template all[] entry\t" $0 "\tregistered but not declared"}'      "$TMP/tpl_undecl.txt" >> "$TMP/dupes.tsv"

INCOMPLETE=$(awk -F'\t' '$8 != "-"' "$TMP/ex.tsv" | wc -l | tr -d ' ')
ZERO_SETS=$(count_lines "$TMP/zero.tsv")

# -----------------------------------------------------------------------------
# Validation result table
# -----------------------------------------------------------------------------
ERRORS=0
WARNINGS=0
: > "$TMP/checks.tsv"
printf 'Check\tType\tResult\tCount\tDetails\n' >> "$TMP/checks.tsv"

add_check() { # <name> <ERROR|WARN> <count> <detail when failing> <detail when ok>
    local result="PASS" detail="$5"
    if [[ "$3" -gt 0 ]]; then
        detail="$4"
        if [[ "$2" == "ERROR" ]]; then result="FAIL"; ERRORS=$((ERRORS + 1)); else result="WARN"; WARNINGS=$((WARNINGS + 1)); fi
    fi
    printf '%s\t%s\t%s\t%s\t%s\n' "$1" "$2" "$result" "$3" "$detail" >> "$TMP/checks.tsv"
}

add_check "Template exercise refs exist in catalog" ERROR "$MISSING_COUNT" \
    "$MISSING_COUNT missing ID(s) across $MISSING_REFS reference(s)" "All $USED_COUNT referenced IDs resolve"
add_check "Exercise IDs unique" ERROR "$DUP_EX_ID" "Duplicate exercise IDs found" "No duplicates"
add_check "Exercise definitions registered in all[]" ERROR "$((EX_UNREG + EX_UNDECL))" \
    "$EX_UNREG unregistered, $EX_UNDECL undeclared" "$EX_ROWS declared = registered"
add_check "Template IDs unique" ERROR "$DUP_T_ID" "Duplicate template IDs found" "No duplicates"
add_check "Revision IDs unique and consistent" ERROR "$((DUP_REV + REV_MISMATCH))" \
    "$DUP_REV duplicate, $REV_MISMATCH inconsistent" "Revision links are consistent"
add_check "Block/item/set IDs unique" ERROR "$DUP_NESTED" "Duplicate nested IDs found" "No duplicates"
add_check "Template definitions registered in all[]" ERROR "$((TPL_UNREG + TPL_UNDECL))" \
    "$TPL_UNREG unregistered, $TPL_UNDECL undeclared" "$TPL_COUNT declared = registered"
add_check "Static variable names unique" ERROR "$DUP_VARS" "Duplicate declarations (compile error)" "No duplicates"
add_check "Template names unique" WARN "$DUP_T_NAME" "Duplicate template names found" "No duplicates"
add_check "Exercise names unique" WARN "$DUP_EX_NAME" "Duplicate exercise names found" "No duplicates"
add_check "Exercises used by templates" WARN "$ORPHAN_COUNT" "$ORPHAN_COUNT defined but never referenced" "Every exercise is used"
add_check "Exercise execution profiles complete" WARN "$INCOMPLETE" \
    "$INCOMPLETE exercise(s) missing setup/execution/cues/breathing" "All profiles complete"
add_check "Sets with targetReps: 0" WARN "$ZERO_SETS" "$ZERO_SETS set(s) have a zero rep target" "None found"

# -----------------------------------------------------------------------------
# Output
# -----------------------------------------------------------------------------
echo "${CYAN}========================================================================${RESET}"
echo "${CYAN} EXERCISE & TEMPLATE VALIDATION SUMMARY (Bash)${RESET}"
echo "${CYAN}========================================================================${RESET}"
echo " Exercise file : $EXERCISE_FILE"
echo " Template file : $TEMPLATE_FILE"

table "VALIDATION CHECKS" "lllrl" 60 < "$TMP/checks.tsv"

{
    printf 'Metric\tCount\tDetails\n'
    printf 'Exercises defined (catalog)\t%s\t%s\n' "$DEF_COUNT" "Unique IDs in exercise seed data"
    printf 'Exercises referenced (distinct)\t%s\t%s\n' "$USED_COUNT" "Unique IDs used across workout templates"
    printf 'Missing exercises\t%s\t%s\n' "$MISSING_COUNT" "$([[ $MISSING_COUNT -gt 0 ]] && echo 'Action required: referenced but not in catalog' || echo 'All referenced exercises exist')"
    printf 'Orphan exercises\t%s\t%s\n' "$ORPHAN_COUNT" "Defined in catalog but not used by any template"
    printf 'Workout templates\t%s\t%s\n' "$TPL_COUNT" "Template bundles in template seed data"
    printf 'Workout blocks\t%s\t%s\n' "$BLOCKS" "Across all templates"
    printf 'Exercise slots (items)\t%s\t%s\n' "$ITEMS" "Total exercise references, including repeats"
    printf 'Target sets\t%s\t%s\n' "$SETS" "Across all templates"
} | table "DATA OVERVIEW" "lrl" 60

# Category breakdowns: Category | Exercises | Used | Unused
category_table() { # <title> <column number in ex.tsv> <label>
    awk -F'\t' -v col="$2" -v label="$3" '
        NR==FNR { used[$1]=1; next }
        {
            n = split($col, parts, ",")
            for (i = 1; i <= n; i++) {
                c = parts[i]
                total[c]++
                if ($2 in used) usedc[c]++
            }
        }
        END { for (c in total) printf "%s\t%d\t%d\t%d\n", c, total[c], usedc[c]+0, total[c]-(usedc[c]+0) }
    ' "$TMP/used_ids.txt" "$TMP/ex.tsv" | sort -t"$TAB" -k2,2nr -k1,1 > "$TMP/cat.tsv"
    { printf '%s\tExercises\tUsed\tUnused\n' "$3"; cat "$TMP/cat.tsv"; } | table "$1" "lrrr" 40
}
category_table "EXERCISE CATALOG BY EQUIPMENT (an exercise counts once per equipment type)" 4 "Equipment"
category_table "EXERCISE CATALOG BY BODY REGION" 5 "Body Region"
category_table "EXERCISE CATALOG BY MOVEMENT PATTERN" 6 "Movement Pattern"
category_table "EXERCISE CATALOG BY PRIMARY MUSCLE" 7 "Primary Muscle"

# Template summary: # | Template | Blocks | Items | Sets | Unique Ex | Refs
awk -F'\t' '
    FILENAME==ARGV[1] { def[$1]=1; next }
    FILENAME==ARGV[2] { if (!($4 in def)) miss[$2]++; next }
    { st = (miss[$2] > 0) ? miss[$2] " missing" : "OK"
      printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n", $2, $5, $9, $10, $11, $12, st }
' "$TMP/def_ids.txt" "$TMP/refs.tsv" "$TMP/tpl.tsv" > "$TMP/tpl_table.tsv"
{ printf '#\tTemplate\tBlocks\tItems\tSets\tUnique Ex\tRefs\n'; cat "$TMP/tpl_table.tsv"; } | table "WORKOUT TEMPLATES" "rlrrrrl" 46

# Missing exercises with suggestions
if [[ "$MISSING_COUNT" -gt 0 ]]; then
    awk -F'\t' '
        function toks(s, arr,   n, i, p, m, out) {
            n = split(s, p, "-"); m = 0
            for (i = 1; i <= n; i++) if (p[i] != "exercise" && p[i] !~ /^[0-9]+$/ && p[i] != "") { m++; arr[m] = p[i] }
            return m
        }
        FILENAME==ARGV[1] { nd++; did[nd] = $2; def[$2] = 1; next }
        {
            id = $4
            if (id in def) next
            cnt[id]++
            key = id SUBSEP $3
            if (!(key in seen)) { seen[key] = 1; nt[id]++; if (nt[id] <= 2) tl[id] = (tl[id] == "" ? $3 : tl[id] "; " $3) }
            if (!(id in ord)) { ord[id] = 1; list[++no] = id }
        }
        END {
            for (i = 1; i <= no; i++) {
                id = list[i]; delete mt; m = toks(id, mt); best = ""; bs = 0
                for (d = 1; d <= nd; d++) {
                    delete dt; k = toks(did[d], dt); shared = 0
                    for (a = 1; a <= m; a++) for (b = 1; b <= k; b++) if (mt[a] == dt[b]) { shared++; break }
                    union = m + k - shared; score = (union > 0) ? shared / union : 0
                    if (score > bs) { bs = score; best = did[d] }
                }
                printf "%s\t%d\t%s%s\t%s\n", id, cnt[id], tl[id], (nt[id] > 2 ? " (+" nt[id] - 2 " more)" : ""), (bs >= 0.4 ? best : "-")
            }
        }
    ' "$TMP/ex.tsv" "$TMP/refs.tsv" | sort > "$TMP/missing_table.tsv"
    { printf 'Missing Exercise ID\tRefs\tReferenced By\tClosest Catalog Match\n'; cat "$TMP/missing_table.tsv"; } \
        | table "MISSING EXERCISES (referenced by templates, absent from catalog)" "lrll" 56
fi

# Integrity problems (duplicates / registration)
if [[ -s "$TMP/dupes.tsv" ]]; then
    { printf 'Issue\tValue\tDetail\n'; sort "$TMP/dupes.tsv"; } | table "INTEGRITY ISSUES" "lll" 56
fi

# Incomplete execution profiles
if [[ "$INCOMPLETE" -gt 0 ]]; then
    { printf 'Exercise ID\tMissing Fields\n'; awk -F'\t' '$8 != "-" {print $2 "\t" $8}' "$TMP/ex.tsv" | sort; } \
        | table "INCOMPLETE EXECUTION PROFILES" "ll" 56
fi

# Zero-rep sets per template
if [[ "$ZERO_SETS" -gt 0 ]]; then
    { printf 'Template\tSets with targetReps: 0\n'; awk -F'\t' '{c[$3]++} END{for(n in c) print n "\t" c[n]}' "$TMP/zero.tsv" | sort; } \
        | table "SETS WITH ZERO REP TARGET (review)" "lr" 56
fi

# Usage per exercise: orphans (default) or everything (--show-all)
awk -F'\t' '
    NR==FNR { key = $2 SUBSEP $4; if (!(key in s)) { s[key]=1; tc[$4]++ }; next }
    { printf "%s\t%s\t%s\t%d\n", $2, $3, $4, tc[$2] + 0 }
' "$TMP/refs.tsv" "$TMP/ex.tsv" | sort > "$TMP/usage.tsv"
if [[ "$SHOW_ALL" -eq 1 ]]; then
    { printf 'Exercise ID\tName\tEquipment\tTemplates\n'; cat "$TMP/usage.tsv"; } | table "EXERCISE USAGE (all exercises)" "lllr" 44
elif [[ "$ORPHAN_COUNT" -gt 0 ]]; then
    LIMIT=25
    { printf 'Exercise ID\tName\tEquipment\tTemplates\n'; awk -F'\t' '$4==0' "$TMP/usage.tsv" | head -n "$LIMIT"; } \
        | table "ORPHAN EXERCISES (defined, not used in any template)" "lllr" 44
    if [[ "$ORPHAN_COUNT" -gt "$LIMIT" ]]; then
        echo " ... and $((ORPHAN_COUNT - LIMIT)) more (use --show-all to list every exercise)"
    fi
fi

echo
echo "${CYAN}========================================================================${RESET}"
echo " Errors: $ERRORS   Warnings: $WARNINGS$([[ $STRICT -eq 1 ]] && echo '   (strict mode: warnings fail the run)')"
echo "${CYAN}========================================================================${RESET}"

# -----------------------------------------------------------------------------
# Exit status
# -----------------------------------------------------------------------------
if [[ "$MISSING_COUNT" -gt 0 ]]; then
    echo "${RED}VALIDATION FAILED: The following exercise IDs are missing from the catalog:${RESET}"
    sed 's/^/   - /' "$TMP/missing_ids.txt"
fi
if [[ "$ERRORS" -gt 0 || ( "$STRICT" -eq 1 && "$WARNINGS" -gt 0 ) ]]; then
    [[ "$MISSING_COUNT" -eq 0 ]] && echo "${RED}VALIDATION FAILED: see the checks marked FAIL$([[ $STRICT -eq 1 ]] && echo ' / WARN') above.${RESET}"
    exit 1
fi
echo "${GREEN}VALIDATION PASSED: Every template reference is valid!${RESET}"
exit 0
