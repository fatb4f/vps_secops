# Playbook Standards

This document defines the response model used by `vps_secops`.

## 1. Canonical Standards
- Playbook structure: CACAO-aligned YAML.
- Response taxonomy: RE&CT technique mapping for every executable step.
- Runtime output: `guardrail_action_v1` with CACAO and RE&CT references.

## 2. Action Contract Requirements
Every executable playbook step must define:
- `step_id` (CACAO step identity)
- `action_type` (typed and allowlisted)
- `rect_technique_id` (response technique reference)
- `preconditions`
- `timeout`
- `approval_level` (`auto|operator|required_high_gate`)
- `rollback` (if reversible)

## 3. Containment Policy (Two-host Deployment)
- `contain_soft`:
  - primary action: DNS sinkhole for confirmed malicious domains
  - objective: disrupt domain-based egress while preserving telemetry
- `contain_medium`:
  - primary action: enforce Mullvad lockdown/killswitch profile
  - objective: restrict outbound traffic to explicit allowlist only
- `contain_hard`:
  - primary action: isolate workflow/host network path
  - objective: stop active activity pending operator decision

## 4. Minimum Playbooks
Initial required playbooks:
1. `initial_enrichment_sweep`
2. `host_scope_and_timeline`
3. `gated_containment_host_isolation`

## 5. Validation Rules
CI must fail when:
- playbook step is missing RE&CT mapping
- `action_type` is not in watcher allowlist
- high-gate actions lack approval metadata
- contract examples do not validate against JSON Schema
