# VPS SecOps Telemetry Proposal (Executive Summary)

This document is the decision summary.
The canonical implementation spec is:
- `docs/proposal.v2.md`
- `docs/implementation_blueprint.md`

## Decision
Implement a two-plane telemetry architecture:
- Data plane: Pixel/Chromebook -> VPS over WireGuard; VPS egress via Mullvad WireGuard.
- Control plane: VPS pulls endpoint evidence packs over Cloudflare-exposed SSH.

## Scope
- Always-on telemetry for Pixel and Chromebook (Crostini).
- Evidence cadence:
  - mini-pack every 5 minutes
  - full-pack every 30-60 minutes
  - on-demand IR full-pack via ephemeral remote execution
- Auditability through VPS-hosted Git history of manifests/metadata/diffs.

## Key Constraints
- No double VPN on clients.
- No persistent IR playbooks on endpoints.
- Streaming split mode should be operationally simple (profile switching, not fragile CIDR exclusions).

## Delivery Plan
- Phase 1: VPS core networking, resolver logging, 5-minute network mini-packs.
- Phase 2: endpoint pack timers + VPS pull/verify/commit loop.
- Phase 3: normalization/diff/trigger pipeline + scheduled full-packs + IR path.

## Acceptance Gate
Production-readiness requires successful acceptance criteria for each phase defined in:
- `docs/proposal.v2.md`

## Notes
- For implementation details (routing/NAT, pack schema, failure modes, retention, key lifecycle), use v2 only.
- Any future changes should be made in `docs/proposal.v2.md`; this file remains a stable summary.
