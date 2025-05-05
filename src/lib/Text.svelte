<script lang="ts">
type TextTag = 'p' | 'span' | 'h1' | 'h2' | 'h3' | 'h4' | 'h5' | 'h6' | 'div' | 'li';
	type TextSize = 'xl_title' | 'xl_header' | 'xl' | 'lg_header' | 'lg' | 'md_header' | 'md' | 'sm_header' | 'sm' | 'sm_link' | 'tn';
	type TextWeight = 'heavy' | 'bold' | 'light' | ''; // Added '' for default
	type TextColor = 'default' | 'primary' | 'secondary' | 'contrast' | 'red' | 'blue' | 'gray-900' | 'gray-800' | 'blue-700' | 'gray-700' | 'gray-600' | 'gray-500' | 'blue-600' | 'green-600' | 'purple-600' | 'red-600' | 'yellow-600' | 'orange-600' | 'cyan-600' | 'lime-600' | 'teal-600' | 'pink-600' | 'indigo-600'; // Added more colors from skills data & HTML
	type TextTracking = 'default' | 'wide' | 'ultra_wide' | 'normal' | 'tight'; // Added more options

	let className = ''; // Renamed from 'style' prop to avoid conflict with style attribute
	export { className as class }; // Use `class` directive for external classes
	export let text: string | undefined = undefined;
	export let tag: TextTag = 'span';
	export let size: TextSize = 'sm';
	export let weight: TextWeight = '';
	export let color: TextColor = 'default';
	export let tracking: TextTracking = 'default';

	const size_classes: Record<TextSize, string> = {
		xl_title: 'text-[3rem] md:text-[3.5rem] leading-[3.5rem]',
		xl_header: 'text-[2.5rem] md:text-[2.8rem] leading-[3.2rem]',
		xl: 'text-[2.5rem] leading-[3.5rem]',
		lg_header: 'text-[2.0rem] leading-[2.5rem]', // Adjusted leading for header
		lg: 'text-[1.8rem] leading-[2.2rem]', // Slightly smaller than lg_header
		md_header: 'text-[1.5rem] leading-[2rem]', // Adjusted leading for header
		md: 'text-[1.25rem] leading-[1.75rem]', // Standard Tailwind text-xl equivalent
		sm_header: 'text-[1.1rem] leading-[1.3rem]',
		sm: 'text-[1rem] leading-[1.5rem]',      // Standard Tailwind text-base
		sm_link: 'text-[0.9rem] leading-[1rem]',
		tn: 'text-[0.7rem] leading-[1rem]'
	};

	const weight_classes: Record<Exclude<TextWeight, ''>, string> = { // Exclude '' key
		heavy: 'font-[900]',
		bold: 'font-semibold',
		light: 'font-light' // Changed to font-light (300)
	};

	const color_classes: Record<TextColor, string> = {
		default: '', // Inherit color by default
		primary: 'text-gray-900 dark:text-gray-100', // Added dark mode default
		secondary: 'text-gray-500 dark:text-gray-400', // Added dark mode default
		contrast: 'text-white dark:text-black', // Adjusted contrast
		red: 'text-[#ff1231]',
		blue: 'text-[#0291f7]',
        // Added based on resume code & needs
        'gray-800': 'text-gray-800 dark:text-gray-100',
        'blue-700': 'text-blue-700 dark:text-blue-300',
        'gray-700': 'text-gray-700 dark:text-gray-300',
        'gray-600': 'text-gray-600 dark:text-gray-400',
        'gray-500': 'text-gray-500 dark:text-gray-400',
        'blue-600': 'text-blue-600 dark:text-blue-400',
        'green-600': 'text-green-600 dark:text-green-400',
        'purple-600': 'text-purple-600 dark:text-purple-400',
        'red-600': 'text-red-600 dark:text-red-400',
        'yellow-600': 'text-yellow-600 dark:text-yellow-400',
        'orange-600': 'text-orange-600 dark:text-orange-400',
        'cyan-600': 'text-cyan-600 dark:text-cyan-400',
        'lime-600': 'text-lime-600 dark:text-lime-400',
        'teal-600': 'text-teal-600 dark:text-teal-400',
        'pink-600': 'text-pink-600 dark:text-pink-400',
        'indigo-600': 'text-indigo-600 dark:text-indigo-400',
	};

	const tracking_classes: Record<TextTracking, string> = {
		default: 'tracking-normal', // Explicit default
		wide: 'tracking-wide',
        normal: 'tracking-normal',
        tight: 'tracking-tight',
		ultra_wide: 'tracking-[0.9rem]'
	};

	// --- Reactive Calculation of Combined Classes ---
	$: finalClasses = [
        'text', // Base class - useful? maybe remove if causing issues
		size_classes[size] || size_classes['sm'], // Fallback to 'sm'
		weight_classes[weight] || '', // Use || '' for optional props
		color_classes[color] || '', // Default handled by empty string
		tracking_classes[tracking] || tracking_classes['default'], // Fallback to default
		className // Include external classes passed via `class` directive
	]
	.filter(Boolean) // Remove empty strings
	.join(' ');
</script>

<svelte:element this={tag} class={finalClasses}>
	{#if text !== undefined}
		{text}
	{:else}
		<slot></slot>
	{/if}
</svelte:element>