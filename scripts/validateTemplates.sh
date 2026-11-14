#!/usr/bin/env bash
set -euo pipefail

# Default file paths
EXERCISE_FILE="${1:-./lib/features/catalog/infrastructure/seed/exercise_seed_data.dart}"
TEMPLATE_FILE="${2:-./lib/features/template/infrastructure/seed/workout_template_seed_data.dart}"

if [[ ! -f "$EXERCISE_FILE" ]] || [[ ! -f "$TEMPLATE_FILE" ]]; then
    echo "[ERROR] Could not find input files."
    echo "Usage: ./validateTemplates.sh [exercise_file] [template_file]"
    exit 1
fi

# Extract defined and referenced IDs using grep and sed
defined_ids=$(grep -oE "id:\s*'[^']+'" "$EXERCISE_FILE" | sed -E "s/id:\s*'([^']+)'/\1/" | sort -u)
referenced_ids=$(grep -oE "exerciseId:\s*'[^']+'" "$TEMPLATE_FILE" | sed -E "s/exerciseId:\s*'([^']+)'/\1/" | sort -u)

defined_count=$(echo "$defined_ids" | grep -v '^$' | wc -l)
referenced_count=$(echo "$referenced_ids" | grep -v '^$' | wc -l)

# Find discrepancies
missing=$(comm -23 <(echo "$referenced_ids" | sort) <(echo "$defined_ids" | sort))
missing_count=$(echo "$missing" | grep -v '^$' | wc -l)

orphans=$(comm -13 <(echo "$referenced_ids" | sort) <(echo "$defined_ids" | sort))
orphan_count=$(echo "$orphans" | grep -v '^$' | wc -l)

# Print Summary Table
echo "========================================================================"
echo " EXERCISE & TEMPLATE VALIDATION SUMMARY (Bash)                          "
echo "========================================================================"
printf "%-30s | %-6s | %s\n" "Metric / Category" "Count" "Review Status / Details"
echo "--------------------------------+--------+------------------------------"
printf "%-30s | %-6s | %s\n" "Total Defined Exercises" "$defined_count" "Loaded from Exercise Seed Catalog"
printf "%-30s | %-6s | %s\n" "Total Referenced Exercises" "$referenced_count" "Unique IDs used across Workout Templates"

if [ "$missing_count" -gt 0 ]; then
    printf "%-30s | %-6s | %s\n" "Missing Exercises" "$missing_count" "Action Required: Missing from catalog"
else
    printf "%-30s | %-6s | %s\n" "Missing Exercises" "0" "All referenced exercises exist"
fi

printf "%-30s | %-6s | %s\n" "Orphan Exercises" "$orphan_count" "Defined in catalog but currently unused"
echo "========================================================================"

# Exit with status code
if [ "$missing_count" -gt 0 ]; then
    echo "VALIDATION FAILED: The following exercise IDs are missing from the catalog:"
    echo "$missing" | sed 's/^/   - /'
    exit 1
else
    echo "VALIDATION PASSED: Every template reference is valid!"
    exit 0
fi