<!-- src/lib/Project.svelte -->
<script lang="ts">
import Text from '$lib/Text.svelte';

export let title: string;
export let description: string;
export let tech: string[];
export let link: string;
export let imageUrl: string;

// Determine if the link is a valid one to display (not just '#')
const hasValidLink = link && link !== '#';

// const height_class = 'h-[15rem] md:h-[22rem]';
const height_class = 'h-[17rem]';
// object-cover
</script>

<div
	class="bg-white dark:bg-gray-800 rounded-lg shadow-md overflow-hidden border border-gray-200 dark:border-gray-700 transition-shadow duration-300 hover:shadow-lg flex flex-col h-full"
>
	{#if imageUrl}
		<img
			src={imageUrl}
			alt="{title} screenshot"
			class={`w-full ${height_class} object-contain`}
		/>
	{:else}
		<!-- Optional: Placeholder if no image URL is provided -->
		<div
			class={`w-full ${height_class} bg-gray-200 dark:bg-gray-700 flex items-center justify-center`}
		>
			<Text text="No Image" color="gray-500" size="sm" />
		</div>
	{/if}

	<div class="p-6 flex flex-col flex-grow">
		<!-- Flex-grow makes this div take remaining space -->
		<Text
			tag="h3"
			text={title}
			class="text-xl mb-2 dark:text-white"
		/>

		<Text
			tag="p"
			color="gray-700"
			class="text-base mb-4 dark:text-gray-300 flex-grow"
		>
			<!-- Flex-grow makes description take available space before tech/link -->
			{description}
		</Text>

		<!-- Tech Stack Section -->
		<div class="mb-4">
			<Text
				tag="h4"
				text="Technologies Used:"
				class="text-sm font-medium mb-2 text-gray-600 dark:text-gray-400"
			/>
			<div class="flex flex-wrap gap-2">
				{#each tech as item (item)}
					<Text
						tag="span"
						text={item}
						size="tn"
						class="bg-blue-100 text-blue-800 font-medium px-2.5 py-0.5 rounded-full dark:bg-blue-900 dark:text-blue-300 whitespace-nowrap"
					/>
				{/each}
			</div>
		</div>

		<!-- Link Section (pushed to bottom) -->
		<div class="mt-auto pt-4 border-t border-gray-200 dark:border-gray-700">
			<!-- mt-auto pushes this block to the bottom -->
			<a
				href={link}
				target="_blank"
				rel="noopener noreferrer"
				class="inline-flex items-center text-blue-600 hover:text-blue-800 dark:text-blue-400 dark:hover:text-blue-300 font-medium transition-colors group"
			>
				{#if hasValidLink}
					View Project
					<div class="w-[0.4rem]"></div>
					<svg
						xmlns="http://www.w3.org/2000/svg"
						width="0.8rem"
						height="0.8rem"
						viewBox="0 0 16 16"
						><path
							fill="currentColor"
							fill-rule="evenodd"
							d="M1.25 8A.75.75 0 0 1 2 7.25h10.19L9.47 4.53a.75.75 0 0 1 1.06-1.06l4 4a.75.75 0 0 1 0 1.06l-4 4a.75.75 0 1 1-1.06-1.06l2.72-2.72H2A.75.75 0 0 1 1.25 8"
							clip-rule="evenodd"
						></path></svg
					>
				{/if}
			</a>
		</div>
	</div>
</div>

<style>
/* Add any component-specific styles here if needed, though Tailwind is preferred */
/* Ensure cards in a grid row have the same height */
.h-full {
	height: 100%;
}
</style>
