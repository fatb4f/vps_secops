# Spec Authority and Derivation

## Decision
- Host telemetry baseline shape is derived from osquery snapshot structures.
- Canonical contract authority is JSON Schema in `schemas/`.
- API contracts are derived from schema decisions and represented in `api/openapi/openapi.yaml`.

## Rationale
- osquery gives a stable, queryable substrate for baseline behavior.
- JSON Schema is the smallest enforceable contract for pack/event payloads.
- OpenAPI stays aligned to validated payload contracts and avoids dual maintenance drift.

## Change policy
1. Update JSON Schema first.
2. Bump `schema_version` when breaking changes occur.
3. Update OpenAPI references and request/response models.
4. Record migration notes in docs before runtime rollout.
