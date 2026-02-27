#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

"${ROOT_DIR}/scripts/gen_openapi.sh"
"${ROOT_DIR}/scripts/gen_proto.sh"

echo "generation complete"
