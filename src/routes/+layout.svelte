<script lang="ts">
import '../app.postcss';

import Intro from '$lib/Intro.svelte';
import GotoContactButton from '$lib/GotoContactButton.svelte';
import Header from '$lib/Header.svelte';
import { appState } from '$lib/util';
import { page } from '$app/stores';

// --- DYNAMIC HEAD LOGIC ---
$: currentSection = $appState.currentVisibleSection;

// Helper function to generate dynamic page titles.
// The base name stays in every title so branded search ("Leif Rydenfalk")
// always has the name in the indexed <title>, whatever section renders first.
const NAME = 'Leif Adamec Rydenfalk';
function generateTitle(section: string): string {
	switch (section) {
		case 'About':
			return `About | ${NAME} — Systems Engineer & Founder`;
		case 'Skills':
			return `Skills: Rust, Distributed Systems, LLM Infrastructure | ${NAME}`;
		case 'Experience':
			return `Experience | ${NAME}`;
		case 'Projects':
			return `Projects: CE, Rheo, Myra/Trana, LLM Inference | ${NAME}`;
		case 'Contact':
			return `Contact | ${NAME}`;
		case 'Home':
		default:
			return `${NAME} — Systems Engineer & Founder`;
	}
}

$: isRoadmap = $page.url.pathname === '/roadmap';
$: pageTitle = isRoadmap
	? `Roadmap | ${NAME} — Building infrastructure for our next society`
	: generateTitle(currentSection);
$: metaDescription = isRoadmap
	? `The roadmap: the CE compute mesh and economy, ce-net services rebuilding the cloud, distributed LLM inference, Rheo circular commerce, Trana AI for teachers, and player-hosted game worlds — building infrastructure for our next society.`
	: `Leif Adamec Rydenfalk — systems engineer and founder in Umeå, Sweden. Builds and operates the CE peer-to-peer compute mesh and economy (ce-net.com), the Rheo resale marketplace (Rust, Stripe Connect), the Myra/Trana AI EdTech SaaS, and distributed LLM inference across heterogeneous machines. Deep Rust and TypeScript across distributed systems, financial infrastructure, and AI integration.`;
$: canonicalUrl = isRoadmap ? 'https://adamec.me/roadmap' : 'https://adamec.me/';

// Structured data (schema.org Person) — the canonical, truthful description of
// who Leif is for search engines. Links the name to his ventures and profiles.
const personJsonLd = {
	'@context': 'https://schema.org',
	'@type': 'Person',
	name: 'Leif Adamec Rydenfalk',
	alternateName: ['Leif Rydenfalk', 'Leif Adamec'],
	url: 'https://adamec.me',
	image: 'https://adamec.me/mac_screenshot.webp',
	jobTitle: 'Systems Engineer & Founder',
	description:
		'Systems engineer and founder specializing in distributed compute infrastructure, LLM inference systems, marketplaces and payment platforms, and AI-integrated production software.',
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
			name: 'CE / ce-net',
			url: 'https://ce-net.com',
			description:
				'Peer-to-peer compute mesh and economy — donated machines, capability security, credit ledger, 70+ services.'
		},
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
		'LLM Inference',
		'Peer-to-peer Networking',
		'Payment Systems',
		'Marketplace Platforms',
		'Capability Security',
		'Real-time Graphics',
		'WebGPU',
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
	<link rel="canonical" href={canonicalUrl} />

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
