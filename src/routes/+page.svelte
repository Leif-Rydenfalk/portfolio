<script lang="ts">
// Import necessary components and functions
import Project from '$lib/Project.svelte';
import TitleCard from '$lib/TitleCard.svelte';
import { onMount } from 'svelte';
import { appState, scrollToSection } from '$lib/util';
import Text, { type TextColor } from '$lib/Text.svelte'; // Import TextColor type
import Button from '$lib/Button.svelte';
import Show from '$lib/Show.svelte';

// --- STATE ---
let currentYear = 0;

onMount(() => {
	currentYear = new Date().getFullYear();

	// --- Intersection Observer Setup ---

	// Select all section elements that have the 'data-section-name' attribute
	const sections = document.querySelectorAll<HTMLElement>(
		'[data-section-name]'
	);

	if (sections.length === 0) {
		console.warn(
			'IntersectionObserver: No sections found with [data-section-name] attribute.'
		);
		// Initialize with a default if needed, e.g., 'Home' if the first section might not intersect initially
		appState.update((state) => ({ ...state, currentVisibleSection: 'Home' }));
		return; // No sections to observe
	}

	// Callback function executed when intersection changes
	const observerCallback = (entries: IntersectionObserverEntry[]) => {
		let latestIntersectingSectionName: string | null = null;

		entries.forEach((entry) => {
			// Check if the section is intersecting according to the threshold
			if (entry.isIntersecting) {
				const name = entry.target.getAttribute('data-section-name');
				if (name) {
					// Store the name of the latest section that became intersecting
					// In a batch of entries, the last one intersecting is often the most relevant
					// if multiple cross the threshold simultaneously.
					latestIntersectingSectionName = name;
				}
			}
		});

		// If we found an intersecting section in this observation cycle, update the global state
		if (latestIntersectingSectionName) {
			appState.update((state) => {
				// Only trigger an update if the section name has actually changed
				// This prevents unnecessary state updates and potential re-renders
				if (state.currentVisibleSection !== latestIntersectingSectionName) {
					// console.log(`IntersectionObserver: Setting current section to ${latestIntersectingSectionName}`); // Optional: for debugging
					return {
						...state,
						currentVisibleSection: latestIntersectingSectionName
					};
				}
				return state; // No change needed, return the existing state object
			});
		}
		// Note: This logic doesn't explicitly handle the case where *no* sections are intersecting.
		// The state will simply remain as the last intersecting section detected.
		// If you need specific behavior when scrolling past all sections, add an 'else' block here.
	};

	// Observer options
	const observerOptions: IntersectionObserverInit = {
		root: null, // Observe intersections relative to the viewport
		// Adjust threshold: 0.1 means 10% visible, 0.5 means 50% visible.
		// A lower value triggers earlier when scrolling into view.
		// A higher value ensures more of the section is visible before updating.
		// Using a value like 0.3-0.5 often feels natural.
		threshold: 0.4
		// Optional: Use rootMargin to adjust the effective viewport bounds.
		// e.g., '0px 0px -40% 0px' - triggers when section enters the top 60% of the viewport.
		// rootMargin: '0px 0px -40% 0px'
	};

	// Create the observer instance
	const observer = new IntersectionObserver(observerCallback, observerOptions);

	// Start observing each section element
	sections.forEach((section) => {
		observer.observe(section);
	});

	// Cleanup function: This is crucial!
	// It runs when the component is unmounted to prevent memory leaks.
	return () => {
		observer.disconnect(); // Stop observing all targets
	};
});

// --- Interfaces for Data Structures ---
interface ExperienceItem {
	title: string;
	company: string;
	dates: string;
	location?: string; // Optional location
	description: string[]; // Use array for bullet points
	skillsLearned?: string[]; // Optional array for skills learned/used
}

interface ProjectItem {
	title: string;
	description: string;
	tech: string[];
	link: string; // '#' or actual URL
	imageUrl: string; // Placeholder or actual path
}

interface SkillSubCategory {
	title: string;
	items: string[];
	color?: string; // e.g., 'blue-600' (Tailwind color shade)
}

interface SkillDomain {
	domainTitle: string;
	icon?: string;
	categories: {
		[key: string]: SkillSubCategory;
	};
}

// --- DATA ---

