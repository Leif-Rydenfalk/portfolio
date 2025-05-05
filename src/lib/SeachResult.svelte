<script>
	import { scrollToSection } from './util';
	import { onMount } from 'svelte';

	import Text from "$lib/Text.svelte";
	import Show from "$lib/Show.svelte";
	import LinkButton from './LinkButton.svelte';

	let delay = 0.1;
	onMount(()=>{
		setTimeout(()=>{
			delay = 0.0;
		}, 120);
	});

	export let searchValue = '';

	// Define the link data (without explicit delays)
	const allLinks = [
		{ text: 'Home', sectionId: 'home-section' },
		{ text: 'About', sectionId: 'about-section' },
		{ text: 'Skills', sectionId: 'skills-overview-section' },
		{ text: 'Experience', sectionId: 'experience-section' },
		{ text: 'Projects', sectionId: 'projects-section' },
		{ text: 'Contact', sectionId: 'contact-section' }
	];

	// Reactive declaration: This will re-run whenever searchValue changes
	$: filteredLinks = searchValue
		? allLinks.filter(link =>
				link.text.toLowerCase().includes(searchValue.toLowerCase().trim())
		  )
		: allLinks; // If searchValue is empty, show all links
</script>

{#if searchValue == ''}
	<Show delay={delay}>
		<Text timing={{ delay: delay }} size="sm_header" text="Quick Links" />

		<div class="h-[0.25rem]"></div>

		{#each filteredLinks as link, i (link.sectionId)}
			<LinkButton
				timing={{ delay: delay + i * 0.05 }}
				text={link.text}
				onClick={(e) => {
					scrollToSection(e, link.sectionId);
				}}
			/>
		{/each}
	</Show>
{:else}
	<Show delay={delay}>
		<Text timing={{ delay: 0.0 }} size="sm_header" text="Results" />

		<div class="h-[0.25rem]"></div>

		{#key filteredLinks.length}
			{#if filteredLinks.length > 0}
				{#each filteredLinks as link, i (link.sectionId)}
					<LinkButton
						timing={{ delay: i * 0.025 }}
						text={link.text}
						onClick={(e) => {
							scrollToSection(e, link.sectionId);
						}}
					/>
				{/each}
			{:else if searchValue.trim()}
				<!-- Only show 'No results' if there was actually a search term -->
				<div class="pt-2">
					<Text size="sm" text="No matching links found." />
				</div>
			{/if}
		{/key}
	</Show>
{/if}