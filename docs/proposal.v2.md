# VPS SecOps Telemetry Proposal (v2)

## 1. Objectives
- Provide always-on, sustainable telemetry for:
  - Pixel
  - Chromebook (Crostini Arch with systemd)
- Avoid client-side double VPN:
  - clients tunnel to VPS via WireGuard
  - VPS egresses via Mullvad WireGuard
- Support evidence cadence:
  - mini-pack every 5 minutes
  - full-pack every 30-60 minutes
  - on-demand IR full-pack (ephemeral execution over SSH)
- Maintain auditability with immutable workflow history in a VPS-hosted Git repo.

## 2. Topology

### 2.1 Data Plane (Network + Telemetry)
- Pixel: WireGuard full tunnel -> VPS
- Chromebook: WireGuard full tunnel -> VPS, with operational split mode for streaming
- VPS:
  - WireGuard server for client ingress
  - DNS stub resolver with per-client query telemetry
  - optional explicit forward proxy for additional HTTP(S) visibility
  - Mullvad WireGuard as egress for client traffic

### 2.2 Control Plane (Collection + Orchestration)
- Endpoints expose SSH via Cloudflare Tunnel.
- VPS pulls packs via SSH/rsync over Cloudflare-proxied endpoint access.
- VPS verifies, normalizes, diffs, and commits metadata/results.

## 3. VPS Components

### 3.1 WireGuard Intranet
- Interface: `wg-lab0`
- Example subnet: `10.44.0.0/24`
- Addressing:
  - VPS: `10.44.0.1`
  - Pixel: `10.44.0.2`
  - Chromebook: `10.44.0.3`

Client intent:
- Pixel: `AllowedIPs = 0.0.0.0/0, ::/0`, `DNS = 10.44.0.1`
- Chromebook: same default, with explicit operational streaming profile override

### 3.2 Mullvad Egress
- Interface: `wg-mullvad`
- Mullvad is only paid VPN endpoint and lives on VPS only.

### 3.3 Routing and NAT
- Enable IP forwarding.
- Policy-route `10.44.0.0/24` out `wg-mullvad`.
- NAT/MASQUERADE `10.44.0.0/24` out `wg-mullvad`.

### 3.4 DNS Stub Resolver
- Run `unbound` or `dnscrypt-proxy` bound to `wg-lab0`.
- Log per request:
  - timestamp
  - source WG IP
  - qname/qtype/rcode
  - response IPs (if present)
- Enforce DNS path by redirecting client UDP/TCP 53 to resolver.

### 3.5 Optional Forward Proxy
- Run Squid (or equivalent) bound to `wg-lab0`.
- Log:
  - source WG IP
  - CONNECT host:port
  - status + bytes in/out
- Treat as visibility enhancement only, not complete coverage.

### 3.6 VPS Mini-Pack Generation (5m)
Per client, every 5 minutes:
- `dns_events_5m.jsonl`
- `wg_peer_stats.json` (handshake/rx/tx)
- `proxy_events_5m.jsonl` (optional)

## 4. Endpoint Components

### 4.1 Chromebook (Crostini)
Mini-pack every 5 minutes:
- process list
- active sockets (`ss`)
- route snapshot
- last 5 minutes of key journald slices
- new executable candidates in scoped directories + selective hashing

Full-pack every 30-60 minutes:
- broader log slices
- wider filesystem coverage
- Loki/Loki-RS output

### 4.2 Pixel
- No Mullvad on device.
- Primary telemetry source: VPS network telemetry keyed by Pixel WG IP.
- Secondary source for IR only: device exports (bugreport, PCAP).

## 5. Streaming Split-Tunnel Strategy
MVP operational mode:
- Profile A: full tunnel to VPS
- Profile B: streaming mode (no full tunnel)

Rationale:
- Avoid brittle, high-maintenance CDN CIDR exclusions.
- Keep operator burden low.

## 6. Evidence Pack Contract

### 6.1 Cadence
- VPS network mini-pack: every 5m
- Chromebook mini-pack: every 5m
- Chromebook full-pack: every 30-60m
- optional VPS rollup full-pack: hourly

### 6.2 Pack Layout
Each pack directory contains:
- `raw/`
- `meta/`
- `hashes/MANIFEST.sha256`

`meta/` must include:
- `schema_version`
- collection timestamps (start/end UTC)
- device ID
- tool versions
- NTP status/drift
- transport path
- previous pack hash pointer (`chain.json`)

