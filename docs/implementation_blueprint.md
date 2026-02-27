# VPS SecOps Implementation Blueprint

This document extends `docs/proposal.v2.md` with implementation details for:
- spec-schema decisions
- API-spec plan
- sensors and guardrails
- initial automated triage
- agent integration

## 1. Spec-Schema Decisions

### 1.1 Source of Truth
- Canonical source of truth: domain schema for telemetry and decisions.
- Baseline substrate: osquery output (used for baseline behavior phase and periodic recalibration).
- Runtime detection substrate: normalized event contracts from lightweight watchers and network telemetry.

### 1.2 Schema Strategy
- Keep raw data immutable:
  - `raw/*.jsonl` from osquery, DNS, proxy, journald slices.
- Normalize into versioned contracts:
  - `schema_version` required in every artifact.
- Use JSON Schema as validation contract for pack payloads and decision events.

### 1.3 Core Contract Families
- `baseline_pack_v1`: baseline snapshots and metadata.
- `telemetry_event_v1`: normalized event envelope.
- `triage_decision_v1`: machine decision output with confidence/evidence refs.
- `guardrail_action_v1`: automated action intent + result.
- `incident_v1`: promotion artifact.

## 2. API-Spec Plan

### 2.1 Boundary Choice
- OpenAPI: operator-facing control plane.
- Proto (gRPC): internal service-to-service and agent RPC.
- AsyncAPI: event bus contracts (optional at MVP, recommended by Phase 3).

### 2.2 MVP OpenAPI Surface
- `POST /v1/packs/ingest`: ingest and verify pack manifests.
- `GET /v1/packs`: list/filter packs.
- `POST /v1/triage/run`: run initial enrichment sweep for a trigger.
- `POST /v1/incidents/promote`: promote triage result to incident.
- `POST /v1/guardrails/execute`: execute approved automated response.
- `GET /v1/health/pipeline`: pack freshness, gaps, coverage metrics.

### 2.3 Proto Services (Internal)
- `CollectorService`: pull, verify, index.
- `TriageService`: interpret trigger, correlate dependencies, IOC extraction.
- `GuardrailService`: policy evaluation and action dispatch.
- `AgentService`: scoped DFIR playbook execution.

## 3. Sensors and Guardrails

### 3.1 Sensors (Initial)
- Network-plane:
  - VPS resolver query logs
  - WG peer stats
  - optional proxy logs
- Host-plane (Crostini Arch):
  - osquery baseline packs every 5m
  - periodic system snapshots (services, sockets, routes, logs)
- File/config drift:
  - watchctl/inotify over critical paths (`/etc/ssh`, WG, resolver, systemd units, pipeline configs)

### 3.2 Guardrail Classes
- `observe`: log only.
- `warn`: alert + enriched sweep.
- `enforce_safe`: bounded auto-actions only.
- `promote`: incident creation and operator notification.

### 3.3 Safe Automated Actions (Initial)
- force immediate mini-pack/full-pack.
- restart known-safe service units.
- temporary policy block on known bad IOC destinations.
- isolate suspicious workflow path (gated, reversible).

All actions require:
- policy precondition match
- timeout
- result status and evidence reference
- rollback metadata (if applicable)

## 4. Initial Automated Triage

### 4.1 Trigger -> Sweep Flow
1. `interpret_trigger`
2. `validate_codependent_patterns`
3. `identify_ioc`
4. `initial_enrichment_sweep`
5. decision:
   - close as noise
   - monitor
   - promote to agent
   - promote + automated response

### 4.2 Required Triage Output
- `decision`
- `confidence`
- `evidence_refs`
- `iocs`
- `recommended_next_action`
- `rule_id` / `policy_version`

### 4.3 State Model
- Known good states:
  - `BASELINE_OK`
  - `MONITORED_EXPECTED_DRIFT`
- Known bad states:
  - `IOC_CONFIRMED`
  - `POLICY_VIOLATION_CONFIRMED`
  - `INCIDENT_OPEN`
- Transition examples:
  - `BASELINE_OK -> MONITORED_EXPECTED_DRIFT` (low-confidence anomaly)
  - `BASELINE_OK -> IOC_CONFIRMED` (high-confidence IOC + corroboration)
  - `IOC_CONFIRMED -> INCIDENT_OPEN` (promotion criteria met)

## 5. Agent Integration

### 5.1 Invocation Pattern
- Triggered from triage decision.
- Non-interactive, memory-scoped execution.
- Skill-based playbooks with strict allowlists.

### 5.2 Initial Skill Set
- `interpret_trigger`
- `validate_codependent_patterns`
- `identify_ioc`
- `promote_to_incident`
- `run_safe_response` (gated)

### 5.3 Runtime Guardrails for Agent
- command allowlist + denylist
- no destructive ops by default
- strict runtime/resource ceilings
- immutable audit trail (prompt, actions, outputs, hashes)
- explicit approval gate for containment-level actions

### 5.4 Feedback Loop
- Every triage/agent action emits:
  - `outcome_label` (`tp`, `fp`, `needs_tuning`)
  - observed impact
  - confidence delta
- Weekly policy tuning updates suppression thresholds/rules.

## 6. Watcher Daemon Integration

### 6.1 Role
- `watcher` is the endpoint action runtime and spawn controller.
- It consumes normalized trigger events and applies policy gates before any response or agent execution.

### 6.2 Inputs
- osquery-derived baseline drift events
- watchctl/inotify critical-path drift events
- VPS/network-plane anomaly events routed to endpoint policy

### 6.3 Responsibilities
- enforce allowlisted action map
- enforce confidence thresholds and cooldown/rate limits
- execute safe endpoint actions
- emit typed action results (`guardrail_action_v1`)
- gate and launch non-interactive DFIR agent jobs when transition criteria are met

### 6.4 Spawn control contract
- spawn only on policy-approved transitions (for example, `MONITOR -> SUSPICIOUS` or `IOC_CONFIRMED`)
- pass structured context:
  - trigger event ID
  - evidence references
  - policy/rule version
  - execution constraints
- persist immutable audit:
  - invocation metadata
  - command/tool trace
  - outputs + hashes

### 6.5 Initial safe action set via watcher
- `collect_mini_pack`
- `collect_full_pack`
- `restart_service`
- `block_ioc` (gated)
- `isolate_workflow` (high-gate only)

### 6.6 Feedback loop integration
- watcher emits outcome labels and action impact fields for every execution
- policy tuning consumes watcher outputs to update suppression/thresholds and reduce false positives

## 7. Immediate Implementation Order
1. Freeze JSON Schemas for `baseline_pack_v1` and `triage_decision_v1`.
2. Implement `POST /v1/packs/ingest` + manifest verification.
3. Add trigger->sweep pipeline with deterministic JSON output.
4. Wire watchctl guardrails to emit `telemetry_event_v1`.
5. Add incident promotion endpoint + artifact creation.
6. Integrate first agent skill chain in read-only mode.
