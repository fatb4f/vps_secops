#!/usr/bin/env python3
"""Emit vps_secops pipeline events as JSONL for watcher/watchctl.

Reads `/var/lib/osquery-baseline/reports/latest.txt` periodically and emits
state-change events only to reduce noise.
"""

from __future__ import annotations

import argparse
import json
import time
from dataclasses import dataclass
from pathlib import Path

DEFAULT_REPORT = Path("/var/lib/osquery-baseline/reports/latest.txt")


@dataclass
class HealthState:
    status: str = "unknown"
    latest_pack_age_sec: int = 0
    packs_last_24h: int = 0
    coverage_pct: float = 0.0


def parse_health(path: Path) -> HealthState:
    if not path.exists():
        return HealthState(status="missing")

    fields: dict[str, str] = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        if ":" not in line:
            continue
        key, value = line.split(":", 1)
        fields[key.strip()] = value.strip()

    return HealthState(
        status=fields.get("status", "ok"),
        latest_pack_age_sec=int(fields.get("latest_pack_age_sec", "0") or 0),
        packs_last_24h=int(fields.get("packs_last_24h", "0") or 0),
        coverage_pct=float(fields.get("packs_coverage_pct", "0") or 0),
    )


def event(topic: str, severity: str, state: HealthState) -> str:
    payload = {
        "topic": topic,
        "severity": severity,
        "source": "vps_secops.health",
        "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "status": state.status,
        "latest_pack_age_sec": state.latest_pack_age_sec,
        "packs_last_24h": state.packs_last_24h,
        "coverage_pct": state.coverage_pct,
    }
    return json.dumps(payload, sort_keys=True)


def main() -> int:
    parser = argparse.ArgumentParser(description="Emit vps_secops health events JSONL")
    parser.add_argument("--report", default=str(DEFAULT_REPORT))
    parser.add_argument("--interval", type=int, default=30)
    parser.add_argument("--stale-seconds", type=int, default=900)
    parser.add_argument("--coverage-warn", type=float, default=60.0)
    args = parser.parse_args()

    report = Path(args.report)
    last_topic = None

    while True:
        state = parse_health(report)

        if state.status == "missing":
            topic = "vps_secops.pipeline.report.missing"
            sev = "warn"
        elif state.latest_pack_age_sec > args.stale_seconds:
            topic = "vps_secops.pipeline.pack.stale"
            sev = "warn"
        elif state.coverage_pct < args.coverage_warn:
            topic = "vps_secops.pipeline.coverage.low"
            sev = "warn"
        else:
            topic = "vps_secops.pipeline.ok"
            sev = "info"

        if topic != last_topic:
            print(event(topic, sev, state), flush=True)
            last_topic = topic

        time.sleep(max(5, args.interval))


if __name__ == "__main__":
    raise SystemExit(main())
