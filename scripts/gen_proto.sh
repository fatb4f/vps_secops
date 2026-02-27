#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
PROTO_DIR="${ROOT_DIR}/api/proto"

if command -v buf >/dev/null 2>&1; then
  (cd "${PROTO_DIR}" && buf generate --template buf.gen.yaml)
elif command -v docker >/dev/null 2>&1; then
  docker run --rm -u "$(id -u):$(id -g)" \
    -v "${ROOT_DIR}:${ROOT_DIR}" -w "${PROTO_DIR}" \
    bufbuild/buf generate --template buf.gen.yaml
else
  echo "buf or docker is required for proto generation" >&2
  exit 1
fi

echo "proto clients generated"
