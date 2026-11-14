#!/usr/bin/env bash
# =============================================================================
# validateTemplates.sh  (Linux / macOS wrapper)
#
# Thin launcher for validateTemplates.dart. All validation logic and all output
# formatting live in the Dart file, so results are identical on every platform.
#
# Usage:
#   ./validateTemplates.sh [exercise_file] [template_file] [options]
#   ./validateTemplates.sh --help
#
# Dart lookup order: $DART, `dart` on PATH, $FLUTTER_ROOT, the SDK bundled
# with the `flutter` on PATH.
# Override the script location with VALIDATE_TEMPLATES_DART=/path/to/file.dart
# =============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DART_SCRIPT="${VALIDATE_TEMPLATES_DART:-$SCRIPT_DIR/validateTemplates.dart}"

# Resolve symlinks without relying on `readlink -f` (not available on old macOS).
resolve_link() {
    local target="$1" link
    while [ -L "$target" ]; do
        link="$(readlink "$target")"
        case "$link" in
            /*) target="$link" ;;
            *)  target="$(dirname "$target")/$link" ;;
        esac
    done
    printf '%s\n' "$target"
}

find_dart() {
    if [ -n "${DART:-}" ] && [ -x "${DART}" ]; then
        printf '%s\n' "$DART"; return 0
    fi
    if command -v dart >/dev/null 2>&1; then
        command -v dart; return 0
    fi
    if [ -n "${FLUTTER_ROOT:-}" ] && [ -x "$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dart" ]; then
        printf '%s\n' "$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dart"; return 0
    fi
    if command -v flutter >/dev/null 2>&1; then
        local flutter_bin candidate
        flutter_bin="$(resolve_link "$(command -v flutter)")"
        candidate="$(cd "$(dirname "$flutter_bin")" && pwd)/cache/dart-sdk/bin/dart"
        if [ -x "$candidate" ]; then
            printf '%s\n' "$candidate"; return 0
        fi
    fi
    return 1
}

if [ ! -f "$DART_SCRIPT" ]; then
    echo "[ERROR] Cannot find validateTemplates.dart at: $DART_SCRIPT" >&2
    echo "        Keep it next to this wrapper or set VALIDATE_TEMPLATES_DART." >&2
    exit 2
fi

if ! DART_BIN="$(find_dart)"; then
    echo "[ERROR] Dart SDK not found." >&2
    echo "        Install Dart (https://dart.dev/get-dart) or Flutter, or set the DART environment variable." >&2
    exit 2
fi

exec "$DART_BIN" "$DART_SCRIPT" "$@"
