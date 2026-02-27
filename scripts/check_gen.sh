#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

"${ROOT_DIR}/scripts/gen.sh"

if ! git -C "${ROOT_DIR}" diff --quiet; then
  echo "generated artifacts out of date" >&2
  git -C "${ROOT_DIR}" status --short
  exit 1
fi

echo "generated artifacts are up to date"
