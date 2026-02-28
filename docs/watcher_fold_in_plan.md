# Watcher Fold-In Plan

## Goal
Make watcher the endpoint execution and agent-spawn control runtime for vps_secops.

## Current wiring
- Event source: `scripts/vps_watcher_event_source.py`
- Guardrail scripts:
  - `scripts/vps_watcher_initial_enrichment_sweep.sh`
  - `scripts/vps_watcher_collect_full_pack.sh`
  - `scripts/vps_watcher_promote_incident.sh`
- watcher profile: `watcher/config/profiles_vps_secops.yaml`
- watcher daemon wrapper: `watcher/bin/vps-secops-watcher-daemon`

## Next steps
1. Define strict allowlist and cooldown policy in watcher profile.
2. Emit `guardrail_action_v1` JSON results from guardrail scripts.
3. Add incident artifact indexing hook after promotion.
4. Add systemd user unit to run `vps-secops-watcher-daemon` persistently.
