#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "$script_dir/.." && pwd)"
cd "$project_root"

echo "==> Removing citation tags from all files (excluding script files) using regex..."
find . -type f -not -path '*/.*' -not -path './build/*' -not -path './.dart_tool/*' -not -name 'check.sh' -not -name 'check.ps1' | while read -r file; do
    if grep -qE '\[cite:[^]]+\]' "$file"; then
        perl -pi -e 's/\[cite:[^]]+\]//g' "$file"
        echo "Removed citations from: $file"
    fi
done

echo "==> Fetching dependencies..."
flutter pub get

echo "==> Running static analysis..."
flutter analyze --fatal-infos --fatal-warnings

echo "==> Checking code formatting..."
dart format --output=none --set-exit-if-changed .

# Ensure Navigator.of is not used and GoRouter is used for navigation across all files in the root directory
echo "==> Verifying navigation architecture (GoRouter enforcement)..."
if git grep -n "Navigator.of"; then
    echo "Error: Forbidden 'Navigator.of' usage detected. Use GoRouter instead."
    exit 1
fi

# Keep the performance benchmark isolated from concurrent test workloads.
echo "==> Running test suite..."
flutter test --concurrency=1
