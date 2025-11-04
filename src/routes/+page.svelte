<script lang="ts">
	// Import necessary components and functions
	import Project from "$lib/Project.svelte";
	import TitleCard from "$lib/TitleCard.svelte";
	import { onMount } from "svelte";
	import { appState, scrollToSection } from "$lib/util";
	import Text, { type TextColor } from "$lib/Text.svelte";
	import Button from "$lib/Button.svelte";
	import Show from "$lib/Show.svelte";

	// --- STATE ---
	let currentYear = 0;

	onMount(() => {
		currentYear = new Date().getFullYear();

		const sections = document.querySelectorAll<HTMLElement>(
			"[data-section-name]",
		);

		if (sections.length === 0) {
			console.warn(
				"IntersectionObserver: No sections found with [data-section-name] attribute.",
			);
			appState.update((state) => ({
				...state,
				currentVisibleSection: "Home",
			}));
			return;
		}

		const observerCallback = (entries: IntersectionObserverEntry[]) => {
			let latestIntersectingSectionName: string | null = null;

			entries.forEach((entry) => {
				if (entry.isIntersecting) {
					const name = entry.target.getAttribute("data-section-name");
					if (name) {
						latestIntersectingSectionName = name;
					}
				}
			});

			if (latestIntersectingSectionName) {
				appState.update((state) => {
					if (
						state.currentVisibleSection !==
						latestIntersectingSectionName
					) {
						return {
							...state,
							currentVisibleSection:
								latestIntersectingSectionName,
						};
					}
					return state;
				});
			}
		};

		const observerOptions: IntersectionObserverInit = {
			root: null,
			threshold: 0.4,
		};

		const observer = new IntersectionObserver(
			observerCallback,
			observerOptions,
		);

		sections.forEach((section) => {
			observer.observe(section);
		});

		return () => {
			observer.disconnect();
		};
	});

	// --- Interfaces for Data Structures ---
	interface ExperienceItem {
		title: string;
		company: string;
		dates: string;
		location?: string;
		description: string[];
		skillsLearned?: string[];
	}

	interface ProjectItem {
		title: string;
		description: string;
		tech: string[];
		link: string;
		imageUrl: string;
		metrics?: string[];
	}

	interface SkillSubCategory {
		title: string;
		items: string[];
		color?: string;
	}

	interface SkillDomain {
		domainTitle: string;
		icon?: string;
		categories: {
			[key: string]: SkillSubCategory;
		};
	}

	// --- DATA ---

	const experience: ExperienceItem[] = [
		{
			title: "Systems Engineer – Internal AI Tools",
			company: "TURBORILLA AB",
			dates: "March 2025 – Present",
			location: "Umeå, Västerbotten County, Sweden",
			description: [
				"Designed and shipped a Rust full-stack application (Axum/Dominator) that automates work-hour ingestion from Slack → Fortnox and flags financial discrepancies before payroll.",
				"Deployed globally via Cloudflare Tunnels from a locally hosted Mac Mini server; zero downtime in production.",
				"Added property-based tests for the validation engine; caught 11 edge-case bugs pre-production.",
				"Reduced payroll reconciliation time from 3 days to 30 minutes through automated validation.",
			],
			skillsLearned: [
				"Rust (Full-Stack)",
				"Axum",
				"Dominator",
				"PostgreSQL",
				"Slack API",
				"Fortnox API",
				"TDD",
				"Property-based Testing",
				"Cloudflare Tunnels",
			],
		},
		{
			title: "Game Engine Developer",
			company: "Rydenfalk Systems",
			dates: "February 2025 – Present",
			location: "Umeå, Västerbotten County, Sweden",
			description: [
				"Built a data-driven engine in Rust (wgpu) with ECS (hecs), hybrid SDF-voxel traversal, TAA & bloom.",
				"Render-graph compiles at startup; maintains 60 FPS on Apple A15 and M1 without platform-specific optimizations.",
				"Implemented custom Entity Component System architecture supporting robust game state management.",
			],
			skillsLearned: [
				"Rust",
				"wgpu",
				"hecs",
				"Real-time Rendering",
				"Signed Distance Fields",
				"Voxel Rendering",
				"Render Graph Design",
				"Mobile Graphics Optimization",
			],
		},
		{
			title: "Full-Stack Contractor",
			company: "Self Employed",
			dates: "January 2024 – May 2025",
			location: "Umeå, Västerbotten County, Sweden",
			description: [
				"Delivered three commercial codebases (SvelteKit + Node + PostgreSQL) with CI/CD via GitHub Actions.",
				"Integrated Stripe Connect for split payments; handled PCI compliance via Stripe webhooks.",
				"Containerized all services in Docker; dev-prod parity < 2 min cold start on new machines.",
				"Built custom algorithm for personalized feed generation based on user attributes.",
			],
			skillsLearned: [
				"SvelteKit",
				"TypeScript",
				"Node.js",
				"PostgreSQL",
				"Stripe API",
				"Docker",
				"CI/CD",
				"Algorithm Design",
				"OAuth",
			],
		},
	];

	const projects: ProjectItem[] = [
		{
			title: "Rheo – Resale Marketplace Platform",
			description:
				"Mobile-first marketplace platform built with modern architecture. Rust microservices (Axum), React Native client, PostgreSQL, Redis Streams, Stripe Connect. Handles complete buy/sell ecosystem including user onboarding, item listings, offer negotiation, and secure checkout. Deployed with Docker and GitHub Actions.",
			tech: [
				"Rust",
				"Axum",
				"React Native",
				"PostgreSQL",
				"Redis",
				"Stripe Connect",
				"Docker",
				"GitHub Actions",
			],
			link: "https://rheo.se",
			imageUrl: "./rheo_hero_16_9.webp",
			metrics: [
				"p95 server response: 78ms (Rust, 256MB container)",
				"Zero-downtime deployments via blue-green strategy",
			],
		},
		{
			title: "Portfolio Website",
			description:
				"Statically-generated site built with SvelteKit, TypeScript, and Tailwind CSS. Features component-based architecture, responsive design, and dynamic content rendering. 100 Lighthouse score; deployed on Cloudflare Pages with zero-cost edge caching.",
			tech: [
				"SvelteKit",
				"TypeScript",
				"Tailwind CSS",
				"Cloudflare Pages",
				"Vite",
			],
			link: "https://github.com/Leif-Rydenfalk/portfolio",
			imageUrl: "./mac_screenshot.webp",
		},
	];

	const skillsData: { [domainKey: string]: SkillDomain } = {
		programmingLanguages: {
			domainTitle: "Programming Languages",
			icon: "terminal",
			categories: {
				primary: {
					title: "Production",
					color: "blue-600",
					items: [
						"Rust (Advanced: Systems, Backend, Game Dev)",
						"TypeScript",
						"JavaScript (ES6+)",
						"Python",
						"SQL",
						"HTML5",
						"CSS3/SASS",
					],
				},
				familiar: {
					title: "Familiar",
					color: "cyan-600",
					items: [
						"Java",
						"C++",
						"C",
						"WGSL (Shader Language)",
						"Assembly (Basic)",
					],
				},
			},
		},
		fullstackWebDev: {
			domainTitle: "Full-Stack Web Development",
			icon: "code-branch",
			categories: {
				frontend: {
					title: "Frontend",
					color: "green-600",
					items: [
						"Svelte/SvelteKit",
						"React",
						"React Native",
						"Rust (Dominator)",
						"Tailwind CSS",
						"Redux/Zustand",
						"Webpack/Vite",
					],
				},
				backend: {
					title: "Backend",
					color: "purple-600",
					items: [
						"Node.js (Express.js)",
						"Rust (Axum)",
						"API Design (REST, GraphQL)",
						"WebSockets",
						"Microservices Architecture",
					],
				},
				databases: {
					title: "Databases",
					color: "red-600",
					items: [
						"PostgreSQL",
						"Redis",
						"MongoDB",
						"MySQL",
						"Data Modeling",
						"ORM (Prisma, Sequelize)",
					],
				},
			},
		},
		systemsGameDev: {
			domainTitle: "Systems & Game Engine Development",
			icon: "gamepad",
			categories: {
				architectureDesign: {
					title: "Architecture & Design",
					color: "orange-600",
					items: [
						"Game Engine Architecture",
						"Data-Driven Design",
						"Systems Architecture",
						"ECS Implementation (hecs)",
					],
				},
				graphicsRendering: {
					title: "Graphics & Rendering",
					color: "yellow-600",
					items: [
						"Real-time Rendering",
						"wgpu",
						"Vulkan",
						"OpenGL",
						"Ray Marching",
						"SDF Rendering",
						"Voxel Rendering",
						"Post-Processing (TAA, Bloom)",
						"Shader Programming (WGSL)",
					],
				},
				coreConcepts: {
					title: "Core Concepts",
					color: "lime-600",
					items: [
						"Low-level Optimization",
						"Memory Management",
						"Concurrency & Parallelism",
						"Real-time Systems",
						"Type Safety Implementation",
					],
				},
			},
		},
		devopsCloudApi: {
			domainTitle: "DevOps, Cloud & API Integration",
			icon: "cloud-upload",
			categories: {
				cloudInfra: {
					title: "Cloud & Infrastructure",
					color: "indigo-600",
					items: [
						"AWS (EC2, S3, Lambda, RDS)",
						"Cloudflare (Tunnels, Pages)",
						"Docker",
						"Containerization",
						"Infrastructure Management",
					],
				},
				toolsPractices: {
					title: "Tools & Practices",
					color: "pink-600",
					items: [
						"CI/CD (GitHub Actions)",
						"Git / Version Control",
						"Blue-Green Deployments",
					],
				},
				apiIntegration: {
					title: "API Integration",
					color: "rose-600",
					items: [
						"Slack API",
						"Fortnox API",
						"Stripe API",
						"Stripe Connect",
						"Firebase Authentication",
						"OAuth",
					],
				},
			},
		},
		coreSkillsPractices: {
			domainTitle: "Core Skills & Practices",
			icon: "brain",
			categories: {
				methodologies: {
					title: "Methodologies & Quality",
					color: "teal-600",
					items: [
						"Test-Driven Development (TDD)",
						"Property-based Testing",
						"Unit & Integration Testing",
						"Algorithm Design",
						"Problem Solving",
					],
				},
				generalProfessional: {
					title: "Professional",
					color: "fuchsia-600",
					items: [
						"Independent Project Leadership",
						"System Research & Optimization",
						"Error Handling & System Resilience",
						"Technical Communication",
						"Code Reviews",
					],
				},
			},
		},
	};
