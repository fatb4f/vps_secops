#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
SPEC="${ROOT_DIR}/api/openapi/openapi.yaml"
PY_OUT="${ROOT_DIR}/clients/python"
TS_OUT="${ROOT_DIR}/clients/typescript"
PY_CFG="${ROOT_DIR}/api/openapi/gen-config/python.yaml"
TS_CFG="${ROOT_DIR}/api/openapi/gen-config/typescript.yaml"

run_openapi() {
  if command -v openapi-generator-cli >/dev/null 2>&1; then
    openapi-generator-cli "$@"
  elif command -v docker >/dev/null 2>&1; then
    docker run --rm -u "$(id -u):$(id -g)" \
      -v "${ROOT_DIR}:${ROOT_DIR}" -w "${ROOT_DIR}" \
      openapitools/openapi-generator-cli "$@"
  else
    echo "openapi-generator-cli or docker is required" >&2
    exit 1
  fi
}

rm -rf "${PY_OUT}"/* "${TS_OUT}"/*

run_openapi generate \
  -i "${SPEC}" \
  -g python \
  -c "${PY_CFG}" \
  -o "${PY_OUT}"

run_openapi generate \
  -i "${SPEC}" \
  -g typescript-fetch \
  -c "${TS_CFG}" \
  -o "${TS_OUT}"

echo "openapi clients generated"