// Updated Experience data based on CV
const experience: ExperienceItem[] = [
	{
		title: 'Systems Researcher and Engineer, AI Systems and Tool Developer',
		company: 'TURBORILLA AB',
		dates: 'March 2025 – Present', // Updated format from CV
		location: 'Umeå, Västerbotten County, Sweden',
		description: [
			// Updated description from CV, formatted as points
			'Spearheaded research, design, and development of critical internal systems aimed at significantly enhancing the efficiency of workhour management and financial analysis.',
			'Independently architected and delivered a full-stack application built entirely in Rust, demonstrating end-to-end project ownership. This solution featured a dynamic frontend using Dominator and a high-performance Axum backend.',
			'Engineered robust, type-safe API interfaces for seamless integration with Slack and Fortnox, incorporating comprehensive error handling to ensure data integrity and system stability.',
			'Resourcefully deployed the application globally using Cloudflare Tunnels from a locally hosted Mac Mini server.',
			'Guaranteed system reliability through the design and implementation of an extensive testing suite, particularly for the workhour validation component, validating the accuracy of critical financial data.',
			'Directly contributed to streamlined operations and improved analytical capabilities.'
		],
		skillsLearned: [
			// Updated skills from CV
			'Rust Programming (Full-Stack)',
			'Software Architecture & Design',
			'API Development & Integration (Slack, Fortnox)',
			'System Implementation & Deployment (Cloudflare Tunnels)',
			'Frontend Development (Rust Dominator)',
			'Backend Development (Rust Axum)',
			'Test-Driven Development (TDD) & Quality Assurance',
			'Data Validation & Integrity',
			'Robust Error Handling & System Resilience',
			'Financial Modeling & Analysis Concepts',
			'Internal Tool Development & Automation',
			'System Research & Optimization',
			'Infrastructure Management',
			'Independent Project Leadership'
		]
	},
	{
		title: 'Game Engine Developer',
		// company: 'Self Employed', // Keeping self-employed as per CV category, but acknowledge Rydenfalk Systems potential mention
		company: 'Rydenfalk Systems', // Use the more specific name if preferred/accurate
		dates: 'February 2025 – Present', // Updated format from CV
		location: 'Umeå, Västerbotten County, Sweden',
		description: [
			// Kept original detailed description as CV lacked one
			'Engineered a data-driven game engine from the ground up using Rust, focusing on performance and modern rendering techniques.',
			'Implemented a custom Entity Component System (ECS) architecture using `hecs`, supporting robust game state management.',
			'Developed an advanced real-time graphics renderer leveraging `wgpu`, featuring hybrid Signed Distance Field (SDF) voxel traversal, cloud ray marching, and post-processing effects (TAA, Bloom, Color Correction).',
			'Designed and built a type-safe, runtime-configurable, performance-optimized render graph, enabling flexible and efficient rendering pipelines across platforms, including mobile.',
			'Integrated core engine systems including windowing (`winit`), developer GUI (`imgui-rs`), user input handling (keyboard, controllers), and foundational multiplayer support.'
		],
		skillsLearned: [
			// Updated skills from CV
			'Rust',
			'wgpu',
			'Custom Engine Architecture',
			'Real-time Rendering',
			'Low-level Optimization',
			'Memory Management',
			'Concurrency'
		]
	},
	{
		title: 'Full-Stack Developer',
		company: 'Self Employed',
		dates: 'January 2024 – May 2025 (1 year 5 months)', // Kept original date format for duration clarity
		location: 'Umeå, Västerbotten County, Sweden',
		description: [
			// Matched points from CV
			'Developed and deployed full-stack web applications, managing the entire project lifecycle from conception to deployment.',
			'Engineered engaging user interfaces with SvelteKit, including a custom animation system to enhance user experience.',
			'Implemented secure authentication flows using OAuth and Firebase APIs, ensuring robust user management.',
			'Integrated the Stripe API for seamless and secure payment processing within e-commerce contexts.',
			'Designed and built backend systems using Node.js and PostgreSQL, featuring a custom algorithm for handling user attributes to enable personalized feed generation.',
			'Utilized Docker for containerization, ensuring consistent development and deployment environments.'
		],
		skillsLearned: [
			// Updated skills from CV
			'SvelteKit',
			'TypeScript',
			'Frontend Animation',
			'UI/UX Development',
			'Node.js',
			'API Design (REST/GraphQL)',
			'WebSockets',
			'Algorithm Design',
			'Backend Logic Implementation',
			'PostgreSQL',
			'Data Modeling',
			'Authentication & Authorization',
			'OAuth',
			'Firebase Authentication',
			'Payment Gateway Integration',
			'Stripe API',
			'Docker',
			'Containerization',
			'Full-Stack Development',
			'Project Management',
			'E-commerce Systems Concepts'
		]
	}
	// Commented out roles not present in the provided CV remain commented
	// {
	// 	title: 'Technical Systems Engineer',
	// 	company: 'Self Employed',
	// 	dates: 'October 2022 - May 2025 (2 years 8 months)',
	// 	location: 'Stockholm Municipality, Stockholm County, Sweden',
	// 	description: [],
	// 	skillsLearned: [
	// 		'System Architecture Design',
	// 		'Infrastructure Management (Cloud/On-prem)',
	// 		'Network Configuration & Security',
	// 		'Automation (Scripting)',
	// 		'Troubleshooting & Diagnostics'
	// 	]
	// },
	// {
	// 	title: 'Software Engineer',
	// 	company: 'Self Employed',
	// 	dates: 'July 2024 - August 2024 (2 months)',
	// 	location: 'Stockholm Municipality, Stockholm County, Sweden',
	// 	description: [],
	// 	skillsLearned: [
	// 		'Java',
	// 		'Spring Boot',
	// 		'Microservices Architecture',
	// 		'Unit & Integration Testing',
	// 		'Agile Methodologies'
	// 	]
	// }
];

