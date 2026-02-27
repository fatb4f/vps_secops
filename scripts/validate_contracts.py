#!/usr/bin/env python3
"""Validate local contract scaffolding for vps_secops.

This script checks that:
- required schema files exist and are valid JSON
- OpenAPI file exists
"""

from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

SCHEMAS = [
    ROOT / "schemas/common/event_envelope_v1.schema.json",
    ROOT / "schemas/osquery/osquery_snapshot_event_v1.schema.json",
    ROOT / "schemas/osquery/baseline_pack_v1.schema.json",
    ROOT / "schemas/triage/triage_decision_v1.schema.json",
    ROOT / "schemas/guardrail/guardrail_action_v1.schema.json",
]
OPENAPI = ROOT / "api/openapi/openapi.yaml"


def main() -> int:
    ok = True
    for path in SCHEMAS:
        if not path.exists():
            print(f"missing schema: {path}")
            ok = False
            continue
        try:
            json.loads(path.read_text(encoding="utf-8"))
        except json.JSONDecodeError as exc:
            print(f"invalid JSON in {path}: {exc}")
            ok = False

    if not OPENAPI.exists():
        print(f"missing OpenAPI spec: {OPENAPI}")
        ok = False

    print("contract scaffold: OK" if ok else "contract scaffold: FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
