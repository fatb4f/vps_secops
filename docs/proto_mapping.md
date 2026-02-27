# Proto Mapping Notes

`api/proto/security_model.proto` expresses the OS security operating model at the control-contract level:
- observable baseline state (osquery-derived snapshot events)
- triage decision contracts
- guardrail action contracts
- incident lifecycle contracts

It intentionally does not attempt to model full OS internals.

## Authority order
1. JSON Schemas in `schemas/`
2. OpenAPI in `api/openapi/openapi.yaml`
3. Proto in `api/proto/security_model.proto`

Proto should remain semantically aligned with schema and OpenAPI contracts.
