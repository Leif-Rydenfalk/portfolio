<!-- src/lib/TitleCard.svelte -->
<script lang="ts">
	import Text from "$lib/Text.svelte";
	
	/**
	 * The main text to display as the title.
	 * @type {string}
	 * @required
	 */
	export let title: string;

	/**
	 * Optional subtitle text to display below the main title.
	 * @type {string | null}
	 * @default null
	 */
	export let subtitle: string | null = null;

	/**
	 * Controls the text alignment of the title and subtitle.
	 * @type {'left' | 'center' | 'right'}
	 * @default 'left'
	 */
	export let alignment: 'left' | 'center' | 'right' = 'left';

	/**
	 * Optional additional CSS classes to apply to the wrapper div.
	 * Allows for custom margin, padding, or other styles from the parent.
	 * @type {string}
	 * @default ''
	 */
	export let className: string = '';

	// --- Reactive Computations ---

	// Determine alignment class based on the prop
	$: alignmentClass = {
		left: 'text-left',
		center: 'text-center',
		right: 'text-right',
	}[alignment];

	// Combine alignment and any custom classes passed in
	$: combinedClasses = `${alignmentClass} ${className || $$props.class || ''}`.trim();

</script>

<div class="{combinedClasses}">
	<Text
		tag="h2"
		size="lg"
		text={title}
		color="gray-800"
		tracking="tight"
		style="text-3xl sm:text-4xl {subtitle ? 'mb-1' : 'mb-2'}"
	/>

	{#if subtitle}
		<Text
			tag="p"
			text={subtitle}
			color="gray-600"
			style="mt-1 text-lg"
		/>
	{/if}

	<!-- Optional: Add a subtle underline/divider, especially for centered titles -->
	{#if alignment === 'center'}
		<div class="mt-4 mx-auto h-1 w-20 bg-blue-500 rounded"></div>
	{/if}
</div>