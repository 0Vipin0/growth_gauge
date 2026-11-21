#!/usr/bin/env bash
# Read-only Growth Gauge review. Does not run pub get, generators, builds, or
# check.sh (which rewrites citation tags). Redirect output to share it:
# bash scripts/review.sh 120 > review-output.txt 2>&1
set -uo pipefail
timeout_seconds="${1:-120}"
if ! [[ "$timeout_seconds" =~ ^[0-9]+$ ]] || (( timeout_seconds < 10 || timeout_seconds > 900 )); then
  echo "Usage: $0 [timeout-seconds: 10..900]" >&2; exit 2
fi
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "$script_dir/.." && pwd)"
cd "$project_root"
started="$(date -Is 2>/dev/null || date)"
echo "Growth Gauge read-only review | $started | root=$project_root"
echo 'Policy: no source/test/config writes; pub get and code generation are intentionally omitted.'
echo 'Working tree:'; git status --short

declare -a phase_names=(
  '01 Foundation / Drift' '02 Catalog / templates' '03 Session runtime' '04 Analytics'
  '05 User / onboarding' '06 Portability' '07 Hardening / UI polish' '08 Structure consistency'
  '09 Test coverage' '10 GoRouter' '11 Bloc state' '12 Responsive / A11y'
  '13 Catalog steps' '14 Secure local auth' '15 Sounds / reminders / TTS' '16 CI / build automation'
  '17 Modular design system' '18 Biometric intelligence'
)
declare -a source_paths=(
  lib/core/database lib/features/catalog lib/features/session lib/features/analytics
  lib/features/user lib/features/portability lib/features/home lib/features
  test lib/core/routing lib/features lib/features/common/presentation
  lib/features/catalog lib/features/authentication lib/features/notification .github/workflows
  lib/features/common/presentation/widgets lib/features/user
)
declare -a test_paths=(
  test/core/database test/features/catalog test/features/session test/features/analytics
  test/features/user test/features/portability test/features/home test
  test test/core/app test/features test/features/common test/features/catalog
  test/features/authentication test/features/notification test test/core/theme test/features/user
)
echo; echo 'PHASE EVIDENCE (presence is a signal, not a completion verdict)'
for i in "${!phase_names[@]}"; do
  source_count=0; test_count=0
  [[ -d "${source_paths[$i]}" ]] && source_count=$(find "${source_paths[$i]}" -type f | wc -l)
  [[ -d "${test_paths[$i]}" ]] && test_count=$(find "${test_paths[$i]}" -type f -name '*test.dart' | wc -l)
  phase_num=$(printf '%02d' "$((i+1))")
  plan_row=$(grep -E "^\\| \\*\\*Phase $((i+1))\\*\\*" docs/implementation-plan.md | head -n1 || true)
  plan_status=$(printf '%s\n' "$plan_row" | grep -Eo '`(\[x\] COMPLETED|\[~\] IN PROGRESS|\[ \] PLANNED)`' | tr -d '`' || true)
  [[ -n "$plan_status" ]] || plan_status='phase row not found'
  printf '%-32s sourceFiles=%-4s testFiles=%-3s plan=%s\n' "${phase_names[$i]}" "$source_count" "$test_count" "$plan_status"
done

echo; echo 'FULL SOURCE / TEST FILE INVENTORY'
echo '--- lib files ---'; find lib -type f -print | sort
echo '--- test files ---'; find test -type f -print | sort

run_bounded() {
  local label="$1"; shift
  echo; echo "=== $label ==="
  if ! command -v timeout >/dev/null 2>&1; then echo 'RESULT=NOT_RUN; timeout utility unavailable'; return; fi
  timeout --signal=TERM --kill-after=5s "${timeout_seconds}s" "$@"
  local result=$?
  if (( result == 124 || result == 137 )); then echo "RESULT=TIMEOUT after ${timeout_seconds}s; exit=$result"
  else echo "EXIT_CODE=$result"; fi
}
run_bounded 'Flutter analyze' flutter analyze --fatal-infos --fatal-warnings
run_bounded 'Dart format verification' dart format --output=none --set-exit-if-changed .
echo; echo '=== Forbidden navigation source scan ==='
if command -v rg >/dev/null 2>&1; then
  rg -n 'Navigator\.of' lib test
  result=$?
else
  grep -RIn --include='*.dart' -E 'Navigator\.of' lib test
  result=$?
fi
if (( result == 0 )); then echo 'FAIL: forbidden usage found.'
elif (( result == 1 )); then echo 'PASS: no Navigator.of matches in lib/ or test/.'
else echo "SCAN_ERROR=$result"; fi
run_bounded 'Serial Flutter test suite' flutter test --concurrency=1
run_bounded 'Strict template validation' bash scripts/validateTemplates.sh --strict --show-all --no-color
echo; echo 'NOT RUN: flutter pub get (may alter pubspec.lock/.dart_tool); generators/builds/check wrappers (mutating).'
echo "Review finished: $(date -Is 2>/dev/null || date)"
