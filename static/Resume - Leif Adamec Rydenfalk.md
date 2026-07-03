**Leif Adamec Rydenfalk**
Umeå, Sweden

[ledamecrydenfalk@gmail.com](mailto:ledamecrydenfalk@gmail.com) | [LinkedIn](https://www.linkedin.com/in/leif-adamec-rydenfalk-5b269a261/) | [GitHub](https://github.com/Leif-Rydenfalk) | [adamec.me](https://adamec.me)

---

**Summary**

Systems engineer and founder who builds the systems companies usually rent — and operates them in production. Currently running a peer-to-peer compute mesh with its own credit economy (70+ services, live paid workloads), a resale marketplace with full payment flows, distributed LLM inference across a heterogeneous fleet, and a multi-platform AI SaaS. Ships 500k+ lines of production Rust/TypeScript a year solo by engineering the development process itself around fleets of AI agents. Self-taught; learns from first principles and builds the whole stack — from sub-microsecond IPC to payment settlement to the deploy pipeline.

---

**Experience**

**Systems Engineer – Internal AI Tools** | Gaming Studio | Umeå, Sweden
*March 2025 – Present*

- Built and shipped an autonomous "time-guardian" tool in Rust (Axum/Tokio) that ingests employee time reports from Fortnox, analyzes them against company policy with an LLM, and nudges employees over Slack — turning a manual, multi-day reconciliation chore into a self-running service.
- Reduced payroll reconciliation time from ~3 days to ~30 minutes; the service runs unattended with automatic OAuth token refresh and autonomous Fortnox↔Slack identity mapping.
- Secured an admin dashboard behind Google OAuth; wrote property-based tests for the validation engine that caught 11 edge-case bugs pre-production.
- Deployed via Cloudflare Tunnels with zero downtime in production.

**Founder / Systems Engineer** | Rydenfalk Systems | Umeå, Sweden
*February 2025 – Present*

- **CE / ce-net** ([ce-net.com](https://ce-net.com)) — designed, built, and operate a peer-to-peer compute mesh and economy: run a node, donate compute, earn credits, spend them on other people's machines. Every node is assumed hostile — Ed25519 identity, signed capability chains as the only trust primitive (attenuation, revocation), a PoW credit ledger with escrow and payment channels, and gVisor-sandboxed workloads. The paid compute economy is live: usage is metered, admitted, and settled across a multi-machine fleet (Hetzner relay, GPU workstation, laptops, in-browser WASM nodes). Packaged for Homebrew, AUR, Scoop, and Chocolatey.
- Built **70+ services on the mesh** rebuilding Google-class infrastructure as apps over one SDK: S3-class object storage, a Firestore-class realtime document DB, GKE-style container orchestration, pub/sub with durable replay, CDN, serverless functions, IAM with passwordless device pairing, distributed CI, and ngrok-style capability-gated tunnels.
- **Distributed LLM inference** — ce-exo serves large models across the heterogeneous fleet by wrapping production engines (vLLM, llama.cpp, exo, Ollama) behind one OpenAI-compatible API with NAT-traversing transport and capability-gated access; ce-tabnet shards a transformer layer-by-layer across browser tabs (pipeline-parallel WebGPU inference). Also designed a clinical deployment where inference runs on hospital GPUs and PHI never leaves the LAN.
- **Myra / Trana** ([trana.app](https://trana.app)) — an AI lesson-material SaaS for Swedish upper-secondary teachers. One TypeScript monorepo ships four clients (web, mobile via App Store/Play Store, desktop, landing) from shared packages; Supabase backend with row-level security; full test pyramid wired into per-app CI/CD.
- **Blueberry Browser** — an Electron/Chromium browser exposing an MCP server so AI agents operate a real, logged-in session like a human; automates Gmail, WhatsApp Web, and LinkedIn with no per-site integrations.
- Engineer the development process itself around fleets of parallel AI agents — recorded conventions, shared findings backlogs, remote build offloading, reproduce-first bug methodology — sustaining 500k+ production lines a year, solo. Foundation: **Cell**, a zero-copy Rust substrate sustaining 1.48M messages/sec at ~677ns median RTT on a single core, with embeddable Raft.

**Full-Stack Contractor** | Self Employed | Umeå, Sweden
*January 2024 – May 2025*

- Delivered commercial codebases (SvelteKit + Node.js + PostgreSQL) with CI/CD via GitHub Actions.
- Integrated Stripe Connect for split payments and handled PCI-sensitive flows via Stripe webhooks.
- Containerized all services with Docker; dev–prod parity under a 2-minute cold start on a new machine.
- Built a personalized feed-generation algorithm driven by user attributes.

---

**Selected Projects**

**CE / ce-net** — [ce-net.com](https://ce-net.com)
Peer-to-peer compute mesh and economy in Rust. libp2p (Kademlia, Gossipsub, circuit relay, hole punching), PoW credit ledger with integer base-unit money, escrowed job settlement, payment channels with off-chain receipts, capability-chain IAM, gVisor sandboxing. 70+ services rebuild cloud infrastructure as mesh apps. Live paid economy across a real multi-machine fleet.

**ce-exo + ce-tabnet** — [github.com/ce-net/ce-exo](https://github.com/ce-net/ce-exo)
Distributed LLM inference. ce-exo: one OpenAI-compatible API over a NAT-traversing mesh, wrapping vLLM / llama.cpp / exo / Ollama — one command deploys an engine to a GPU machine and routes chat traffic to it from anywhere, capability-authed. ce-tabnet: a transformer sharded layer-by-layer across browser tabs — pipeline-parallel WebGPU inference.

**Rheo** — [rheo.se](https://rheo.se)
Mobile-first resale marketplace in Rust. Axum services, React Native client, PostgreSQL, Redis Streams, Stripe Connect (onboarding, escrowed split payments via webhooks), PostNord shipping, Cloudflare R2. Multi-currency with a per-listing "anchor currency" so prices never drift from what the seller chose. Three fail-independent monitoring layers (in-process sentinel + Cloudflare Worker + Hetzner systemd timer) alerting over email/Telegram. p95 ~78ms on a 256MB container; blue-green deploys.

**Myra / Trana** — [trana.app](https://trana.app)
AI lesson-material SaaS for Swedish teachers. Single TypeScript monorepo → web (TanStack Start + React 19 on Cloudflare Workers), landing (Astro), mobile (Expo), desktop (Electron) from shared packages. Supabase (RLS, Edge Functions); Vitest, Playwright, pgTAP; per-app CI/CD to Cloudflare, the App Store/Play Store, and GitHub Releases.

**Spacegame** — [github.com/ce-net/spacegame](https://github.com/ce-net/spacegame)
Browser multiplayer with no game server: every player's browser runs the full authoritative simulation (Rust → WASM + WebGL2) and peers merge state by quorum — replicated authority instead of client-server. Zero-delay prediction, per-RTT update rates, population-driven persistence. Deploys gated on a live browser smoke test of the production path.

**Blueberry Browser** — [github.com/Leif-Rydenfalk/blueberry-browser](https://github.com/Leif-Rydenfalk/blueberry-browser)
Electron browser with a built-in MCP server. AI agents delegate real web-UI tasks (clicks, form fills, reads) to a live, logged-in Chromium session — no per-site integrations or API tokens.

**Voxel Game Engine** — [github.com/Leif-Rydenfalk/game-engine](https://github.com/Leif-Rydenfalk/game-engine)
Rust/wgpu engine: render graph, ECS via `hecs`, hot-reloaded WGSL shaders, SDF-voxel ray traversal with TAA, bloom, and atmospheric scattering at 60 FPS on Apple A15/M1.

**Also:** Cell (zero-copy distributed substrate, 1.48M msg/s), OpenJaws (typed self-discovering cell mesh), Cerena (10k-player distributed RPG, in progress), ce-cast (distributed live-streaming studio), Dream Engine (real-time neuron/learning sim), Mariana (streaming LLM reasoning console), and a deep back-catalog of graphics/simulation work in Rust and C++.

---

**Skills**

- **Languages:** Rust (advanced), TypeScript, JavaScript, Python, SQL, WGSL, C, C++
- **Distributed Systems:** libp2p (DHT, gossip, NAT traversal), PoW ledgers, Raft consensus, capability security (attenuation/revocation), zero-copy IPC (rkyv), shared-memory transports, BFT design, Sybil resistance
- **LLM / AI Infrastructure:** distributed inference across heterogeneous fleets, pipeline parallelism, WebGPU inference, quantized serving (GGUF), vLLM, llama.cpp, exo, Ollama, OpenAI-compatible API design, LLM tool-use in production, MCP, multi-agent engineering workflows
- **Financial Systems:** Stripe Connect (onboarding, escrow, split payouts, webhooks), credit ledger design (integer base units, supply caps, halving), payment channels and off-chain settlement, usage metering and admission control, multi-currency pricing
- **Backend:** Axum, Tokio, Node.js, REST/WebSockets, microservices, Redis Streams, PostgreSQL, Supabase
- **Frontend:** SvelteKit, React/React 19, React Native (Expo), TanStack Start, Astro, Electron, Tailwind CSS
- **Graphics:** wgpu, WGSL shaders, SDF/ray-marching, voxel traversal, ECS (hecs), TAA, bloom, render graphs
- **Infrastructure & Ops:** Cloudflare (Workers, Pages, Tunnels, R2, DNS), Hetzner, Docker, gVisor, systemd fleets, blue-green deploys, deploy smoke gates, fail-independent monitoring, GitHub Actions, cross-platform release CI, package distribution (Homebrew, AUR, Scoop, Chocolatey)
- **Testing:** TDD, property-based testing, reproduce-first bug methodology, Playwright/Vitest E2E, pgTAP, live multi-node e2e harnesses

---

**Education**

Self-taught.

---

**References**

Available on request.