### 6.3 Atomicity
- write in temp dir
- compute manifest
- atomic rename to spool

## 7. Pull/Orchestration Path (Cloudflare MVP)

### 7.1 Transport
- Endpoint SSH daemon local-only.
- Cloudflare Tunnel exposes SSH path without direct inbound host exposure.
- VPS uses scheduled SSH + rsync pulls.

### 7.2 Pull Strategy
- Poll endpoints every 2-5 minutes.
- Pull only new packs.
- Verify manifest on arrival.
- Commit metadata/derived outputs to Git.

Idempotency rule:
- Skip duplicates by pack hash and pack ID.

## 8. IR Trigger Path (Ephemeral)
- Execute remote playbook over stdin only:
  - `ssh endpoint 'bash -s' < ir_playbook.sh`
- Produce `*_ir` full-pack with manifest + metadata.
- Pull, verify, analyze, commit.

Safe defaults:
- read-only collection by default
- bounded PCAP only when explicitly enabled
- containment actions manual or separately gated

## 9. Threat Model and Coverage
Detects well:
- DNS-based beaconing and suspicious resolution patterns
- network behavior changes by endpoint identity
- process/socket/log anomalies on Chromebook

Limited coverage:
- encrypted app-layer content not visible via DNS/proxy metadata
- endpoint-only artifacts on Pixel unless explicit IR export is collected
- bypasses outside VPN profile when device is in streaming/direct mode

## 10. Reliability and Failure Modes

### 10.1 Failure Policies
- Mullvad down:
  - default: fail-closed for client egress
  - alert on egress path violation
- Cloudflared endpoint down:
  - mark endpoint stale, preserve last-good state, alert
- resolver down:
  - alert critical; reject direct DNS bypass where policy allows

### 10.2 Time Sync SLO
- NTP drift budget: <= 2s target, > 5s warning, > 15s critical.
- Include drift in pack metadata and health checks.

## 11. Identity, Access, and Key Lifecycle
- Stable endpoint IDs, decoupled from hostname.
- SSH key/cert rotation cadence documented (for example, 30-90 days).
- Explicit revocation path for compromised endpoint credentials.
- Cloudflare Access policy is deny-by-default with explicit allow lists.

## 12. Storage and Retention
- Git stores:
  - manifests
  - metadata
  - normalized outputs
  - diffs/alerts
- Raw heavy artifacts:
  - rotated archive/object storage outside primary Git history
- Retention policy (minimum recommendation):
  - hot raw logs: 7-14 days
  - normalized summaries: 90+ days
  - manifests/chains: long-term

## 13. Implementation Plan and Acceptance Criteria

### Phase 1: VPS Core (Day 1)
Deliver:
- `wg-lab0` + `wg-mullvad`
- forwarding + NAT + policy routing
- resolver with query logging
- VPS 5m mini-pack generation

Acceptance:
- clients browse through Mullvad egress only
- DNS logs show per-client source IP and query records
- mini-pack appears every 5m with valid manifest

### Phase 2: Endpoint Plumbing (Day 1-2)
Deliver:
- Cloudflare-exposed endpoint SSH path
- Crostini mini-pack timer
- VPS pull/verify/commit flow

Acceptance:
- VPS pulls new endpoint mini-packs without duplicates
- manifest verification failures are detected and alerted
- Git commit trail shows deterministic periodic updates

### Phase 3: Analysis and IR (Day 2-3)
Deliver:
- normalization + diff pipeline
- thresholded anomaly triggers
- scheduled full-pack + IR on-demand path

Acceptance:
- detectable change in test telemetry generates alert + diff artifact
- IR run creates `*_ir` pack and end-to-end pull/commit
- no persistent IR scripts left on endpoint

## 14. VPS Sizing Guidance
- light usage, no streaming tunnel: `2 vCPU / 2 GB`
- moderate usage and parsing comfort: `2 vCPU / 4 GB`
- storage start point: ~80 GB if retaining local history + logs

## 15. Final Deliverables
- Always-on Pixel telemetry via VPS network-plane logs
- Crostini endpoint evidence packs + periodic scan outputs
- VPS-hosted auditable history (manifests, metadata, diffs)
- Ephemeral IR execution path with minimal endpoint residue

## 16. Implementation Blueprint
Detailed implementation decisions and scaffolding guidance live in:
- `docs/implementation_blueprint.md`
