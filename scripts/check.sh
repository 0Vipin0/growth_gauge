#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "$script_dir/.." && pwd)"
cd "$project_root"

flutter analyze --fatal-infos --fatal-warnings
dart format --output=none --set-exit-if-changed .
# Keep the performance benchmark isolated from concurrent test workloads.
flutter test --concurrency=1
