<script lang="js">

	import { animate, spring } from 'motion';
	import { onMount } from 'svelte';
	import Logo from './icons/Logo.svelte';

	let div;
	let logo;

	onMount(() => {
		animate(
			logo,
			{ opacity: [0, 1], y: [-80, 0] },
			{
				delay: 0.0,
				easing: spring({
					stiffness: 400,
					damping: 17,
					restDistance: 0.005,
					restSpeed: 0.005
				})
			}
		);

		animate(div, { opacity: [0] }, { delay: 0.3, duration: 0.5 });

		// remove the div from the DOM once the animation is complete
		setTimeout(async () => {
			div.remove();
		}, 800);
	});
</script>

<div
	bind:this={div}
	class="fixed bg-white h-[90%] w-screen flex justify-center items-center z-[9999]"
>
	<div bind:this={logo} class="opacity-0">
		<Logo style="w-[10rem] h-[10rem]" />
	</div>
</div>