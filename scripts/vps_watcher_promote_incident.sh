#!/usr/bin/env bash
set -euo pipefail

INC_DIR="${VPS_SECOPS_STATE_DIR:-$HOME/.local/state/vps_secops}/incidents"
mkdir -p "${INC_DIR}"
TS="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
ID="inc-$(date -u +%Y%m%dT%H%M%SZ)"

LINE="$(ID="${ID}" TS="${TS}" WATCH_EVENT_JSON="${WATCH_EVENT_JSON:-{}}" python - <<'PY'
import json, os, time
raw = os.environ.get("WATCH_EVENT_JSON", "{}")
try:
  event, _ = json.JSONDecoder().raw_decode(raw.lstrip())
except Exception:
  event = {"_raw_watch_event": raw}
incident = {
  "schema_version": "incident_v1",
  "incident_id": os.environ.get("ID"),
  "opened_at_utc": os.environ.get("TS"),
  "source": "watcher",
  "event": event,
  "state": "OPEN",
}
print(json.dumps(incident, sort_keys=True))
PY
)"

printf '%s\n' "${LINE}" >> "${INC_DIR}/incidents.jsonl"
echo "${ID}"
