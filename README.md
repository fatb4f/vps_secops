# vps_secops

Spec-first security telemetry and DFIR control-plane scaffolding.

## Contract authority
1. Canonical schemas: `schemas/**/*.schema.json` (derived from osquery baseline structures and normalized decision contracts)
2. API spec: `api/openapi/openapi.yaml` (derived from schemas)

## Layout
- `schemas/`: canonical JSON Schemas
- `api/openapi/`: OpenAPI spec derived from schemas
- `src/vps_secops/`: implementation modules (scaffold)
- `docs/`: architecture and implementation docs
- `issues/`: local issue tracker markdown
- `milestones/`: local milestone plans

## Current status
- osquery baseline collection active on Crostini Arch
- 5-minute pack generation active
- daily health report active
- API and schema contracts scaffolded
- watcher fold-in scaffolding added for endpoint action routing and agent-spawn control

## Generation
- Generate thin clients: `scripts/gen.sh`
- Verify generated artifacts in CI: `scripts/check_gen.sh`

## Watcher Integration
- Event source: `scripts/vps_watcher_event_source.py`
- Guardrail scripts:
  - `scripts/vps_watcher_initial_enrichment_sweep.sh`
  - `scripts/vps_watcher_collect_full_pack.sh`
  - `scripts/vps_watcher_promote_incident.sh`
- Contract notes: `docs/watcher_fold_in_plan.md`
