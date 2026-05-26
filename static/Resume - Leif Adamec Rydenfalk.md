**Leif Adamec Rydenfalk**
Umeå, Sweden

[ledamecrydenfalk@gmail.com](mailto:ledamecrydenfalk@gmail.com) | [LinkedIn](https://www.linkedin.com/in/leif-adamec-rydenfalk-5b269a261/) | [GitHub](https://github.com/Leif-Rydenfalk) | [adamec.me](https://adamec.me)

---

**Summary**

Systems engineer with deep Rust experience across backends, distributed systems, and real-time graphics. Built a peer-to-peer compute mesh (CE), a distributed cell mesh platform (OpenJaws), an AI-agent browser runtime (Blueberry), and a production marketplace (Rheo). Self-taught; learns from first principles.

---

**Experience**

**Systems Engineer – Internal AI Tools** | Gaming Studio | Umeå, Sweden
*March 2025 – Present*

- Built a Rust full-stack application (Axum backend, Dominator frontend) that ingests work-hours from Slack and syncs them to Fortnox, flagging financial discrepancies before payroll runs.
- Reduced payroll reconciliation time from 3 days to 30 minutes.
- Deployed via Cloudflare Tunnels from a locally hosted Mac Mini; zero downtime in production.
- Wrote property-based tests for the validation engine; caught 11 edge-case bugs pre-production.

**Independent Systems Engineer** | Rydenfalk Systems | Umeå, Sweden
*February 2025 – Present*

- Built **CE** ("Sea") — a peer-to-peer compute mesh and economy in Rust. libp2p for NAT-traversing P2P, custom PoW blockchain for credit accounting, Docker/gVisor for sandboxed workload execution. Public relay at ce-net.com. Distributed via Homebrew, AUR, Scoop, and Chocolatey.
- Designed **OpenJaws** — a distributed cell mesh platform in TypeScript/Rust where self-discovering 'cells' gossip-sync a shared atlas and expose 100% type-safe capabilities via a router/procedure API. Zero service-mesh configuration.
- Shipped **Blueberry Browser** — an Electron app that exposes an MCP server so AI agents can operate a real, logged-in Chromium session. Used daily for Gmail, WhatsApp Web, and LinkedIn automation. No per-site integrations.
- Built a voxel rendering engine in Rust (wgpu) with ECS (hecs), SDF-voxel ray traversal, TAA, bloom, and atmospheric scattering. 60 FPS on Apple A15 and M1.

**Full-Stack Contractor** | Self Employed | Umeå, Sweden
*January 2024 – May 2025*

- Delivered three commercial codebases (SvelteKit + Node.js + PostgreSQL) with CI/CD via GitHub Actions.
- Integrated Stripe Connect for split payments; handled PCI compliance via Stripe webhooks.
- Containerized all services with Docker; dev-prod parity under 2 min cold start.
- Built personalized feed generation algorithm based on user attributes.

---

**Projects**

**Rheo** — [rheo.se](https://rheo.se)
Mobile-first resale marketplace. Rust/Axum microservices, React Native client, PostgreSQL, Redis Streams, Stripe Connect. p95 server response 78ms on a 256MB container. Blue-green deployments via Docker + GitHub Actions + Cloudflare Tunnels.

**CE** — [github.com/ce-net/ce](https://github.com/ce-net/ce)
P2P compute mesh and economy in Rust. Every node donates compute, earns credits, spends them on distributed workloads. libp2p, PoW blockchain, Docker/gVisor sandboxing.

**OpenJaws** — [github.com/Leif-Rydenfalk/openjaws](https://github.com/Leif-Rydenfalk/openjaws)
Distributed computing platform. Services run as sovereign 'cells' that self-discover via gossip-based atlas sync, self-replicate via Cell.toml, and expose typed capabilities. TypeScript + Rust.

**Blueberry Browser** — [github.com/Leif-Rydenfalk/blueberry-browser](https://github.com/Leif-Rydenfalk/blueberry-browser)
Electron browser with an MCP server built in. AI agents delegate web UI tasks (clicks, form fills, reads) to a real, logged-in browser session. Built in two weeks.

---

**Skills**

- **Languages:** Rust (advanced), TypeScript, JavaScript, Python, SQL, WGSL, C, C++ (basic)
- **Backend:** Axum, Node.js/Express, REST/WebSockets, microservices, Redis Streams, PostgreSQL
- **Frontend:** SvelteKit, React, React Native, Dominator, Tailwind CSS
- **Distributed Systems:** libp2p, PoW blockchain, gossip protocols, P2P networking, Ed25519 identity
- **Graphics:** wgpu, WGSL shaders, SDF rendering, voxel traversal, ECS (hecs), TAA, bloom
- **AI / Agents:** MCP (Model Context Protocol), Claude API, Electron/Chromium automation
- **Infrastructure:** Docker, gVisor, GitHub Actions, Cloudflare Tunnels/Pages, Hetzner, CI/CD
- **Testing:** TDD, property-based testing, integration testing

---

**Education**

Self-taught

---

**References**

Available on request