// Updated Projects data based on CV
const projects: ProjectItem[] = [
	{
		title: 'Personal Portfolio Website',
		// Updated description from CV
		description:
			'Developed this interactive web presence to effectively showcase skills and projects, demonstrating modern frontend development practices. Built from the ground up using SvelteKit for optimal performance and user experience, TypeScript for robust, type-safe code, and Tailwind CSS for efficient styling. Features a component-based architecture, state management, dynamic content rendering, and responsive design.',
		tech: [
			// Updated tech stack from CV
			'SvelteKit',
			'TypeScript',
			'JavaScript', // Added from CV
			'Tailwind CSS',
			'Svelte Components',
			'HTML5',
			'CSS3',
			'Vite'
		],
		link: 'https://github.com/Leif-Rydenfalk/portfolio',
		imageUrl: './mac_screenshot.webp' // Keep existing image
	}
	// Other commented-out projects remain commented
	// {
	// 	title: 'Real-time Collaboration Platform',
	// 	description:
	// 		'A web application enabling real-time document editing and communication, built with WebSockets, SvelteKit, Node.js, and Redis.',
	// 	tech: ['SvelteKit', 'Node.js', 'WebSockets', 'Redis', 'Tailwind CSS', 'Docker'],
	// 	link: '#',
	// 	imageUrl: '',
	// },
	// ... other commented projects
];

