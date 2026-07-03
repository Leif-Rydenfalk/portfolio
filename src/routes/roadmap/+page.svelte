<script lang="ts">
	import Show from "$lib/Show.svelte";
	import Text from "$lib/Text.svelte";

	// --- Types ---
	type Status = "shipped" | "now" | "next" | "horizon";

	interface Milestone {
		status: Status;
		title: string;
		desc: string;
	}

	interface Track {
		id: string;
		name: string;
		pill: string;
		pillClass: string;
		vision: string;
		link?: string;
		linkLabel?: string;
		accentBorder: string;
		accentText: string;
		milestones: Milestone[];
	}

	interface Ambition {
		statement: string;
		support: string;
		accentBorder: string;
	}

	// --- Status system ---
	const statusMeta: Record<
		Status,
		{ label: string; dot: string; text: string }
	> = {
		shipped: {
			label: "Shipped",
			dot: "bg-emerald-500 border-emerald-500",
			text: "text-emerald-700 dark:text-emerald-400",
		},
		now: {
			label: "In progress",
			dot: "bg-blue-500 border-blue-500 animate-pulse",
			text: "text-blue-700 dark:text-blue-400",
		},
		next: {
			label: "Next",
			dot: "bg-amber-400 border-amber-400",
			text: "text-amber-700 dark:text-amber-400",
		},
		horizon: {
			label: "Horizon",
			dot: "bg-transparent border-gray-400",
			text: "text-gray-500 dark:text-gray-400",
		},
	};

	// --- Ambitions (the north stars) ---
	const ambitions: Ambition[] = [
		{
			statement: "Every computer on Earth sharing compute",
			support:
				"CE turns idle machines into one mesh — the world's largest throughput machine, assembled from donated hardware instead of datacenters.",
			accentBorder: "border-t-blue-500",
		},
		{
			statement: "The cloud, owned by its users",
			support:
				"Storage, databases, orchestration, functions, CDN — rebuilt as mesh apps anyone can run, and earn from, instead of renting from three companies.",
			accentBorder: "border-t-indigo-500",
		},
		{
			statement: "Never log into a website again",
			support:
				"Your node is your identity. Passwordless, capability-based access everywhere — pairing is consent, trust is a signed chain, revocation is yours.",
			accentBorder: "border-t-violet-500",
		},
		{
			statement: "AI served by everyone, for everyone",
			support:
				"Large models running across the devices people already own — no API keys, no cloud bill. Inference as shared infrastructure, not a subscription.",
			accentBorder: "border-t-sky-500",
		},
		{
			statement: "Commerce that circulates",
			support:
				"Rheo makes resale as easy as buying new — escrow-grade payment flows and logistics so the circular economy becomes the default, not the effort.",
			accentBorder: "border-t-emerald-500",
		},
		{
			statement: "Superpowers for teachers",
			support:
				"Trana gives every teacher an AI colleague for lesson material — built for the Swedish curriculum first, then everyone else's.",
			accentBorder: "border-t-purple-500",
		},
	];

	// --- Tracks ---
	const tracks: Track[] = [
		{
			id: "ce",
			name: "CE — the substrate",
			pill: "Live",
			pillClass:
				"bg-emerald-100 text-emerald-800 border-emerald-300 dark:bg-emerald-900/40 dark:text-emerald-300 dark:border-emerald-800",
			vision:
				"A peer-to-peer compute mesh and economy where every node is assumed hostile and the honest majority wins. Donate compute, earn credits, spend them anywhere on the mesh.",
			link: "https://ce-net.com",
			linkLabel: "ce-net.com",
			accentBorder: "border-blue-500",
			accentText: "text-blue-700 dark:text-blue-400",
			milestones: [
				{
					status: "shipped",
					title: "The foundation",
					desc: "Ed25519 identity, PoW credit ledger, libp2p mesh with NAT traversal, Docker/gVisor sandboxing, WASM runtime, content-addressed data layer, app messaging, naming and discovery.",
				},
				{
					status: "shipped",
					title: "Trust as capability chains",
					desc: "One primitive for all authorization: signed, attenuating capability chains with revocation. No device lists, no passwords, no central authority.",
				},
				{
					status: "shipped",
					title: "A live, paid economy",
					desc: "Payment channels, usage metering, admission control, and on-chain settlement — running across a real multi-machine fleet, with the economy extracted into its own adapter so the substrate stays pure.",
				},
				{
					status: "now",
					title: "The mesh over any medium",
					desc: "Protocol adapters carry the mesh beyond libp2p — WebSockets, embedded devices, robots on ESP32s. Plus sub-microsecond shared-memory lanes for same-host apps.",
				},
				{
					status: "next",
					title: "GPUs and verified hardware",
					desc: "First-class GPU workloads, attested benchmarks so nodes can't lie about their hardware, and a verification dial from cheap redundancy up to hardware attestation.",
				},
				{
					status: "horizon",
					title: "Open the doors to the planet",
					desc: "Sybil-priced open participation — bonds, slashing, verifiable randomness — and incentivized relays, so the mesh scales to strangers without trusting them.",
				},
			],
		},
		{
			id: "services",
			name: "ce-net services — the cloud, rebuilt",
			pill: "70+ services",
			pillClass:
				"bg-indigo-100 text-indigo-800 border-indigo-300 dark:bg-indigo-900/40 dark:text-indigo-300 dark:border-indigo-800",
			vision:
				"Google-class infrastructure as mesh apps over one SDK: if it exists in the cloud, it should exist here — owned by the people running it.",
			link: "https://github.com/ce-net",
			linkLabel: "github.com/ce-net",
			accentBorder: "border-indigo-500",
			accentText: "text-indigo-700 dark:text-indigo-400",
			milestones: [
				{
					status: "shipped",
					title: "The service portfolio",
					desc: "Object storage, realtime document DB, container orchestration, pub/sub, CDN, serverless functions, distributed CI, tunnels, drive, live-streaming studio, notes, chat, mail, meet — all as apps on CE primitives.",
				},
				{
					status: "shipped",
					title: "Drive and cast, live",
					desc: "CE Drive (a personal Dropbox on the mesh) and ce-cast (a distributed live studio where a relay node does the heavy encoding) deployed and in daily use.",
				},
				{
					status: "now",
					title: "Identity everywhere",
					desc: "Passwordless node-auth rolled through every app, remote access to your own node from any browser via the relay, and a mesh-native registry so no single machine holds the truth.",
				},
				{
					status: "next",
					title: "One command to anything",
					desc: "The publishing campaign: every app installable with a single command, across your whole fleet at once — install once, runs everywhere you are.",
				},
				{
					status: "horizon",
					title: "Millions of operators",
					desc: "Edges, registries, and relays become roles anyone can take on and earn from. Apps notice no difference — that invariant is the whole design.",
				},
			],
		},
		{
			id: "exo",
			name: "ce-exo — AI on the mesh",
			pill: "Live",
			pillClass:
				"bg-emerald-100 text-emerald-800 border-emerald-300 dark:bg-emerald-900/40 dark:text-emerald-300 dark:border-emerald-800",
			vision:
				"Large language models served by machines that were never meant to cooperate — your laptop, your GPU desktop, a browser tab — behind one API.",
			link: "https://github.com/ce-net/ce-exo",
			linkLabel: "github.com/ce-net/ce-exo",
			accentBorder: "border-sky-500",
			accentText: "text-sky-700 dark:text-sky-400",
			milestones: [
				{
					status: "shipped",
					title: "One API over the fleet",
					desc: "ce-exo wraps real engines — vLLM, llama.cpp, exo, Ollama — behind one OpenAI-compatible API with NAT-traversing transport and capability-gated access. One command deploys an engine to a GPU machine.",
				},
				{
					status: "shipped",
					title: "Inference in browser tabs",
					desc: "ce-tabnet shards a transformer layer-by-layer across browser tabs — pipeline-parallel WebGPU inference where each tab holds a slice of the model.",
				},
				{
					status: "now",
					title: "Serious deployments",
					desc: "Clinical-grade on-prem design: staff chat running on hospital GPUs where patient data never leaves the LAN. The same pattern fits any organization that can't ship data to a cloud.",
				},
				{
					status: "next",
					title: "Paid inference",
					desc: "Placement by attested GPU benchmarks and inference paid per request over payment channels — GPU owners earn, users pay for exactly what they use.",
				},
				{
					status: "horizon",
					title: "An open inference fabric",
					desc: "Frontier-scale models sharded across the mesh, served by everyone's devices together, owned by no one.",
				},
			],
		},
		{
			id: "rheo",
			name: "Rheo — circular commerce",
			pill: "Live",
			pillClass:
				"bg-emerald-100 text-emerald-800 border-emerald-300 dark:bg-emerald-900/40 dark:text-emerald-300 dark:border-emerald-800",
			vision:
				"A resale marketplace where selling something used is as easy as buying it new — and the money side is escrow-grade from day one.",
			link: "https://rheo.se",
			linkLabel: "rheo.se",
			accentBorder: "border-emerald-500",
			accentText: "text-emerald-700 dark:text-emerald-400",
			milestones: [
				{
					status: "shipped",
					title: "The whole marketplace",
					desc: "Listings, offers, Stripe Connect escrow with split payouts, multi-currency anchor pricing, PostNord shipping, and a React Native app — in production with p95 at 78ms.",
				},
				{
					status: "shipped",
					title: "Operations that don't sleep",
					desc: "Three fail-independent monitoring layers and blue-green deploys, so the marketplace stays up while it evolves.",
				},
				{
					status: "now",
					title: "Growing in Sweden",
					desc: "Onboarding sellers and refining the buy/sell loop where it matters most: trust, speed, and shipping friction.",
				},
				{
					status: "next",
					title: "Smart pricing",
					desc: "Automated valuation so sellers price right the first time, and watchdog automation that catches problems before users do.",
				},
				{
					status: "horizon",
					title: "Circular by default",
					desc: "Cross-border resale and a logistics layer that makes the second life of a product the natural one.",
				},
			],
		},
		{
			id: "trana",
			name: "Trana — AI for every teacher",
			pill: "Live",
			pillClass:
				"bg-emerald-100 text-emerald-800 border-emerald-300 dark:bg-emerald-900/40 dark:text-emerald-300 dark:border-emerald-800",
			vision:
				"An AI colleague for lesson material — one codebase shipping web, mobile, and desktop, built around the Swedish curriculum.",
			link: "https://trana.app",
			linkLabel: "trana.app",
			accentBorder: "border-purple-500",
			accentText: "text-purple-700 dark:text-purple-400",
			milestones: [
				{
					status: "shipped",
					title: "Four platforms, one codebase",
					desc: "Web, App Store, Play Store, and desktop from a single TypeScript monorepo — Supabase backend with row-level security and a full test pyramid in CI.",
				},
				{
					status: "now",
					title: "Curriculum depth",
					desc: "Deepening coverage of the Swedish upper-secondary curriculum so generated material lands ready to use, not ready to fix.",
				},
				{
					status: "next",
					title: "Schools, not just teachers",
					desc: "School-level licensing and collaboration so material flows between colleagues instead of dying in folders.",
				},
				{
					status: "horizon",
					title: "Beyond Sweden",
					desc: "The same engine, other countries' curricula.",
				},
			],
		},
		{
			id: "play",
			name: "Play — worlds that host themselves",
			pill: "In development",
			pillClass:
				"bg-blue-100 text-blue-800 border-blue-300 dark:bg-blue-900/40 dark:text-blue-300 dark:border-blue-800",
			vision:
				"Multiplayer games with no game servers: the players are the servers, and a world stays alive because people are in it.",
			link: "https://github.com/ce-net/spacegame",
			linkLabel: "github.com/ce-net/spacegame",
			accentBorder: "border-orange-500",
			accentText: "text-orange-700 dark:text-orange-400",
			milestones: [
				{
					status: "shipped",
					title: "Replicated authority, proven",
					desc: "Spacegame runs the full authoritative simulation in every player's browser (Rust to WASM) and merges state by quorum. Zero-delay prediction; the relay is just transport.",
				},
				{
					status: "now",
					title: "Cerena",
					desc: "A 10,000-player procedural fantasy RPG on the same principle — authoritative per-zone simulation across the mesh, everything hot-reloadable.",
				},
				{
					status: "horizon",
					title: "Persistent player-held worlds",
					desc: "Population-driven persistence: a lone player's world resets, a crowd's world survives — because the crowd is hosting it. No server bills, ever.",
				},
			],
		},
	];

	const legend: Status[] = ["shipped", "now", "next", "horizon"];
