#!/usr/bin/env bash
set -euo pipefail

if command -v sudo >/dev/null 2>&1; then
  if sudo -n true >/dev/null 2>&1; then
    exec sudo -n env WINDOW_SEC=3600 /usr/local/bin/osquery-baseline-pack
  fi
fi

echo "collect_full_pack skipped: requires sudo-capable context" >&2
exit 0