// Updated Skills data based on CV structure and content
const skillsData: { [domainKey: string]: SkillDomain } = {
	programmingLanguages: {
		// New top-level category based on CV structure
		domainTitle: 'Programming Languages',
		icon: 'terminal', // Example icon
		categories: {
			primary: {
				title: 'Primary & Advanced',
				color: 'blue-600',
				items: [
					'Rust (Advanced: Systems, Backend, Game Dev)',
					'TypeScript',
					'JavaScript (ES6+)',
					'Python',
					'Java',
					'C++',
					'C',
					'SQL',
					'HTML5',
					'CSS3/SASS',
					'WGSL (Shader Language)'
				]
			},
			familiar: {
				title: 'Familiar & Basic',
				color: 'cyan-600',
				items: ['Assembly (Basic)', 'Zig (Familiarity)']
			}
		}
	},
	fullstackWebDev: {
		// Renamed for clarity
		domainTitle: 'Full-Stack Web Development',
		icon: 'code-branch',
		categories: {
			frontend: {
				title: 'Frontend',
				color: 'green-600',
				items: [
					'Svelte/SvelteKit',
					'React',
					'Rust (Dominator)', // Added from CV
					'Vue.js',
					'UI/UX Development',
					'Frontend Animation',
					'Redux/Zustand',
					'Tailwind CSS',
					'Webpack/Vite'
				]
			},
			backend: {
				title: 'Backend',
				color: 'purple-600',
				items: [
					'Node.js (Express.js)',
					'Rust (Axum)', // Added from CV
					'Python (Django/Flask)',
					'Java (Spring Boot)',
					'API Design (REST, GraphQL)',
					'WebSockets',
					'Microservices Architecture',
					'Backend Logic Implementation'
				]
			},
			databases: {
				title: 'Databases & ORMs',
				color: 'red-600',
				items: [
					'PostgreSQL',
					'MongoDB',
					'MySQL',
					'Redis',
					'Data Modeling',
					'Database Design',
					'ORM (Prisma, Sequelize, SQLAlchemy)' // Added specific ORMs
				]
			}
		}
	},
	systemsGameDev: {
		// Renamed for clarity
		domainTitle: 'Systems & Game Engine Development',
		icon: 'gamepad',
		categories: {
			architectureDesign: {
				title: 'Architecture & Design',
				color: 'orange-600',
				items: [
					'Game Engine Architecture',
					'Data-Driven Design',
					'Systems Architecture & Design',
					'System Research & Optimization',
					'ECS Implementation (hecs)' // Added specific ECS
				]
			},
			graphicsRendering: {
				title: 'Graphics & Rendering',
				color: 'yellow-600',
				items: [
					'Real-time Rendering',
					'wgpu',
					'Vulkan',
					'OpenGL',
					'Ray Marching',
					'SDF Rendering',
					'Voxel Rendering',
					'Render Graph Design',
					'Post-Processing (TAA, Bloom)',
					'Shader Programming (WGSL)',
					'3D Math',
					'Mobile Graphics Optimization',
					'DirectX (Basic)'
				]
			},
			coreConcepts: {
				title: 'Core Concepts',
				color: 'lime-600',
				items: [
					'Low-level Optimization',
					'Memory Management',
					'Concurrency & Parallelism',
					'Real-time Systems',
					'Data Validation & Integrity', // Added from CV skill lists
					'Type Safety Implementation' // Added from CV skill lists
				]
			}
		}
	},
	devopsCloudApi: {
		// Combined domain based on CV
		domainTitle: 'DevOps, Cloud & API Integration',
		icon: 'cloud-upload',
		categories: {
			cloudInfra: {
				title: 'Cloud & Infrastructure',
				color: 'indigo-600',
				items: [
					'AWS (EC2, S3, ECS, Lambda, RDS)',
					'Cloudflare Tunnels', // Added from CV
					'Docker',
					'Containerization',
					'Infrastructure Management (Local Servers, Cloud)' // Clarified
				]
			},
			toolsPractices: {
				title: 'Tools & Practices',
				color: 'pink-600',
				items: [
					'CI/CD (GitHub Actions, Jenkins)',
					'Git / Version Control', // Clarified
					'Terraform (Basic)'
				]
			},
			apiIntegration: {
				title: 'API Integration',
				color: 'rose-600',
				items: [
					'Slack API', // Added specific APIs
					'Fortnox API',
					'Stripe API',
					'Firebase Authentication',
					'API Development & Integration',
					'Payment Gateway Integration',
					'Authentication & Authorization (OAuth)'
				]
			}
		}
	},
	coreSkillsPractices: {
		// Renamed for clarity
		domainTitle: 'Core Skills & Practices',
		icon: 'brain',
		categories: {
			methodologies: {
				title: 'Methodologies & Quality',
				color: 'teal-600',
				items: [
					'Agile/Scrum',
					'Test-Driven Development (TDD)', // Added from CV
					'Unit & Integration Testing',
					'Quality Assurance', // Added from CV
					'Problem Solving',
					'Algorithm Design',
					'Data Structures'
				]
			},
			generalProfessional: {
				title: 'General & Professional',
				color: 'fuchsia-600',
				items: [
					'Efficiency Optimization', // Added from CV
					'Robust Error Handling & System Resilience', // Added from CV
					'Independent Project Leadership/Management', // Added from CV
					'Team Collaboration',
					'Code Reviews',
					'Technical Communication',
					'Requirement Analysis',
					'Financial Modeling Concepts' // Added from CV
				]
			}
		}
	},
	audioMusic: {
		// Kept as is, matches CV
		domainTitle: 'Audio & Music Production',
		icon: 'music',
		categories: {
			software: {
				title: 'Software (DAWs & Plugins)',
				color: 'sky-600',
				items: [
					'Ableton Live 11',
					'FL Studio',
					'Logic Pro X',
					'Serum 2', // Assuming Serum 2 is correct, CV just says Serum
					'Kontakt',
					'Various VSTs/AUs'
				]
			},
			skills: {
				title: 'Skills & Techniques',
				color: 'amber-600',
				items: [
					'Composition & Arrangement',
					'Sound Design',
					'Synthesis (Subtractive, FM)', // Added detail from old code
					'Mixing & Mastering (Basic)',
					'MIDI Programming',
					'Music Theory'
				]
			}
		}
	}
};
</script>

<!-- Main Page Template -->
<div
	class="bg-white text-gray-800 antialiased dark:bg-gray-900 dark:text-gray-200"
