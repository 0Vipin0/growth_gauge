#!/usr/bin/env bash
set -euo pipefail

if (($# == 0)); then
  echo "Usage: $0 {apk|appbundle|web|windows|linux|macos} [flutter build options...]" >&2
  exit 2
fi

target="$1"
shift
case "$target" in
  apk|appbundle|web|windows|linux|macos) ;;
  *)
    echo "Unsupported build target: $target" >&2
    echo "Choose apk, appbundle, web, windows, linux, or macos." >&2
    exit 2
    ;;
esac

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "$script_dir/.." && pwd)"
cd "$project_root"

flutter build "$target" "$@"