</script>

<div
	class="bg-white text-gray-800 antialiased dark:bg-gray-900 dark:text-gray-200"
>
	<!-- ============ HERO ============ -->
	<section
		class="w-full min-h-[70vh] flex flex-col justify-center items-center text-center px-6 pt-32 pb-16"
	>
		<Show delay={0.1} timing="smooth">
			<Text
				text="The Roadmap"
				size="sm"
				tracking="ultra_wide"
				color="blue-600"
			/>
		</Show>

		<div class="h-6"></div>

		<Show delay={0.2} timing="smooth">
			<h1
				class="text-[2.6rem] md:text-[3.4rem] leading-[1.15] tracking-tight text-gray-900 dark:text-gray-100 max-w-4xl"
			>
				Building infrastructure for our next society.
			</h1>
		</Show>

		<div class="h-8"></div>

		<Show delay={0.35} timing="smooth">
			<p
				class="max-w-2xl text-[1.15rem] leading-[1.8rem] text-gray-600 dark:text-gray-400"
			>
				Identity, compute, storage, money, AI — the systems a society runs
				on shouldn't belong to a handful of companies. They should be
				something people run together, on machines they already own. That
				is what all of this builds toward. Every computer on Earth sharing
				compute: the world's largest throughput machine.
			</p>
		</Show>

		<div class="h-10"></div>

		<Show delay={0.5} timing="smooth">
			<div class="flex flex-wrap justify-center gap-x-6 gap-y-2">
				{#each legend as s}
					<div class="flex items-center gap-2">
						<span
							class="w-3 h-3 rounded-full border-2 {statusMeta[s].dot}"
						></span>
						<span class="text-sm {statusMeta[s].text}"
							>{statusMeta[s].label}</span
						>
					</div>
				{/each}
			</div>
		</Show>
	</section>

	<!-- ============ AMBITIONS ============ -->
	<section class="w-full py-16 lg:py-20 bg-gray-50 dark:bg-gray-800">
		<div class="container mx-auto px-6 max-w-6xl">
			<Show delay={0.1} timing="smooth" preset="scale">
				<div class="text-center">
					<Text
						tag="h2"
						text="The ambitions"
						size="lg"
						color="gray-800"
						tracking="tight"
						class="text-3xl sm:text-4xl mb-2"
					/>
					<div class="mt-4 mx-auto h-1 w-20 bg-blue-500 rounded"></div>
					<p
						class="mt-6 max-w-2xl mx-auto text-gray-600 dark:text-gray-400"
					>
						Six north stars. Each one has a live system behind it today —
						none of them is finished, and that's the point.
					</p>
				</div>
			</Show>

			<div class="mt-12 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
				{#each ambitions as a, i}
					<Show delay={0.15 + i * 0.05} timing="smooth" preset="scale">
						<div
							class="h-full bg-white dark:bg-gray-700 rounded-lg shadow-sm border border-gray-200 dark:border-gray-600 border-t-4 {a.accentBorder} p-6"
						>
							<h3
								class="text-[1.3rem] leading-[1.7rem] text-gray-900 dark:text-gray-100"
							>
								{a.statement}
							</h3>
							<p
								class="mt-3 text-[0.95rem] leading-[1.55rem] text-gray-600 dark:text-gray-300"
							>
								{a.support}
							</p>
						</div>
					</Show>
				{/each}
			</div>
		</div>
	</section>

	<!-- ============ TRACKS ============ -->
	<section class="w-full py-16 lg:py-24 bg-white dark:bg-gray-900">
		<div class="container mx-auto px-6 max-w-4xl">
			<Show delay={0.1} timing="smooth" preset="scale">
				<div class="text-center">
					<Text
						tag="h2"
						text="The plan, project by project"
						size="lg"
						color="gray-800"
						tracking="tight"
						class="text-3xl sm:text-4xl mb-2"
					/>
					<div class="mt-4 mx-auto h-1 w-20 bg-blue-500 rounded"></div>
				</div>
			</Show>

			<div class="mt-14 space-y-20">
				{#each tracks as track}
					<div>
						<Show delay={0.1} timing="smooth" preset="scale">
							<div
								class="flex flex-wrap items-center gap-x-4 gap-y-2"
							>
								<h3
									class="text-[1.6rem] leading-[2rem] text-gray-900 dark:text-gray-100"
								>
									{track.name}
								</h3>
								<span
									class="text-xs font-medium px-2.5 py-0.5 rounded-full border {track.pillClass}"
								>
									{track.pill}
								</span>
								{#if track.link}
									<a
										href={track.link}
										target="_blank"
										rel="noopener noreferrer"
										class="text-sm {track.accentText} underline underline-offset-4 decoration-transparent hover:decoration-current transition-colors"
									>
										{track.linkLabel}
									</a>
								{/if}
							</div>
							<p
								class="mt-2 max-w-3xl text-[1rem] leading-[1.6rem] text-gray-600 dark:text-gray-400"
							>
								{track.vision}
							</p>
						</Show>

						<div
							class="mt-8 border-l-4 {track.accentBorder} pl-0 space-y-0"
						>
							{#each track.milestones as m, i}
								<Show
									delay={0.15 + i * 0.06}
									timing="smooth"
									preset="scale"
								>
									<div class="relative pl-8 pb-8 group">
										<span
											class="absolute -left-[0.65rem] top-1 w-4 h-4 rounded-full border-2 bg-white dark:bg-gray-900 {statusMeta[
												m.status
											].dot}"
										></span>
										<div
											class="flex flex-wrap items-baseline gap-x-3"
										>
											<h4
												class="text-[1.1rem] text-gray-900 dark:text-gray-100"
											>
												{m.title}
											</h4>
											<span
												class="text-xs uppercase tracking-wider {statusMeta[
													m.status
												].text}"
											>
												{statusMeta[m.status].label}
											</span>
										</div>
										<p
											class="mt-1.5 text-[0.95rem] leading-[1.55rem] text-gray-600 dark:text-gray-300 max-w-3xl"
										>
											{m.desc}
										</p>
									</div>
								</Show>
							{/each}
						</div>
					</div>
				{/each}
			</div>
		</div>
	</section>

	<!-- ============ CTA ============ -->
	<section class="w-full py-20 lg:py-28 bg-gray-50 dark:bg-gray-800">
		<div class="container mx-auto px-6 max-w-3xl text-center">
			<Show delay={0.1} timing="smooth" preset="scale">
				<h2
					class="text-[2.2rem] md:text-[2.8rem] leading-[1.2] tracking-tight text-gray-900 dark:text-gray-100"
				>
					We build.
				</h2>
				<p class="mt-5 text-gray-600 dark:text-gray-400 max-w-xl mx-auto">
					Every line above is either running or being written. If you're
					working on something that needs this kind of infrastructure — or
					want it to exist — talk to me.
				</p>
				<div
					class="mt-10 flex flex-col sm:flex-row justify-center items-center gap-4"
				>
					<a
						href="/#contact-section"
						class="w-full sm:w-auto px-6 py-3 rounded-3xl bg-black text-white dark:bg-white dark:text-black text-[0.95rem] hover:opacity-80 transition-opacity"
					>
						Get in touch
					</a>
					<a
						href="https://github.com/ce-net"
						target="_blank"
						rel="noopener noreferrer"
						class="w-full sm:w-auto px-6 py-3 rounded-3xl border border-gray-300 dark:border-gray-600 text-[0.95rem] text-gray-700 dark:text-gray-300 hover:border-gray-500 transition-colors"
					>
						ce-net on GitHub
					</a>
					<a
						href="/"
						class="w-full sm:w-auto px-6 py-3 rounded-3xl border border-gray-300 dark:border-gray-600 text-[0.95rem] text-gray-700 dark:text-gray-300 hover:border-gray-500 transition-colors"
					>
						Back to profile
					</a>
				</div>
			</Show>
		</div>
	</section>
</div>