>
	<!-- Home Section -->
	<section
		id="home-section"
		data-section-name="Home"
		class="w-screen h-screen flex flex-col justify-center items-center text-center px-4"
	>
		<div class="flex flex-col justify-center items-center text-center h-auto">
			<Show delay={1.0} timing="smooth">
				<Text text="Hi," size="xl_title" tracking="wide" color="primary" />
			</Show>

			<div class="h-[4.3rem]">
				<Show delay={1.2} timing="smooth">
					<Text
						text="I'm Leif"
						size="xl_title"
						tracking="wide"
						color="primary"
					/>
				</Show>
			</div>

			<div class="h-8"></div>

			<div class="h-auto flex flex-col items-center justify-center">
				<Button
					onClick={(e) => {
						scrollToSection(e, 'about-section');
					}}
				>
					<div class="flex flex-col items-center justify-center">
						<Show delay={2.0} timing="smooth">
							<Text
								text="Scroll down"
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
			<TitleCard title="About Me" alignment="center" />

			<!-- CV Summary Integrated Intro -->
			<Show delay={0.1} timing="smooth" preset="scale">
				<div class="mt-10 text-center mb-10">
					<Text tag="p" color="gray-700" size="md" class="italic">
						Versatile Software & Systems Engineer proficient in
						<Text tag="span" color="orange-600" class="font-medium">Rust</Text>,
						<Text tag="span" color="blue-700" class="font-medium"
							>TypeScript</Text
						>, and modern web technologies. Experienced in architecting and
						developing end-to-end solutions, including high-performance internal
						tools (<Text tag="span" color="orange-600"
							>Rust: Axum/Dominator</Text
						>), data-driven game engines (<Text tag="span" color="orange-600"
							>Rust: wgpu/ECS</Text
						>), and dynamic full-stack web applications (<Text
							tag="span"
							color="orange-600">SvelteKit</Text
						>/<Text tag="span" color="green-600">Node.js</Text>). Proven ability
						in API design & integration (<Text tag="span" color="purple-600"
							>Slack</Text
						>,
						<Text tag="span" color="purple-600">Fortnox</Text>,
						<Text tag="span" color="purple-600">Stripe</Text>), real-time
						graphics, low-level optimization, and deploying robust systems.
						Passionate about building foundational software and tackling complex
						technical challenges with a focus on efficiency and maintainability.
					</Text>
				</div>
			</Show>

			<hr class="border-gray-300 dark:border-gray-600 mb-10" />

			<!-- Detailed Sections (Kept structure, verified content) -->
			<div class="space-y-10 text-left md:text-left">
				<Show delay={0.2} timing="smooth" preset="scale">
					<div>
						<Text
							tag="h3"
							size="md_header"
							color="primary"
							class="mb-3 flex items-center"
						>
							Engineering Digital Solutions: From Concept to Core
						</Text>
						<Text tag="p" color="gray-700" size="md" class="mb-4">
							My professional focus centers on engineering robust, efficient,
							and scalable digital solutions. I possess comprehensive experience
							across the entire software development lifecycle, adeptly moving
							from high-level architectural design to the precise implementation
							of sophisticated user interfaces and complex backend systems. I
							leverage modern technologies like
							<Text tag="span" color="orange-500" class="font-medium"
								>SvelteKit</Text
							>,
							<Text tag="span" color="blue-600" class="font-medium"
								>TypeScript</Text
							>,
							<Text tag="span" color="green-600" class="font-medium"
								>Node.js</Text
							>, and increasingly
							<Text tag="span" color="orange-600" class="font-medium">Rust</Text
							>
							(for both backend with
							<Text tag="span" color="orange-600">Axum</Text>
							and frontend with
							<Text tag="span" color="orange-600">Dominator</Text>) to build
							performant applications, underpinned by solid database design (<Text
								tag="span"
								color="indigo-600"
								class="font-medium">PostgreSQL</Text
							>) and effective deployment strategies using tools such as
							<Text tag="span" color="cyan-600" class="font-medium">Docker</Text
							>
							and
							<Text tag="span" color="orange-400" class="font-medium"
								>Cloudflare Tunnels</Text
							>.
						</Text>
						<Text tag="p" color="gray-700" size="md" class="mb-4">
							My objective is always to translate intricate requirements into
							clean, maintainable code that forms the foundation of reliable and
							user-centric products. I prioritize not just functionality, but
							also the long-term viability and scalability of the systems I
							build, incorporating robust testing (TDD) and error handling.
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
							class="mb-3 flex items-center"
						>
							Depth in Systems & Performance Optimization
						</Text>
						<Text tag="p" color="gray-700" size="md" class="mb-4">
							Beyond conventional web development, my fascination extends to the
							fundamental layers of computing. I actively engage with low-level
							systems programming, performance optimization, and the complex
							architecture of game engines. This pursuit of deeper
							understanding, primarily utilizing
							<Text tag="span" color="orange-600" class="font-medium">Rust</Text
							>
							and also
							<Text tag="span" color="blue-600" class="font-medium">C++</Text>,
							directly informs my ability to build more performant, resilient,
							and efficient applications at every level.
						</Text>
						<ul class="list-disc list-outside ml-6 space-y-2">
							<li>
								<Text tag="div" size="sm" color="gray-700">
									<Text tag="span" color="gray-800"
										>Foundational Systems Design:</Text
									>
									Applying systems thinking to architect robust infrastructure (local
									or cloud) and optimize processes, demonstrated in internal tool
									development and API integrations (<Text
										tag="span"
										color="purple-600">Slack</Text
									>,
									<Text tag="span" color="purple-600">Fortnox</Text>).
								</Text>
							</li>
							<li>
								<Text tag="div" size="sm" color="gray-700">
									<Text tag="span" color="gray-800"
										>Performance Engineering:</Text
									>
									Leveraging low-level programming (<Text
										tag="span"
										color="orange-600">Rust</Text
									>) and engine development principles (custom ECS,
									<Text tag="span" color="yellow-500">wgpu</Text>
									renderer with ray marching/SDF) to maximize computational efficiency.
								</Text>
							</li>
							<li>
								<Text tag="div" size="sm" color="gray-700">
									<Text tag="span" color="gray-800"
										>Strategic Tooling & AI Integration:</Text
									>
									Developing bespoke tools (primarily in
									<Text tag="span" color="orange-600">Rust</Text>) to solve
									specific operational challenges (like workhour management) and
									enhance productivity, with ongoing research into AI for
									intelligent system automation.
								</Text>
							</li>
						</ul>
					</div>
				</Show>

				<hr class="border-gray-300 dark:border-gray-600" />

				<Show delay={0.6} timing="smooth" preset="scale">
					<div>
						<Text
							tag="h3"
							size="md_header"
							color="primary"
							class="mb-3 flex items-center"
						>
							Principled Engineering & Continuous Growth
						</Text>
						<Text tag="p" color="gray-700" size="md" class="mb-4">
							My largely <Text tag="span" class="font-medium"
								>self-directed</Text
							> learning journey has instilled a rigorous approach focused on understanding
							technologies from first principles. This foundational knowledge fosters
							<Text tag="span" color="gray-900"
								>exceptional adaptability and rapid assimilation of new concepts</Text
							>. I am driven by a commitment to craftsmanship – engineering
							solutions that are not merely functional, but also elegant,
							maintainable, and strategically sound. Dissecting complex problems
							and architecting efficient solutions is a core professional
							satisfaction.
						</Text>
						<Text tag="p" color="gray-700" size="md" class="mb-4">
							My ambition extends to building foundational software: the
							critical platforms, libraries, and tools that empower
							organizations, streamline complex operations (like financial
							analysis tools), and serve as a reliable bedrock for future
							innovation. I believe technology should fundamentally enable
							progress and efficiency.
						</Text>
						<Text tag="p" color="gray-700" size="md" class="mb-4">
							I thrive in collaborative settings where technical challenges are
							met with intellectual curiosity and diverse perspectives. I am
							dedicated to continuous professional development, actively seeking
							out emerging technologies and best practices to refine my skills
							and contribute effectively to forward-thinking projects.
						</Text>
					</div>
				</Show>

				<Show delay={0.8} timing="smooth" preset="scale">
					<div
						class="mt-8 p-4 bg-gray-100 dark:bg-gray-700 rounded-lg border border-gray-200 dark:border-gray-600"
					>
						<Text
							tag="h4"
							size="sm_header"
							color="primary"
							class="mb-2 flex items-center"
						>
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1.5"
								stroke="currentColor"
								class="w-5 h-5 mr-2 text-teal-600 dark:text-teal-400"
							>
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="m9 9 10.5-3m0 6.553v3.75a2.25 2.25 0 0 1-1.632 2.163l-1.32.377a1.803 1.803 0 1 1-.99-3.467l2.31-.66a2.25 2.25 0 0 0 1.632-2.163Zm0 0V2.25L9 5.25v10.303m0 0v3.75a2.25 2.25 0 0 1-1.632 2.163l-1.32.377a1.803 1.803 0 0 1-.99-3.467l2.31-.66A2.25 2.25 0 0 0 9 15.553Z"
								></path>
							</svg>
							Creative & Technical Synthesis
						</Text>
						<Text tag="p" color="gray-700" size="sm">
							Outside of direct software development, I explore sound design and
							music production (using tools like
							<Text tag="span" class="font-medium">Ableton Live</Text>
							and various synths). This complementary discipline requires a similar
							blend of technical precision, structural understanding, and creative
							expression, further honing my analytical and constructive skillset.
						</Text>
					</div>
				</Show>
			</div>
		</div>
	</section>

	<!-- Skills Overview Section (Combined Categories) - REMOVED as requested for detailed view -->
	<!-- <section id="skills-overview-section" ... > ... </section> -->

	<!-- Skills Sections (Detailed per Domain - Updated) -->
	{#each Object.entries(skillsData) as [domainKey, domain], index (domain.domainTitle)}
		<section
			id={`skills-${domainKey}-section`}
			data-section-name={index === 0 ? 'Skills' : undefined}
			class="w-full py-16 lg:py-24 {index % 2 === 0
				? 'bg-white dark:bg-gray-900'
				: 'bg-gray-50 dark:bg-gray-800'}"
		>
			<div class="container mx-auto px-6 max-w-6xl">
				<TitleCard title={domain.domainTitle} alignment="center" />
				{#if domain.icon}
					<!-- Optional Icon Display -->
					<!-- <div class="text-center mt-4 text-gray-500 dark:text-gray-400">
						{#if domain.icon === 'terminal'}
							<svg
								xmlns="http://www.w3.org/2000/svg"
								width="2em"
								height="2em"
								viewBox="0 0 24 24"
								class="inline-block"
							>
								<path
									fill="currentColor"
									d="m4 17l6-6l-6-6l1.41-1.41L11.83 11l-6.42 6.41zm10.33 1.54L18.17 11l-3.84-3.84l1.41-1.41L21 11l-4.25 4.25z"
								></path>
							</svg>
						{:else if domain.icon === 'code-branch'}
							<svg
								xmlns="http://www.w3.org/2000/svg"
								width="2em"
								height="2em"
								viewBox="0 0 24 24"
								class="inline-block"
							>
								<path
									fill="currentColor"
									d="M5.1 18.5q-.875 0-1.488-.613T3 16.4V7.6q0-.875.613-1.488T5.1 5.5h3.9v2H5.1q-.25 0-.425.175T4.5 8v8.4q0 .25.175.425t.425.175h3.9v2zm13.8 0v-2h-3.9q-.25 0-.425-.175t-.175-.425V8q0-.25.175-.425T15 7.5h3.9v-2h-3.9q-.875 0-1.488.613T13 7.6v8.8q0 .875.613 1.488T15 18.5zm-7.35-3.3l-1.4-1.4L12 12l-1.85-1.8l1.4-1.4L13.4 10.6L15.2 12l-1.8 1.8z"
								></path>
							</svg>
						{:else if domain.icon === 'gamepad'}
							<svg
								xmlns="http://www.w3.org/2000/svg"
								width="2em"
								height="2em"
								viewBox="0 0 24 24"
								class="inline-block"
							>
								<path
									fill="currentColor"
									d="M17 4a4 4 0 0 0-4-4h-2a4 4 0 0 0-4 4H4a4 4 0 0 0-4 4v6a4 4 0 0 0 4 4h3v-2H4a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h3V4a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v2h3a2 2 0 0 1 2 2v6a2 2 0 0 1-2 2h-3v2h3a4 4 0 0 0 4-4V8a4 4 0 0 0-4-4M6 11H4V9h2zm4 5h-2v-2H6v-2h2v-2h2v2h2v2h-2zm8-6h-2v2h-2v2h2v2h2V9z"
								></path>
							</svg>
						{/if}
					</div> -->
				{/if}

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
									color={(category.color as TextColor) || 'gray-800'}
									class="mb-4"
								/>
								<ul class="space-y-2 flex-grow">
									{#each category.items as skill}
										<li><Text text={skill} color="gray-700" size="sm" /></li>
									{/each}
								</ul>
							</div>
						</Show>
					{/each}
				</div>
			</div>
		</section>
	{/each}

	<!-- Experience Section (Updated to use CV data) -->
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
							<Text tag="p" text={job.company} color="blue-700" size="md" />
							<Text tag="p" color="gray-500" size="sm" class="mb-4">
								{job.dates}
								{job.location ? ` | ${job.location}` : ''}
							</Text>

							<!-- Description List -->
							<ul class="list-disc list-outside ml-5 space-y-2 mb-4">
								{#each job.description as point}
									<li><Text text={point} color="gray-700" size="sm" /></li>
								{/each}
							</ul>

							<!-- Skills Learned List (Using CV skills) -->
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
									<ul class="flex flex-wrap gap-x-2 gap-y-1.5">
										{#each job.skillsLearned as skill}
											<li
												class="bg-blue-100 dark:bg-blue-900/50 text-blue-800 dark:text-blue-200 text-xs font-medium px-2.5 py-0.5 rounded-full border border-blue-200 dark:border-blue-800"
											>
												<Text text={skill} size="xs" color="inherit" />
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

	<!-- Projects Section (Updated to use CV data) -->
	<section
		id="projects-section"
		data-section-name="Projects"
		class="w-full py-16 lg:py-24 bg-white dark:bg-gray-900"
	>
		<div class="container mx-auto px-6 max-w-6xl">
			<TitleCard title="Featured Project" alignment="center" />
			<div class="mt-10 grid grid-cols-1 md:grid-cols-2 gap-8 lg:gap-12">
				{#each projects as project, i}
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
				{#if projects.length === 0}
					<div class="text-center md:col-span-2">
						<Text color="gray-500" size="sm"
							>More project details available upon request.</Text
						>
					</div>
				{/if}
				<!-- Placeholder for potential future projects -->
				{#if projects.length === 1}
					<div
						class="flex items-center justify-center text-center p-6 bg-gray-50 dark:bg-gray-800 rounded-lg shadow-sm border border-gray-200 dark:border-gray-700 md:col-start-2"
					>
						<Text color="gray-500" size="sm">
							Additional project details, including work on internal tools
							(Rust) and the game engine (Rust/wgpu), can be discussed further.
							Code samples may be available upon request, respecting
							confidentiality where applicable.
						</Text>
					</div>
				{/if}
			</div>
		</div>
	</section>

	<!-- Contact Section (Verified against CV info) -->
	<section
		id="contact-section"
		data-section-name="Contact"
		class="w-full py-16 lg:py-24 bg-gray-100 dark:bg-gray-800"
	>
		<div class="container mx-auto px-6 max-w-3xl text-center">
			<TitleCard title="Get In Touch" alignment="center" />

			<div class="mt-8 space-y-4">
				<Text tag="p" color="gray-700" size="md">
					I'm actively exploring new opportunities and collaborations where I
					can leverage my skills in systems engineering, full-stack development,
					and performance optimization.
				</Text>

				<Text tag="p" color="gray-700" size="md">
					Feel free to reach out via email or connect on LinkedIn. You can also
					find some of my public work on GitHub.
				</Text>
			</div>
			<div
				class="mt-10 flex flex-col sm:flex-row justify-center items-center gap-4 sm:gap-6"
			>
				<!-- Email Button -->
				<a
					href="mailto:ledamecrydenfalk@gmail.com"
					class="inline-block w-full sm:w-auto"
				>
					<Show delay={0.2} timing="smooth" preset="scale">
						<Button style="w-full">
							<div class="flex items-center justify-center space-x-2 px-4 py-2">
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
					</Show>
				</a>
				<!-- LinkedIn Button -->
				<a
					href="https://www.linkedin.com/in/leif-adamec-rydenfalk-5b269a261/"
					target="_blank"
					rel="noopener noreferrer"
					class="inline-block w-full sm:w-auto"
				>
					<Show delay={0.3} timing="smooth" preset="scale">
						<Button style="w-full">
							<div class="flex items-center justify-center space-x-2 px-4 py-2">
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
					</Show>
				</a>
				<!-- GitHub Button -->
				<a
					href="https://github.com/Leif-Rydenfalk"
					target="_blank"
					rel="noopener noreferrer"
					class="inline-block w-full sm:w-auto"
				>
					<Show delay={0.4} timing="smooth" preset="scale">
						<Button style="w-full">
							<div class="flex items-center justify-center space-x-2 px-4 py-2">
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
					</Show>
				</a>

				<Show delay={0.5} timing="smooth" preset="scale">
					<a
						href="/Resume - Leif Adamec Rydenfalk.pdf"
						download="Resume - Leif Adamec Rydenfalk.pdf"
						class="inline-block w-full sm:w-auto"
						aria-label="Download Leif Adamec Rydenfalk's Resume"
					>
						<Button style="w-full">
							<div class="flex items-center justify-center space-x-2 px-4 py-2">
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
								<Text text="Download Resume" size="sm" />
							</div>
						</Button>
					</a>
				</Show>
			</div>
		</div>
	</section>
</div>

<footer
	class="w-full py-4 bg-gray-100 dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700"
>
	<div class="container mx-auto px-6 text-center">
		<Text
			text={`© ${currentYear} Leif Adamec Rydenfalk. All rights reserved.`}
			color="gray-600"
			size="sm"
		></Text>
	</div>
</footer>
