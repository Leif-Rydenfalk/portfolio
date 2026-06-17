<script lang="ts">
import '../app.postcss';

import Intro from '$lib/Intro.svelte';
import GotoContactButton from '$lib/GotoContactButton.svelte';
import Header from '$lib/Header.svelte';
import { appState } from '$lib/util';

// --- DYNAMIC HEAD LOGIC ---
$: currentSection = $appState.currentVisibleSection;

// Helper function to generate dynamic page titles.
// The base name stays in every title so branded search ("Leif Rydenfalk")
// always has the name in the indexed <title>, whatever section renders first.
const NAME = 'Leif Adamec Rydenfalk';
function generateTitle(section: string): string {
	switch (section) {
		case 'About':
			return `About | ${NAME} — Systems & Full-Stack Engineer`;
		case 'Skills':
			return `Skills: Rust, TypeScript, Distributed Systems | ${NAME}`;
		case 'Experience':
			return `Experience | ${NAME}`;
		case 'Projects':
			return `Projects: Rheo, Myra/Trana, Cell | ${NAME}`;
		case 'Contact':
			return `Contact | ${NAME}`;
		case 'Home':
		default:
			return `${NAME} — Systems & Full-Stack Engineer, Founder`;
	}
}

$: pageTitle = generateTitle(currentSection);
let metaDescription = `Leif Adamec Rydenfalk — systems & full-stack software engineer and founder in Umeå, Sweden. Founder of the Rheo resale marketplace (Rust) and the Myra/Trana AI EdTech SaaS. Deep Rust experience across distributed systems, real-time graphics, and AI agent tooling (MCP). Explore projects, skills, and experience.`;

// Structured data (schema.org Person) — the canonical, truthful description of
// who Leif is for search engines. Links the name to his ventures and profiles.
const personJsonLd = {
	'@context': 'https://schema.org',
	'@type': 'Person',
	name: 'Leif Adamec Rydenfalk',
	alternateName: ['Leif Rydenfalk', 'Leif Adamec'],
	url: 'https://adamec.me',
	image: 'https://adamec.me/mac_screenshot.webp',
	jobTitle: 'Software Engineer & Founder',
	description:
		'Systems and full-stack software engineer and founder specializing in Rust, distributed systems, real-time graphics, and AI agent tooling.',
	email: 'mailto:ledamecrydenfalk@gmail.com',
	address: {
		'@type': 'PostalAddress',
		addressLocality: 'Umeå',
		addressRegion: 'Västerbotten County',
		addressCountry: 'SE'
	},
	worksFor: { '@type': 'Organization', name: 'Rydenfalk Systems' },
	founder: [
		{
			'@type': 'Organization',
			name: 'Rheo',
			url: 'https://rheo.se',
			description: 'Mobile-first resale marketplace built in Rust.'
		},
		{
			'@type': 'Organization',
			name: 'Myra / Trana',
			url: 'https://trana.app',
			description: 'AI lesson-material SaaS for Swedish teachers.'
		}
	],
	knowsAbout: [
		'Rust',
		'TypeScript',
		'Distributed Systems',
		'Peer-to-peer Networking',
		'Real-time Graphics',
		'wgpu',
		'WebGPU',
		'Game Engine Development',
		'AI Agents',
		'Model Context Protocol',
		'Full-Stack Web Development'
	],
	sameAs: [
		'https://github.com/Leif-Rydenfalk',
		'https://www.linkedin.com/in/leif-adamec-rydenfalk-5b269a261/'
	]
};
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

	<!-- Structured data: schema.org Person -->
	{@html `<script type="application/ld+json">${JSON.stringify(personJsonLd)}</` + `script>`}

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
