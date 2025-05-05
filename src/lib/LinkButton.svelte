<script lang="js">
	import { onMount } from 'svelte';
	import Text from "$lib/Text.svelte";
	import { animate, spring } from 'motion';

	export let onClick = (e) => {};
	export let text = 'Review your cart';

	export let timing = {};

	let containerElement;
	let iconElement;
	let textElement;

	onMount(() => {
		if (!timing.delay) timing.delay = 0.1;
		if (!timing.animation) timing.animation = 'default';

		if (timing.animation === 'default') {
			if (containerElement) {
				animate(
					containerElement,
					{ opacity: [0, 1], x: [50, 0], y: [-10, 0] },
					{
						easing: spring({
							stiffness: 200,
							damping: 5,
							mass: 0.9,

							restDistance: 0.005,
							restSpeed: 0.005
						}),
						delay: timing.delay
					}
				);
			}

			if (iconElement) {
				animate(
					iconElement,
					{ x: [-30, 0] },
					{
						easing: spring({
							stiffness: 300,
							damping: 4,
							mass: 0.8,

							restDistance: 0.005,
							restSpeed: 0.005
						}),
						delay: timing.delay
					}
				);
			}

			if (textElement) {
				animate(
					textElement,
					{ x: [-30, 0] },
					{
						easing: spring({
							stiffness: 400,
							damping: 4,
							mass: 0.7,
							restDistance: 0.005,
							restSpeed: 0.005
						}),
						delay: timing.delay
					}
				);
			}
		}
	});
</script>

<button
	on:click={onClick}
	class={`my-[0.1rem] px-[0.3rem] w-full h-[1.5rem]
    group bg-transparent hover:bg-slate-50 rounded-md flex justify-start items-center text-[0.9rem] font-[200] text-black active:scale-100 
    transition-colors duration-500 ease-in-out`}
>
	<div bind:this={containerElement} class="flex justify-end items-center">
		<div
			bind:this={iconElement}
			class="w-[2rem] text-slate-400 group-hover:text-slate-700 transition-colors duration-200 ease-in-out"
		>
			<svg xmlns="http://www.w3.org/2000/svg" width="0.8rem" height="0.8rem" viewBox="0 0 16 16"
				><path
					fill="currentColor"
					fill-rule="evenodd"
					d="M1.25 8A.75.75 0 0 1 2 7.25h10.19L9.47 4.53a.75.75 0 0 1 1.06-1.06l4 4a.75.75 0 0 1 0 1.06l-4 4a.75.75 0 1 1-1.06-1.06l2.72-2.72H2A.75.75 0 0 1 1.25 8"
					clip-rule="evenodd"
				/></svg
			>
		</div>

		<div bind:this={textElement}>
			<Text size="sm" {text} />
		</div>
	</div>
</button>
