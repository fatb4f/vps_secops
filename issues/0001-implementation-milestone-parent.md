# Issue #0001: Implementation Milestone Parent

## Goal
Deliver v1 of the spec-first VPS SecOps pipeline from baseline telemetry through guarded triage and incident promotion.

## Scope
- schema authority and validation workflow
- API surface for ingest/triage/incident/guardrail/health
- sensor event normalization and baseline profiling
- initial automated triage
- agent integration (read-only and gated)

## Child workstreams
- [ ] #0002 Schema pack contracts (`baseline_pack_v1`, `triage_decision_v1`, `guardrail_action_v1`)
- [ ] #0003 OpenAPI surface derived from schemas
- [ ] #0004 Ingest + manifest verification path
- [ ] #0005 Trigger -> enrichment sweep -> decision path
- [ ] #0006 Guardrail executor with safe action allowlist
- [ ] #0007 Incident promotion + evidence indexing
- [ ] #0008 Feedback labels and policy tuning loop

## Exit criteria
- deterministic schema validation in CI
- end-to-end path: trigger -> triage -> action/promote -> artifact commit
- no destructive auto-actions without explicit approval gate
