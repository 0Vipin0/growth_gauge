#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "$script_dir/.." && pwd)"
cd "$project_root"

flutter analyze --fatal-infos --fatal-warnings
dart format --output=none --set-exit-if-changed .

# Ensure Navigator.of is not used and GoRouter is used for navigation across source files
if git grep -n "Navigator.of" lib/; then
    echo "Error: Forbidden 'Navigator.of' usage detected in 'lib/'. Use GoRouter instead."
    exit 1
fi

# Keep the performance benchmark isolated from concurrent test workloads.
flutter test --concurrency=1
