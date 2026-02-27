Architecture and Implementation Document
1) Objectives

Provide always-on, sustainable telemetry for:

Pixel

Chromebook (Crostini Arch w/ systemd)

Avoid double-VPN on clients:

clients tunnel to VPS via WireGuard

VPS egresses via Mullvad WireGuard

Support:

mini-pack every 5 minutes

full-pack every 30–60 minutes

IR full-pack on-demand (ephemeral, executed over SSH; no persistent playbooks on endpoints)

Maintain auditability:

Git repository hosted on the VPS

2) High-level topology
Data plane (network + telemetry)

Pixel: WireGuard full-tunnel → VPS

Chromebook: WireGuard full-tunnel → VPS, with split-tunnel for streaming

VPS:

WireGuard server for clients

DNS stub resolver (logs per client)

Optional forward proxy (logs per client)

Mullvad WireGuard client used as egress for client traffic

Control plane (collection/orchestration)

Endpoints run cloudflared exposing local SSH

VPS pulls endpoint evidence packs over SSH/rsync via Cloudflare tunnel

3) VPS components
3.1 WireGuard server (intranet)

Interface: wg-lab0

Example subnet: 10.44.0.0/24

VPS: 10.44.0.1

Pixel: 10.44.0.2

Chromebook: 10.44.0.3

Client profiles:

Pixel: AllowedIPs = 0.0.0.0/0, ::/0, DNS = 10.44.0.1

Chromebook: same, plus split-tunnel approach (below)

3.2 Mullvad egress (WireGuard client)

Interface: wg-mullvad

Mullvad is the only paid VPN; runs on VPS, not on clients.

3.3 Routing and NAT (core requirement)

Enable IP forwarding on VPS

Policy routing: traffic from 10.44.0.0/24 egresses via wg-mullvad

NAT/MASQUERADE 10.44.0.0/24 out wg-mullvad

3.4 DNS stub resolver (high-signal telemetry)

Run unbound or dnscrypt-proxy on VPS

Bind to wg-lab0 address

Log:

timestamp

client IP (WG client)

qname/qtype/rcode

response IPs (when applicable)

Enforcement:

Redirect any client DNS attempts to local resolver (UDP/TCP 53)

3.5 Optional HTTP(S) forward proxy (extra telemetry)

Run Squid (or equivalent) on VPS, bound to wg-lab0

Logs:

client IP

CONNECT host:port

bytes in/out, status

Notes:

Proxy is optional and not required for connectivity (routing/NAT handles that).

Some apps bypass explicit proxies; treat as “visibility enhancement,” not coverage.

3.6 Log slicing into mini-packs (VPS-side)

Every 5 minutes, VPS generates per-client mini-pack slices:

dns_events_5m.jsonl

wg_peer_stats.json (handshake + rx/tx)

optional proxy_events_5m.jsonl

These are highly diffable and are your primary Pixel telemetry.

4) Endpoint components
4.1 Chromebook (Crostini Arch + systemd)

Purpose: endpoint-side evidence to complement network-plane telemetry.

Mini-pack (every 5 minutes)

Recommend a timed Python snapshot script (cheap and deterministic), capturing:

process list

active sockets (ss)

routing

last 5 minutes of journald (or key unit logs)

“new executable candidates” in a small directory set with selective hashing

Full-pack (every 30–60 minutes)

Adds:

broader log slices

more filesystem coverage

Loki/Loki-RS scan output (run on Crostini Linux-side)

Loki on Crostini is appropriate for Linux environment triage.

4.2 Pixel

No Mullvad on Pixel. Pixel tunnels to VPS for full traffic.

Pixel telemetry sources

Primary: VPS DNS logs (and optional proxy logs) keyed by Pixel WG IP

Secondary: on-device exports only when needed (bugreport/PCAP) for specific IR cases

5) Chromebook split-tunneling for streaming (recommended MVP approach)
MVP: two WireGuard profiles

Profile A (default): full-tunnel to VPS

Profile B (streaming): disable WG or use a profile that does not full-tunnel (direct egress)

Operationally:

switch profiles only when streaming

avoids brittle maintenance of CDN IP ranges

Why not CIDR exclusions?

streaming CDNs change frequently; IP allowlists become a maintenance burden.

If you later want automated split-tunnel, do it by:

app-based split tunneling (if supported), or

policy routing with maintainable endpoint lists (higher complexity).

6) Evidence packs
6.1 Mini-pack cadence

VPS network mini-packs: every 5 minutes

Chromebook endpoint mini-packs: every 5 minutes

6.2 Full-pack cadence

Chromebook endpoint full-pack: every 30–60 minutes

VPS can also produce “full” network packs (hourly rollups)

6.3 Format (common)

Each pack directory contains:

raw/ (raw logs/snapshots)

meta/ (timestamps, device id, tool versions, NTP status, transport path)

hashes/MANIFEST.sha256

Atomicity:

write to temp directory

compute manifest

atomic rename into spool

Chainability (recommended):

include previous pack hash pointer in meta/chain.json

7) VPS pull/orchestration (Cloudflare MVP)
7.1 Transport

Endpoint sshd bound to localhost

cloudflared exposes SSH via Cloudflare Tunnel (control + data)

VPS runs scheduled pulls using ssh + rsync

Cloudflare Tunnel is outbound-only and avoids public inbound exposure.

7.2 Pull strategy

VPS polls endpoints at 2–5 minute intervals for “new pack directories”

Pull only new packs (rsync)

Verify manifest

Commit into Git-on-VPS

8) IR triggers (ephemeral playbooks, no persistent residue)
Requirement

You don’t want IR scripts left on endpoints.

Execution method (MVP)

VPS runs ephemeral script via stdin:

ssh endpoint 'bash -s' < ir_playbook.sh

Script creates an *_ir full-pack directory, writes metadata, manifest, prints pack path

VPS pulls pack, commits, runs diff/analysis

For tools requiring a file path:

drop into /dev/shm, execute, delete (tmpfs-only)

IR actions (safe defaults)

read-only collection

time-bounded pcap only if explicitly enabled

Loki/Loki-RS scan on Crostini during full-pack/IR

Containment actions remain manual or gated.

9) Implementation sequence (minimal risk)
Phase 1 — VPS core (day 1)

Bring up VPS

Configure:

wg-lab0 server

Mullvad WG client (wg-mullvad)

forwarding + NAT + policy routing for 10.44.0.0/24 out Mullvad

Deploy DNS stub with query logging

Generate VPS mini-packs every 5 minutes

Phase 2 — Endpoint plumbing (day 1–2)

cloudflared tunnel + localhost sshd + restricted user on Chromebook Crostini

mini-pack timer on Crostini

VPS pulls + verifies + commits

Phase 3 — Analysis automation (day 2–3)

VPS normalization + diff pipeline for mini-packs

thresholds → IR trigger

full-pack schedule + Loki/Loki-RS integration

10) What to size VPS for (rule of thumb)

If you do not tunnel streaming: 2 vCPU / 2 GB can work for MVP.

If you expect heavier browsing + more parsing: 2 vCPU / 4 GB is more comfortable.

Disk:

start at 80 GB if you will keep history + logs locally

or start smaller and rotate aggressively + keep Git history only for derived outputs

Deliverables you’ll end up with

Always-on Pixel telemetry via VPS DNS/proxy logs (per WG IP)

Crostini endpoint packs + Loki scan outputs

VPS-hosted Git repo: immutable history of evidence packs + analysis diffs

IR trigger mechanism that leaves no scripts behind
