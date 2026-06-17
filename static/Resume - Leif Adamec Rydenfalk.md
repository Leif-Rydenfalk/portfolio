**Leif Adamec Rydenfalk**
Umeå, Sweden

[ledamecrydenfalk@gmail.com](mailto:ledamecrydenfalk@gmail.com) | [LinkedIn](https://www.linkedin.com/in/leif-adamec-rydenfalk-5b269a261/) | [GitHub](https://github.com/Leif-Rydenfalk) | [adamec.me](https://adamec.me)

---

**Summary**

Software engineer who ships end-to-end — from zero-copy Rust runtimes and real-time GPU renderers to multi-platform SaaS products. Equally at home in deep systems work (a 1.48M-msg/s distributed substrate, a P2P compute economy) and in shipping polished products solo (a marketplace and an EdTech SaaS, both live in production). Self-taught; learns from first principles and builds the whole stack.

---

**Experience**

**Systems Engineer – Internal AI Tools** | Gaming Studio | Umeå, Sweden
*March 2025 – Present*

- Built and shipped an autonomous "time-guardian" tool in Rust (Axum/Tokio) that ingests employee time reports from Fortnox, analyzes them against company policy with an LLM, and nudges employees over Slack — turning a manual, multi-day reconciliation chore into a self-running service.
- Reduced payroll reconciliation time from ~3 days to ~30 minutes; the service runs unattended with automatic OAuth token refresh and autonomous Fortnox↔Slack identity mapping.
- Secured an admin dashboard behind Google OAuth; wrote property-based tests for the validation engine that caught 11 edge-case bugs pre-production.
- Deployed from a locally hosted Mac Mini via Cloudflare Tunnels with zero downtime in production.

**Independent Software Engineer / Founder** | Rydenfalk Systems | Umeå, Sweden
*February 2025 – Present*

- **Myra / Trana** ([trana.app](https://trana.app)) — designed and built an AI lesson-material SaaS for Swedish upper-secondary teachers, solo. One TypeScript monorepo (Turborepo, pnpm) ships four clients from shared packages: web (TanStack Start + React 19 on Cloudflare Workers), landing (Astro on Cloudflare Pages), mobile (Expo/React Native, App Store + Play Store), and desktop (Electron). Supabase backend with row-level security; full test pyramid (Vitest, Playwright, pgTAP, Deno) and per-app CI/CD.
- **Cell** — a biologically-inspired distributed computing substrate in Rust: sandboxed processes ("cells") exchange zero-copy, `rkyv`-archived messages over Unix sockets. Sustains **1.48M messages/sec at ~677ns median RTT on a single core**, with an embeddable Raft consensus layer and a 9M-TPS market-simulation benchmark. Underpins **CE**, a peer-to-peer compute economy (libp2p NAT traversal, custom PoW credit ledger, gVisor sandboxing) with a public relay at ce-net.com, packaged for Homebrew, AUR, Scoop, and Chocolatey.
- **OpenJaws** — a distributed "cell mesh" platform (TypeScript + Rust) where self-discovering cells gossip-sync a shared atlas and expose 100% type-safe capabilities through a router/procedure API. Add a directory with a `Cell.toml`, it joins the mesh; remove it, the mesh heals — zero service-mesh configuration.
- **Blueberry Browser** — an Electron/Chromium browser that exposes a Model Context Protocol (MCP) server, letting AI agents operate a real, logged-in session like a human. Used daily to automate Gmail, WhatsApp Web, and LinkedIn with no per-site integrations. Went from concept to daily-use tool in two weeks.

**Full-Stack Contractor** | Self Employed | Umeå, Sweden
*January 2024 – May 2025*

- Delivered commercial codebases (SvelteKit + Node.js + PostgreSQL) with CI/CD via GitHub Actions.
- Integrated Stripe Connect for split payments and handled PCI-sensitive flows via Stripe webhooks.
- Containerized all services with Docker; dev–prod parity under a 2-minute cold start on a new machine.
- Built a personalized feed-generation algorithm driven by user attributes.

---

**Selected Projects**

**Myra / Trana** — [trana.app](https://trana.app)
AI lesson-material SaaS for Swedish teachers. Single TypeScript monorepo → web, landing, mobile, and desktop from shared `ui`/`config` packages. TanStack Start + React 19, Astro, Expo, Electron, Supabase (RLS, Edge Functions). Tested with Vitest, Playwright, and pgTAP; shipped through per-app CI/CD to Cloudflare, the App Store/Play Store, and GitHub Releases.

**Rheo** — [rheo.se](https://rheo.se)
Mobile-first resale marketplace, ~2M lines of Rust. Axum services, React Native client, PostgreSQL, Redis Streams, Stripe Connect, PostNord shipping, Cloudflare R2. Multi-currency design with a per-listing "anchor currency" so prices never drift from what the seller chose. Three independent monitoring layers (in-process Sentinel + a Cloudflare Worker + a Hetzner systemd timer) that fail independently and alert over email/Telegram. p95 ~78ms on a 256MB container; blue-green deploys.

**Cell / CE** — [github.com/Leif-Rydenfalk/cell](https://github.com/Leif-Rydenfalk/cell)
Biologically-inspired distributed substrate in Rust — "cells," "membranes," "vesicles," "synapses." Zero-copy `rkyv` messaging at 1.48M msg/s / ~677ns RTT, embeddable Raft consensus, `#[protein]` codegen macros. Foundation for CE, a P2P compute economy (libp2p, PoW credit ledger, gVisor sandboxing).

**OpenJaws + Cell Mesh Protocol** — [github.com/Leif-Rydenfalk/openjaws](https://github.com/Leif-Rydenfalk/openjaws)
Distributed cell-mesh runtime. Sovereign cells self-discover via gossip-based atlas sync, self-replicate via `Cell.toml`, and expose typed RPC with Ed25519 capability proofs. Reference SDK open-sourced as `cell-mesh-protocol-1`.

**Blueberry Browser** — [github.com/Leif-Rydenfalk/blueberry-browser](https://github.com/Leif-Rydenfalk/blueberry-browser)
Electron browser with a built-in MCP server. AI agents delegate real web-UI tasks (clicks, form fills, reads) to a live, logged-in Chromium session — no per-site integrations or API tokens.

**Voxel Game Engine** — [github.com/Leif-Rydenfalk/game-engine](https://github.com/Leif-Rydenfalk/game-engine)
Rust/wgpu engine as a Cargo workspace: a reusable engine library (render graph, ECS via `hecs`, hot-reloaded WGSL shaders, audio, input) driving a SDF-voxel ray-traversal renderer with TAA, bloom, and atmospheric scattering at 60 FPS on Apple A15/M1 — plus a separate N-body orbital ("spacetime") simulator on the same engine.

**Also:** Dream Engine (real-time biologically-inspired neuron/learning sim, 90 FPS on a GTX 1060), Mariana (zero-dependency streaming LLM reasoning console), CaptureFlow (production AI assistant with web + Telegram), a chess engine, and a deep back-catalog of graphics/simulation experiments in Rust and C++.

---

**Skills**

- **Languages:** Rust (advanced), TypeScript, JavaScript, Python, SQL, WGSL, C, C++
- **Backend:** Axum, Tokio, Node.js, REST/WebSockets, microservices, Redis Streams, PostgreSQL, Supabase
- **Frontend:** SvelteKit, React/React 19, React Native (Expo), TanStack Start, Astro, Dominator, Electron, Tailwind CSS
- **Distributed Systems:** libp2p, PoW blockchain, Raft consensus, gossip protocols, zero-copy IPC (rkyv), Ed25519 identity, NAT traversal
- **Graphics:** wgpu, WGSL shaders, SDF/ray-marching, voxel traversal, ECS (hecs), TAA, bloom, render graphs
- **AI / Agents:** MCP (Model Context Protocol), Claude & Gemini APIs, LLM tool-use, Chromium/Electron automation
- **Infrastructure:** Docker, gVisor, Cloudflare (Workers, Pages, Tunnels, R2), Hetzner, Railway, GitHub Actions, blue-green deploys, package distribution (Homebrew, AUR, Scoop, Chocolatey)
- **Testing:** TDD, property-based testing, Playwright/Vitest E2E, pgTAP, integration testing

---

**Education**

Self-taught.

---

**References**

Available on request.
