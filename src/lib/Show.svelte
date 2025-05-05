<script lang="js">
import { animate, inView, spring } from 'motion';
import { onMount } from 'svelte';
import { slide } from 'svelte/transition';

export let delay = 0;
export let preset = 'default';
export let timing = 'default';

let randomDelay = Math.random() * 0.1;

let element;
onMount(() => {
	if (!element) return;

	let preset_parameters = {
		default: { scale: [0.7, 1], x: [30, 0], y: [10, 0] },
		skew: {
			scale: [0.7, 1],
			skewX: [-10, 0],
			skewY: [10, 0],
			x: [30, 0],
			y: [10, 0]
		},
		scale: { scale: [0.7, 1] },
		slide: { x: [30, 0] }
	}[preset];

	let timing_parameters = {
		default: { stiffness: 200, damping: 5, mass: 0.9 },
		smooth: { stiffness: 20, damping: 3, mass: 0.1 }
	}[timing];

	inView(element, async () => {
		if (!element) return;
		setTimeout(
			async () => {
				if (!element) return;
				animate(element, preset_parameters, {
					easing: spring({
						stiffness: timing_parameters.stiffness,
						damping: timing_parameters.damping,
						mass: timing_parameters.mass,
						restDistance: 0.005,
						restSpeed: 0.005
					}),
					delay: 0.1
				});

				// animate(
				// 	element,
				// 	{ scale: [0.7, 1], skewX: [-10, 0], skewY: [10, 0], opacity: [1] },
				// 	{
				// 		easing: spring({
				// 			stiffness: 300,
				// 			damping: 7,
				// 			mass: 0.6
				// 		})
				// 	}
				// );

				animate(
					element,
					{ opacity: [1] },
					{
						easing: spring({
							stiffness: 300,
							damping: 7,
							mass: 0.2,
							restDistance: 0.005,
							restSpeed: 0.005
						}),
						delay: 0.1
					}
				);
			},
			(delay + randomDelay) * 1000
		);
	});

	return () => {};
});
</script>

<div bind:this={element} class="opacity-0">
	<slot />
</div>
