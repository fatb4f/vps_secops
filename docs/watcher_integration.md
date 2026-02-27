# Watcher Integration Contract Map

This document defines how `watcher` integrates with the VPS SecOps control model.

## 1. Purpose
- Execute endpoint-safe guardrail actions.
- Control DFIR agent spawn based on policy-approved transitions.
- Emit structured feedback for tuning.

## 2. Event Inputs
- `telemetry_event_v1` (normalized trigger envelope)
- osquery-derived baseline drift events
- watchctl/inotify critical path drift events
- VPS-routed anomaly events scoped to endpoint identity

## 3. Decision Gates
Before action/spawn, watcher must validate:
- policy version is current
- action type is allowlisted
- confidence threshold is met
- cooldown window is clear
- target endpoint state allows action

## 4. Action Mapping
Typed action -> endpoint primitive mapping is adapter-owned and deterministic.

Examples:
- `collect_mini_pack` -> run local collector and emit pack ref
- `collect_full_pack` -> run bounded full collector playbook
- `restart_service` -> `systemctl restart <unit>`
- `block_ioc` -> apply DNS/firewall block adapter
- `isolate_workflow` -> gated containment adapter

## 5. Agent Spawn Control
Spawn only when transition policy allows.

Required spawn context:
- `trigger_event_id`
- `evidence_refs[]`
- `policy_version`
- `rule_id`
- execution constraints (timeout/resource limits)

## 6. Required Outputs
Each watcher execution emits:
- `guardrail_action_v1`
- status (`success|failed|skipped`)
- result message
- evidence references
- optional rollback reference

Optional feedback fields:
- `outcome_label` (`tp|fp|needs_tuning`)
- impact summary
- confidence delta

## 7. Safety Constraints
- no destructive actions without explicit high-gate approval
- idempotent action execution where possible
- full execution audit retained (inputs, command trace, outputs, hashes)
