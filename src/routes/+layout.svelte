<script lang="ts">
import '../app.postcss';

import Intro from '$lib/Intro.svelte';
import GotoContactButton from '$lib/GotoContactButton.svelte';
import Header from '$lib/Header.svelte';
import { appState } from '$lib/util';

// --- DYNAMIC HEAD LOGIC ---
$: currentSection = $appState.currentVisibleSection;

// Helper function to generate dynamic page titles
function generateTitle(section: string): string {
	switch (section) {
		case 'Home':
			return `Portfolio`;
		case 'About':
			return `About Me | Background & Philosophy`;
		case 'Skills':
			return `Technical Skills | Rust, TS, Web, Systems`;
		case 'Experience':
			return `Professional Experience`;
		case 'Projects':
			return `Featured Projects`;
		case 'Contact':
			return `Contact Me`;
		default:
			return `Portfolio`;
	}
}

$: pageTitle = generateTitle(currentSection);
let metaDescription = `Portfolio of Leif Adamec Rydenfalk, Full-Stack Software Engineer, AI tools and Systems Engineer based in Umeå, Sweden. Specializing in Rust, TypeScript, SvelteKit, full-stack development, and systems/game engine technology. Explore projects, skills, and experience. Detailed overview of Leif Adamec Rydenfalk's technical skills: Expertise includes Rust, TypeScript, C++, Systems Programming, Full-Stack Web Dev (SvelteKit, Node.js), Game Engines (wgpu), DevOps, and more.`;
</script>

<svelte:head>
	<title>{pageTitle}</title>
	<meta name="description" content={metaDescription} />

	<!-- Open Graph / Facebook -->
	<meta property="og:type" content="website" />
	<meta property="og:url" content="https://adamec.me/" />
	<meta property="og:title" content={pageTitle} />
	<meta property="og:description" content={metaDescription} />
	<meta property="og:image" content="https://adamec.me/mac_screenshot.webp" />
	<meta
		property="og:image:alt"
		content="Screenshot of Leif Adamec Rydenfalk's Portfolio Website"
	/>

	<!-- Twitter -->
	<meta property="twitter:card" content="summary_large_image" />
	<meta property="twitter:url" content="https://adamec.me/" />
	<meta property="twitter:title" content={pageTitle} />
	<meta property="twitter:description" content={metaDescription} />
	<meta
		property="twitter:image"
		content="https://adamec.me/mac_screenshot.webp"
	/>
	<meta
		property="twitter:image:alt"
		content="Screenshot of Leif Adamec Rydenfalk's Portfolio Website"
	/>

	<!-- Canonical URL -->
	<link rel="canonical" href="https://adamec.me/" />

	<!-- Keywords (less impactful for SEO now, but doesn't hurt) -->
	<meta
		name="keywords"
		content="Leif Adamec Rydenfalk, Leif Adamec, Leif Rydenfalk, Leif Rydenfalk portfolio, Leif Adamec Rydenfalk CV, Leif Adamec Rydenfalk Hemsida, portfolio, software engineer, systems engineer, rust developer, typescript, sveltekit, full-stack, game engine development, web development, Umeå, Sweden"
	/>
</svelte:head>

<GotoContactButton />

<Intro />

<Header />

<slot />
