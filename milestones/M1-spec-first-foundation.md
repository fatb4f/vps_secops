# Milestone M1: Spec-First Foundation

## Objective
Lock schema authority and API contracts before scaling runtime automation.

## Deliverables
- canonical JSON schemas committed and versioned
- OpenAPI generated/maintained from schema decisions
- ingestion and validation stubs
- triage and guardrail contract stubs

## Acceptance criteria
- schema changes require version bump and changelog entry
- OpenAPI validates against schema references
- pack ingest rejects contract-invalid payloads
