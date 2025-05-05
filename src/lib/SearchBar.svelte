<script lang="js">
import { animate, inView, spring } from 'motion';
import { onMount } from 'svelte';

export let placeholder = '';
export let searchValue = '';

let containerelement;
let iconElement;
let inputElement;

onMount(() => {
	animate(
		containerelement,
		{ opacity: [0, 1], x: [50, 0], y: [-10, 0] },
		{
			easing: spring({
				stiffness: 300,
				damping: 6,
				mass: 0.8,
				velocity: 0,
				restDistance: 0.005,
				restSpeed: 0.005
			}),
			delay: 0.2
		}
	);

	animate(
		iconElement,
		{ x: [50, 0], y: [-10, 0] },
		{
			easing: spring({
				stiffness: 200,
				damping: 5,
				mass: 0.9,
				velocity: 0,
				restDistance: 0.005,
				restSpeed: 0.005
			}),
			delay: 0.2
		}
	);

	animate(
		inputElement,
		{ x: [50, 0], y: [-10, 0] },
		{
			easing: spring({
				stiffness: 300,
				damping: 4,
				mass: 1.1,
				velocity: 0,
				restDistance: 0.005,
				restSpeed: 0.005
			}),
			delay: 0.2
		}
	);
});
</script>

<div bind:this={containerelement} class="flex h-[5rem] items-center">
	<svg
		bind:this={iconElement}
		xmlns="http://www.w3.org/2000/svg"
		width="2rem"
		height="2rem"
		viewBox="0 0 16 16"
		><path
			fill="currentColor"
			fill-rule="evenodd"
			d="M11.5 7a4.5 4.5 0 1 1-9 0a4.5 4.5 0 0 1 9 0m-.82 4.74a6 6 0 1 1 1.06-1.06l2.79 2.79a.75.75 0 1 1-1.06 1.06z"
			clip-rule="evenodd"
		></path></svg
	>

	<input
		bind:this={inputElement}
		class="input w-auto bg-transparent text-black border-none active:border-none rounded-none p-2 text-[2.0rem] font-[200]"
		type="search"
		placeholder={placeholder}
		bind:value={searchValue}
	/>
</div>

<style>
input[type='search'] {
	padding: 0.1em 0.4em;
}

input[type='search'].dark {
	background: #222;
	color: #fff;
}

input[type='search'].light {
	background: #fff;
	color: #222;
}

input[type='search']::-webkit-search-cancel-button {
	-webkit-appearance: none;
	height: 0.5em;
	width: 0.5em;
	border-radius: 25em;
	background: url(https://pro.fontawesome.com/releases/v5.10.0/svgs/solid/times-circle.svg)
		no-repeat 50% 50%;
	background-size: contain;
	opacity: 0;
	pointer-events: none;
}

input[type='search']:focus::-webkit-search-cancel-button {
	opacity: 0.3;
	pointer-events: all;
}

input[type='search'].dark::-webkit-search-cancel-button {
	filter: invert(1);
}
</style>
