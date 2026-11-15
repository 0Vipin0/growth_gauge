#!/usr/bin/env bash
set -euo pipefail

clear_storage=false
bypass_auth=false
force_onboarding=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -c|--clear-storage) clear_storage=true ;;
        -b|--bypass-auth) bypass_auth=true ;;
        -o|--onboarding) force_onboarding=true ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "$script_dir/.." && pwd)"
cd "$project_root"

if [ "$clear_storage" = true ]; then
    echo "==> Clearing local storage and Drift databases (Linux)..."
    rm -rf ~/.local/share/growth_gauge ~/.config/GrowthGauge ~/.local/share/GrowthGauge 2>/dev/null || true
    echo "==> Storage cleared."
fi

echo "==> Fetching dependencies..."
flutter pub get

flutter_args=("-t" "lib/main_dev.dart")
if [ "$bypass_auth" = true ]; then
    flutter_args+=("--dart-define=DEV_BYPASS_AUTH=true")
fi
if [ "$force_onboarding" = true ]; then
    flutter_args+=("--dart-define=DEV_FORCE_ONBOARDING=true")
fi

echo "==> Launching app in development mode..."
flutter run "${flutter_args[@]}"