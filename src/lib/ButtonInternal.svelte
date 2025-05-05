<script lang="js">
import { onMount } from 'svelte';
import { animate, inView, spring } from 'motion';
import { randomRange } from '$lib/util';

export let onClick = (e) => {};
export let style = '';
export let disabled = false;
export let delay = 0.0;

let isHovering = false;

let element;
let events = [];

onMount(() => {
	if (!element) return;
	let timing_parameters = {
		stiffness: 140,
		damping: 15.0,
		mass: 1.4
	};

	inView(element, async () => {
		if (element) {
			let randomDelay = Math.random() * 0.2;

			animate(
				element,
				{ scale: [0.0, 1.0], opacity: [0.0, 1.0] },
				{
					easing: spring({
						stiffness: timing_parameters.stiffness,
						damping: timing_parameters.damping,
						mass: timing_parameters.mass
					}),
					delay: randomDelay + delay
				}
			);
		}

		// return () => {
		// 	if (element) {
		// 		element.style.opacity = 0.0;
		// 		// animate(
		// 		// 	element,
		// 		// 	{ opacity: [1.0, 0.0] },
		// 		// 	{
		// 		// 		duration: 0.1,
		// 		// 		easing: 'linear'
		// 		// 	}
		// 		// );
		// 	}
		// };
	});

	let width = element.offsetWidth;
	let height = element.offsetHeight;
	let scalePerPx = (1.0 / width) * 500;

	let normalScale = 1.0;
	let hoverScale = 1.0 - scalePerPx * 0.002;

	let activeScale = 1.0 - scalePerPx * 0.01;
	let enterScale = 1.0 - scalePerPx * 0.01;

	let onMouseEnter = () => {
		if (disabled) return;

		isHovering = true;

		animate(
			element,
			{ scale: [enterScale, normalScale], opacity: [0.6] },
			{
				easing: spring({
					stiffness: timing_parameters.stiffness,
					damping: timing_parameters.damping,
					mass: timing_parameters.mass,
					restSpeed: 0.005,
					restDistance: 0.005
				})
			}
		);
	};

	let onMouseLeave = () => {
		isHovering = false;

		animate(
			element,
			{ scale: [hoverScale, normalScale], opacity: [1.0] },
			{
				easing: spring({
					stiffness: timing_parameters.stiffness,
					damping: timing_parameters.damping,
					mass: timing_parameters.mass,
					restSpeed: 0.005,
					restDistance: 0.005
				})
			}
		);
	};

	let onMouseDown = () => {
		if (disabled) return;
		animate(
			element,
			{ scale: [activeScale] },
			{
				easing: spring({
					stiffness: timing_parameters.stiffness,
					damping: timing_parameters.damping,
					mass: timing_parameters.mass,
					restSpeed: 0.005,
					restDistance: 0.005
				})
			}
		);
	};

	let onMouseUp = () => {
		animate(
			element,
			{ scale: [normalScale], opacity: [1.0] },
			{
				easing: spring({
					stiffness: timing_parameters.stiffness,
					damping: timing_parameters.damping,
					mass: timing_parameters.mass,
					restSpeed: 0.005,
					restDistance: 0.005
				})
			}
		);
	};

	let onTouchStart = () => {
		if (disabled) return;
		animate(
			element,
			{ scale: [activeScale] },
			{
				easing: spring({
					stiffness: timing_parameters.stiffness,
					damping: timing_parameters.damping,
					mass: timing_parameters.mass,
					restSpeed: 0.005,
					restDistance: 0.005
				})
			}
		);
	};

	let onTouchEnd = () => {
		animate(
			element,
			{ scale: [normalScale] },
			{
				easing: spring({
					stiffness: timing_parameters.stiffness,
					damping: timing_parameters.damping,
					mass: timing_parameters.mass,
					restSpeed: 0.005,
					restDistance: 0.005
				})
			}
		);
	};

	let onTouchMove = (e) => {
		// Cancel click if finger moved beyond 10px
		if (Math.abs(e.touches[0].clientX - e.targetTouches[0].clientX) > 10) {
			animate(
				element,
				{ scale: [normalScale] },
				{
					easing: spring({
						stiffness: timing_parameters.stiffness,
						damping: timing_parameters.damping,
						mass: timing_parameters.mass,
						restSpeed: 0.005,
						restDistance: 0.005
					})
				}
			);
		}
	};

	events.push({ type: 'mouseenter', handler: onMouseEnter });
	events.push({ type: 'mouseleave', handler: onMouseLeave });
	events.push({ type: 'mousedown', handler: onMouseDown });
	events.push({ type: 'mouseup', handler: onMouseUp });
	events.push({ type: 'touchstart', handler: onTouchStart });
	events.push({ type: 'touchend', handler: onTouchEnd });

	for (let event of events) {
		element.addEventListener(event.type, event.handler, {
			passive: true
		});
	}

	return () => {
		for (let event of events) {
			element.removeEventListener(event.type, event.handler);
		}
	};
});
</script>

<button
	on:click={(e) => onClick(e)}
	bind:this={element}
	class={`${style} opacity-0`}
	disabled={disabled}
>
	<slot isHovering={isHovering} />
</button>
