#!/usr/bin/env bash
set -euo pipefail

OUT_BASE="${VPS_SECOPS_STATE_DIR:-$HOME/.local/state/vps_secops}/triage"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
OUT_DIR="${OUT_BASE}/sweep-${TS}"
mkdir -p "${OUT_DIR}"

printf '%s\n' "${WATCH_EVENT_JSON:-{}}" > "${OUT_DIR}/trigger_event.json"

systemctl status osqueryd --no-pager -l > "${OUT_DIR}/osqueryd.status.txt" || true
systemctl status osquery-baseline-pack.timer --no-pager -l > "${OUT_DIR}/pack.timer.status.txt" || true
systemctl status osquery-baseline-health.timer --no-pager -l > "${OUT_DIR}/health.timer.status.txt" || true

journalctl -u osqueryd -n 200 --no-pager > "${OUT_DIR}/osqueryd.journal.txt" || true
journalctl -u osquery-baseline-pack.service -n 200 --no-pager > "${OUT_DIR}/pack.journal.txt" || true

cp -f /var/lib/osquery-baseline/reports/latest.txt "${OUT_DIR}/health.latest.txt" 2>/dev/null || true
cp -f /var/log/osquery/osqueryd.snapshots.log "${OUT_DIR}/osqueryd.snapshots.log" 2>/dev/null || true

(
  cd "${OUT_DIR}"
  find . -type f -print0 | sort -z | xargs -0 sha256sum > MANIFEST.sha256
)

echo "${OUT_DIR}"