</script>

<div
	class="bg-white text-gray-800 antialiased dark:bg-gray-900 dark:text-gray-200"
>
	<!-- Home Section -->
	<section
		id="home-section"
		data-section-name="Home"
		class="w-screen h-screen flex flex-col justify-center items-center text-center px-4"
	>
		<div
			class="flex flex-col justify-center items-center text-center h-auto"
		>
			<Show delay={1.0} timing="smooth">
				<Text
					text="Leif Adamec Rydenfalk"
					size="xl_title"
					tracking="wide"
					color="primary"
				/>
			</Show>

			<div class="h-8"></div>

			<Show delay={1.2} timing="smooth">
				<Text
					text="Systems Engineer • Full-Stack Developer • FinTech Engineer"
					size="lg"
					tracking="wide"
					color="secondary"
				/>
			</Show>

			<div class="h-8"></div>

			<div class="h-auto flex flex-col items-center justify-center">
				<Button
					onClick={(e) => {
						scrollToSection(e, "about-section");
					}}
				>
					<div class="flex flex-col items-center justify-center">
						<Show delay={2.0} timing="smooth">
							<Text
								text="View profile"
								size="sm"
								tracking="wide"
								color="secondary"
							/>
						</Show>
						<Show delay={2.4} timing="smooth">
							<svg
								xmlns="http://www.w3.org/2000/svg"
								width="3rem"
								height="3rem"
								viewBox="0 0 24 24"
								class="mt-1 text-gray-600 dark:text-gray-400"
								><path
									fill="none"
									stroke="currentColor"
									stroke-linecap="round"
									stroke-linejoin="round"
									stroke-width="2"
									d="m19 9l-7 7l-7-7"
								></path></svg
							>
						</Show>
					</div>
				</Button>
			</div>
		</div>
	</section>

	<!-- About Section -->
	<section
		id="about-section"
		data-section-name="About"
		class="w-full py-16 lg:py-24 bg-gray-50 dark:bg-gray-800"
	>
		<div class="container mx-auto px-6 max-w-4xl">
			<TitleCard title="Summary" alignment="center" />

			<Show delay={0.1} timing="smooth" preset="scale">
				<div class="mt-10">
					<ul
						class="list-disc list-outside ml-6 space-y-3 text-gray-700 dark:text-gray-300"
					>
						<li>
							<Text tag="span" size="md">
								Shipped production tooling that is capable of
								reducing payroll reconciliation from 3 days to
								30 minutes.
							</Text>
						</li>
						<li>
							<Text tag="span" size="md">
								Built marketplace platform capable processing
								4,200+ transactions per seconds through
								self-built Rust backend (rheo.se) in 3 months.
							</Text>
						</li>
						<li>
							<Text tag="span" size="md">
								Designed real-time graphics engine (wgpu)
								running at 60 FPS on mobile SOCs.
							</Text>
						</li>
						<li>
							<Text tag="span" size="md">
								Delivered three commercial full-stack
								applications with &lt; 2min cold-start
								deployment.
							</Text>
						</li>
					</ul>
				</div>
			</Show>

			<hr class="border-gray-300 dark:border-gray-600 my-10" />

			<div class="space-y-8 text-left">
				<Show delay={0.2} timing="smooth" preset="scale">
					<div>
						<Text
							tag="h3"
							size="md_header"
							color="primary"
							class="mb-3"
						>
							Full-Stack Systems Engineering
						</Text>
						<Text tag="p" color="gray-700" size="md" class="mb-3">
							Proficient in architecting and implementing
							end-to-end solutions across the complete technology
							stack. Built production systems using Rust
							(Axum/Dominator) for high-performance backends,
							SvelteKit and React for complex frontends, and
							PostgreSQL for robust data modeling. Integrated
							third-party services including Stripe Connect, Slack
							API, and Fortnox API.
						</Text>
						<Text tag="p" color="gray-700" size="md">
							Deployed scalable infrastructure using Docker,
							GitHub Actions, and Cloudflare Tunnels. Implemented
							CI/CD pipelines with blue-green deployment
							strategies and comprehensive testing including TDD
							and property-based testing.
						</Text>
					</div>
				</Show>

				<hr class="border-gray-300 dark:border-gray-600" />

				<Show delay={0.4} timing="smooth" preset="scale">
					<div>
						<Text
							tag="h3"
							size="md_header"
							color="primary"
							class="mb-3"
						>
							Performance-Focused Systems Development
						</Text>
						<Text tag="p" color="gray-700" size="md" class="mb-3">
							Built low-level systems in Rust and C++ with focus
							on performance optimization and memory efficiency.
							Developed custom game engine featuring data-driven
							architecture, ECS implementation (hecs), and
							advanced rendering techniques including ray
							marching, SDF traversal, and post-processing
							effects.
						</Text>
						<Text tag="p" color="gray-700" size="md">
							Implemented asynchronous job processing systems
							using Redis Streams. Optimized server response times
							to p95 of 78ms in production microservices. Designed
							render pipelines achieving 60 FPS on mobile hardware
							without platform-specific optimizations.
						</Text>
					</div>
				</Show>

				<hr class="border-gray-300 dark:border-gray-600" />

				<Show delay={0.6} timing="smooth" preset="scale">
					<div>
						<Text
							tag="h3"
							size="md_header"
							color="primary"
							class="mb-3"
						>
							Rapid Prototyping and Delivery
						</Text>
						<Text tag="p" color="gray-700" size="md" class="mb-3">
							Demonstrated ability to move from concept to
							production-ready systems efficiently. Self-directed
							learning approach focused on understanding
							technologies from first principles enables rapid
							assimilation of new concepts and frameworks.
						</Text>
						<Text tag="p" color="gray-700" size="md">
							Committed to building maintainable, well-tested
							systems with robust error handling. Focus on solving
							complex technical challenges through clean
							architecture and strategic technology choices.
						</Text>
					</div>
				</Show>
			</div>
		</div>
	</section>

	<!-- Rheo Case Study Section -->
	<section
		id="rheo-section"
		data-section-name="Rheo"
		class="w-full py-16 lg:py-24 bg-white dark:bg-gray-900"
	>
		<div class="container mx-auto px-6 max-w-6xl">
			<TitleCard title="Case Study: Rheo" alignment="center" />

			<div class="mt-10 grid md:grid-cols-2 gap-8 items-start">
				<Show delay={0.2} timing="smooth" preset="scale">
					<Project {...projects[0]} />
				</Show>

				<Show delay={0.3} timing="smooth" preset="scale">
					<div class="space-y-6">
						<div>
							<Text
								tag="h3"
								size="md_header"
								color="primary"
								class="mb-3"
							>
								Key Metrics
							</Text>
							<ul
								class="list-disc list-outside ml-5 space-y-2 text-gray-700 dark:text-gray-300"
							>
								{#each projects[0].metrics || [] as metric}
									<li>
										<Text tag="span" size="sm"
											>{metric}</Text
										>
									</li>
								{/each}
							</ul>
						</div>

						<div>
							<Text
								tag="h3"
								size="md_header"
								color="primary"
								class="mb-3"
							>
								Architecture
							</Text>
							<ul
								class="list-disc list-outside ml-5 space-y-2 text-gray-700 dark:text-gray-300"
							>
								<li>
									<Text tag="span" size="sm"
										>Axum API → Redis Streams → async
										workers (Tokio)</Text
									>
								</li>
								<li>
									<Text tag="span" size="sm"
										>Stripe Connect onboarding + escrow via
										webhooks</Text
									>
								</li>
								<li>
									<Text tag="span" size="sm"
										>Docker Compose stack; production deploy
										via GitHub Actions + Cloudflare Tunnels</Text
									>
								</li>
								<li>
									<Text tag="span" size="sm"
										>React Native client with Zustand state
										management and TanStack Query</Text
									>
								</li>
							</ul>
						</div>

						<div>
							<Text
								tag="h3"
								size="md_header"
								color="primary"
								class="mb-3"
							>
								Technical Highlights
							</Text>
							<ul
								class="list-disc list-outside ml-5 space-y-2 text-gray-700 dark:text-gray-300"
							>
								<li>
									<Text tag="span" size="sm"
										>Complete buy/sell ecosystem with offer
										negotiation</Text
									>
								</li>
								<li>
									<Text tag="span" size="sm"
										>Secure payment flows with seller
										verification</Text
									>
								</li>
								<li>
									<Text tag="span" size="sm"
										>Asynchronous job processing with
										real-time progress updates</Text
									>
								</li>
								<li>
									<Text tag="span" size="sm"
										>Cross-platform mobile app with native
										experience</Text
									>
								</li>
							</ul>
						</div>
					</div>
				</Show>
			</div>
		</div>
	</section>

	<!-- Experience Section -->
	<section
		id="experience-section"
		data-section-name="Experience"
		class="w-full py-16 lg:py-24 bg-gray-50 dark:bg-gray-800"
	>
		<div class="container mx-auto px-6 max-w-4xl">
			<TitleCard title="Experience" alignment="center" />
			<div class="mt-10 space-y-12">
				{#each experience as job, i}
					<Show delay={0.2 + i * 0.1} timing="smooth" preset="scale">
						<div
							class="border-l-4 border-blue-500 dark:border-blue-400 pl-6 transition-shadow duration-300 hover:shadow-md pb-6 relative group"
						>
							<span
								class="absolute -left-[calc(0.5rem+2px)] top-0 w-4 h-4 bg-white dark:bg-gray-800 rounded-full border-4 border-blue-500 dark:border-blue-400 transition-transform duration-200 group-hover:scale-110"
							></span>
							<Text
								tag="h3"
								text={job.title}
								size="lg_header"
								color="gray-800"
								class="mb-1"
							/>
							<Text
								tag="p"
								text={job.company}
								color="blue-700"
								size="md"
							/>
							<Text
								tag="p"
								color="gray-500"
								size="sm"
								class="mb-4"
							>
								{job.dates}
								{job.location ? ` · ${job.location}` : ""}
							</Text>

							<ul
								class="list-disc list-outside ml-5 space-y-2 mb-4"
							>
								{#each job.description as point}
									<li>
										<Text
											text={point}
											color="gray-700"
											size="sm"
										/>
									</li>
								{/each}
							</ul>

							{#if job.skillsLearned && job.skillsLearned.length > 0}
								<div
									class="mt-4 pt-3 border-t border-gray-200 dark:border-gray-700"
								>
									<Text
										tag="h4"
										text="Key Skills:"
										size="sm"
										color="gray-600"
										class="mb-2"
									/>
									<ul
										class="flex flex-wrap gap-x-2 gap-y-1.5"
									>
										{#each job.skillsLearned as skill}
											<li
												class="bg-blue-100 dark:bg-blue-900/50 text-blue-800 dark:text-blue-200 text-xs font-medium px-2.5 py-0.5 rounded-full border border-blue-200 dark:border-blue-800"
											>
												<Text
													text={skill}
													size="xs"
													color="inherit"
												/>
											</li>
										{/each}
									</ul>
								</div>
							{/if}
						</div>
					</Show>
				{/each}
			</div>
		</div>
	</section>

	<!-- Skills Sections -->
	{#each Object.entries(skillsData) as [domainKey, domain], index (domain.domainTitle)}
		<section
			id={`skills-${domainKey}-section`}
			data-section-name={index === 0 ? "Skills" : undefined}
			class="w-full py-16 lg:py-24 {index % 2 === 0
				? 'bg-white dark:bg-gray-900'
				: 'bg-gray-50 dark:bg-gray-800'}"
		>
			<div class="container mx-auto px-6 max-w-6xl">
				<TitleCard title={domain.domainTitle} alignment="center" />

				<div
					class="mt-10 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 lg:gap-12"
				>
					{#each Object.values(domain.categories) as category (category.title)}
						<Show delay={0.3} timing="smooth" preset="scale">
							<div
								class="bg-gray-100 dark:bg-gray-700 p-6 rounded-lg shadow-sm border border-gray-200 dark:border-gray-600 flex flex-col"
							>
								<Text
									tag="h3"
									text={category.title}
									size="md"
									color={(category.color as TextColor) ||
										"gray-800"}
									class="mb-4"
								/>
								<ul class="space-y-2 flex-grow">
									{#each category.items as skill}
										<li>
											<Text
												text={skill}
												color="gray-700"
												size="sm"
											/>
										</li>
									{/each}
								</ul>
							</div>
						</Show>
					{/each}
				</div>
			</div>
		</section>
	{/each}

	<!-- Projects Section -->
	<section
		id="projects-section"
		data-section-name="Projects"
		class="w-full py-16 lg:py-24 bg-white dark:bg-gray-900"
	>
		<div class="container mx-auto px-6 max-w-6xl">
			<TitleCard title="Other Projects" alignment="center" />
			<div class="mt-10 grid grid-cols-1 md:grid-cols-2 gap-8 lg:gap-12">
				{#each projects.slice(1) as project, i}
					<Show delay={0.2 + i * 0.1} timing="smooth" preset="scale">
						<Project
							title={project.title}
							description={project.description}
							tech={project.tech}
							link={project.link}
							imageUrl={project.imageUrl}
						/>
					</Show>
				{/each}

				<div
					class="flex items-center justify-center text-center p-6 bg-gray-50 dark:bg-gray-800 rounded-lg shadow-sm border border-gray-200 dark:border-gray-700"
				>
					<Text color="gray-500" size="sm">
						Additional project details, including work on internal
						tools (Rust) and the game engine (Rust/wgpu), can be
						discussed further. Code samples available upon request.
					</Text>
				</div>
			</div>
		</div>
	</section>

	<!-- Contact Section -->
	<section
		id="contact-section"
		data-section-name="Contact"
		class="w-full py-16 lg:py-24 bg-gray-100 dark:bg-gray-800"
	>
		<div class="container mx-auto px-6 max-w-3xl text-center">
			<TitleCard title="Contact" alignment="center" />

			<Show delay={0.2} timing="smooth" preset="scale">
				<div class="mt-8 space-y-4">
					<Text tag="p" color="gray-700" size="md">
						Open to opportunities in systems engineering, full-stack
						development, and performance optimization.
					</Text>
				</div>

				<div
					class="mt-10 flex flex-col sm:flex-row justify-center items-center gap-4 sm:gap-6"
				>
					<a
						href="mailto:ledamecrydenfalk@gmail.com"
						class="inline-block w-full sm:w-auto"
					>
						<Button style="w-full">
							<div
								class="flex items-center justify-center space-x-2 px-4 py-2"
							>
								<svg
									xmlns="http://www.w3.org/2000/svg"
									width="1.2em"
									height="1.2em"
									viewBox="0 0 24 24"
									class="inline text-current"
								>
									<path
										fill="currentColor"
										d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm-.4 4.25l-7.07 4.42c-.32.2-.74.2-1.06 0L4.4 8.25a.85.85 0 1 1 .9-1.44L12 11l6.7-4.19a.85.85 0 1 1 .9 1.44z"
									></path>
								</svg>
								<Text text="Email" size="sm" />
							</div>
						</Button>
					</a>

					<a
						href="https://www.linkedin.com/in/leif-adamec-rydenfalk-5b269a261/"
						target="_blank"
						rel="noopener noreferrer"
						class="inline-block w-full sm:w-auto"
					>
						<Button style="w-full">
							<div
								class="flex items-center justify-center space-x-2 px-4 py-2"
							>
								<svg
									xmlns="http://www.w3.org/2000/svg"
									width="1.2em"
									height="1.2em"
									viewBox="0 0 24 24"
									class="inline text-current"
								>
									<path
										fill="currentColor"
										d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2zm-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.32 1.3v-1.11h-3.06v8.37h3.06v-4.93c0-.81.61-1.41 1.41-1.41c.8 0 1.41.6 1.41 1.41v4.93zM6.88 8.56a1.68 1.68 0 0 0 1.68-1.68c0-.93-.75-1.69-1.68-1.69a1.69 1.69 0 0 0-1.69 1.69c0 .93.76 1.68 1.69 1.68m1.39 9.94v-8.37H5.5v8.37z"
									></path>
								</svg>
								<Text text="LinkedIn" size="sm" />
							</div>
						</Button>
					</a>

					<a
						href="https://github.com/Leif-Rydenfalk"
						target="_blank"
						rel="noopener noreferrer"
						class="inline-block w-full sm:w-auto"
					>
						<Button style="w-full">
							<div
								class="flex items-center justify-center space-x-2 px-4 py-2"
							>
								<svg
									xmlns="http://www.w3.org/2000/svg"
									width="1.2em"
									height="1.2em"
									viewBox="0 0 24 24"
									class="inline text-current"
								>
									<path
										fill="currentColor"
										d="M12 2A10 10 0 0 0 2 12c0 4.42 2.87 8.17 6.84 9.5c.5.08.66-.23.66-.5v-1.69c-2.77.6-3.36-1.34-3.36-1.34c-.46-1.16-1.11-1.47-1.11-1.47c-.91-.62.07-.6.07-.6c1 .07 1.53 1.03 1.53 1.03c.87 1.5 2.3.97 2.87.74c.09-.6.33-.97.6-1.2c-2.22-.24-4.55-1.11-4.55-4.92c0-.97.36-1.88.96-2.56c-.1-.24-.42-1.21.09-2.52c0 0 .84-.27 2.75 1.02A9.58 9.58 0 0 1 12 6.84c.85 0 1.73.11 2.55.33c1.91-1.29 2.75-1.02 2.75-1.02c.51 1.31.19 2.28.09 2.52c.6.68.96 1.59.96 2.56c0 3.81-2.34 4.68-4.57 4.92c.36.31.69.92.69 1.85v2.72c0 .27.16.59.67.5C19.14 20.16 22 16.42 22 12A10 10 0 0 0 12 2"
									></path>
								</svg>
								<Text text="GitHub" size="sm" />
							</div>
						</Button>
					</a>

					<a
						href="/Resume - Leif Adamec Rydenfalk.pdf"
						download="Resume - Leif Adamec Rydenfalk.pdf"
						class="inline-block w-full sm:w-auto"
						aria-label="Download Resume"
					>
						<Button style="w-full">
							<div
								class="flex items-center justify-center space-x-2 px-4 py-2"
							>
								<svg
									xmlns="http://www.w3.org/2000/svg"
									width="1.2em"
									height="1.2em"
									viewBox="0 0 24 24"
									class="inline text-current"
									aria-hidden="true"
								>
									<path
										fill="currentColor"
										d="M5 20h14v-2H5zm14-9h-4V3H9v6H5l7 7z"
									>
									</path>
								</svg>
								<Text text="Resume PDF" size="sm" />
							</div>
						</Button>
					</a>
				</div>
			</Show>
		</div>
	</section>
</div>

<footer
	class="w-full py-4 bg-gray-100 dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700"
>
	<div class="container mx-auto px-6 text-center">
		<Text
			text={`© ${currentYear} Leif Adamec Rydenfalk`}
			color="gray-600"
			size="sm"
		></Text>
	</div>
</footer>
