<script lang="js">

import { onMount } from 'svelte';
import { get } from 'svelte/store';

import { animate, spring } from 'motion';

import MenuSection from './MenuSection.svelte';
import SearchSection from './SearchSection.svelte';
import Button from './Button.svelte';
import Text from './Text.svelte';
import CancelIcon from './icons/CancelIcon.svelte';
import SearchIcon from './icons/SearchIcon.svelte';
import MenuIcon from './icons/MenuIcon.svelte';
import Logo from './icons/Logo.svelte';
import WindowSize from './WindowSize.svelte';
import { scrollToSection } from './util';

let expanded = false;
let expanded_element;
let prev_expanded_element_height = 0;

let header_background;

let close_arrow;

let tab = '';

let set_tab = (value) => {
	if (tab === value) {
		value = '';
	}

	tab = value;

	expanded = value !== '';

	update_expanded();
};

function update_expanded() {
	if (expanded) {
		// if (background) {
		// 	background.style = background_class;
		// }

		setTimeout(async () => {
			let height = expanded_element.offsetHeight;
			animate(
				header_background,
				{ height: [`${expanded_element.offsetHeight}px`] },
				{
					easing: spring({
						stiffness: 100,
						damping: 8,
						mass: 0.5,
						restDistance: 0.005,
						restSpeed: 0.005
					})
					// easing: 'linear',
					// duration: 0.01
				}
			);

			animate(
				close_arrow,
				{ y: [`100px`, `0px`], opacity: [1] },
				{
					easing: spring({
						stiffness: 100,
						damping: 8,
						mass: 0.5,
						restDistance: 0.005,
						restSpeed: 0.005
					}),
					delay: 0.3
				}
			);
		}, 1);
	} else {
		// if (background) {
		// 	background.style = '';
		// }
		// cart.set_open(false);
		tab = '';

		setTimeout(async () => {
			animate(
				header_background,
				{ height: [`0px`] },
				{
					easing: spring({
						stiffness: 50,
						damping: 16,
						mass: 0.5,
						restDistance: 0.005,
						restSpeed: 0.005
					})
				}
			);
		}, 20);
	}
}

onMount(() => {
	set_tab('');
});

let show = true;
</script>

{#if show}
	<!-- <div bind:this={background} /> -->

	<!-- <BackgroundBlur show={expanded} /> -->

	{#if tab !== ''}
		<div class="fixed top-0 h-screen w-screen bg-black opacity-20 z-[9950]">
			<Button
				onClick={() => {
					set_tab('');
				}}
			>
				<div class="h-screen w-screen bg-transparent z-[9950]"></div>
			</Button>
		</div>

		<div
			class="fixed bottom-[5rem] w-screen z-[9999] flex justify-center items-center"
		>
			<div bind:this={close_arrow} class="opacity-0">
				<Button
					style="h-[3.0rem] w-[4.0rem] flex justify-center items-center text-white bg-black rounded-3xl drop-shadow-xl shadow-[0_0px_35px_rgba(255,255,255,0.25)]"
					delay={0.4}
					onClick={() => {
						set_tab('');
					}}
				>
					<svg
						xmlns="http://www.w3.org/2000/svg"
						width="2.0rem"
						height="2.0rem"
						viewBox="0 0 1024 1024"
						><path
							fill="currentColor"
							d="M104.704 685.248a64 64 0 0 0 90.496 0l316.8-316.8l316.8 316.8a64 64 0 0 0 90.496-90.496L557.248 232.704a64 64 0 0 0-90.496 0L104.704 594.752a64 64 0 0 0 0 90.496"
						></path></svg
					>
				</Button>
			</div>
		</div>
	{/if}

	<div class="fixed top-0 h-[4rem] w-screen bg-white z-[9956]"></div>

	<div
		bind:this={header_background}
		class="fixed top-[4rem] w-screen bg-white z-[9956]"
	></div>

	<div
		bind:this={expanded_element}
		class="fixed top-0 w-screen h-auto flex flex-col items-center z-[9959]"
	>
		<div class="w-screen md:w-[70vw] lg:w-[50vw]">
			<div class="h-[4rem] flex justify-between items-center">
				{#if tab === ''}
					<Button
						style="h-[4.0rem] w-[5.0rem] flex justify-center items-center"
						delay={0.7}
						onClick={(e) => {
							scrollToSection(e, 'home-section');
						}}
					>
						<Logo style="w-[2.2rem] h-[2.2rem]" />
					</Button>
				{:else}
					<div></div>
				{/if}

				<WindowSize let:width>
					{#if width > 768}
						<div class="flex flex-row justify-center">
							{#if tab === ''}
								<Button
									style="h-[4.0rem] w-[6.2rem] flex justify-center items-center"
									delay={0.2}
									onClick={(e) => {
										scrollToSection(e, 'about-section');
									}}
								>
									<Text timing={{ delay: 0.2 }} text="About" size="tn_header" />
								</Button>
								<Button
									style="h-[4.0rem] w-[6.2rem] flex justify-center items-center"
									delay={0.6}
									onClick={(e) => {
										scrollToSection(e, 'skills-overview-section');
									}}
								>
									<Text
										timing={{ delay: 0.4 }}
										text="Skills"
										size="tn_header"
									/>
								</Button>
								<Button
									style="h-[4.0rem] w-[6.2rem] flex justify-center items-center"
									delay={0.4}
									onClick={(e) => {
										scrollToSection(e, 'projects-section');
									}}
								>
									<Text
										timing={{ delay: 0.3 }}
										text="Projects"
										size="tn_header"
									/>
								</Button>
								<Button
									style="h-[4.0rem] w-[6.2rem] flex justify-center items-center"
									delay={0.8}
									onClick={(e) => {
										scrollToSection(e, 'contact-section');
									}}
								>
									<Text
										timing={{ delay: 0.5 }}
										text="Contact"
										size="tn_header"
									/>
								</Button>
							{/if}
						</div>
					{/if}
				</WindowSize>

				<div class="flex flex-row gap-2 lg:gap-[0rem]">
					{#if tab === ''}
						<Button
							style="h-[4.0rem] w-[4.1rem] flex justify-center items-center"
							delay={0.6}
							onClick={() => {
								set_tab('search');
							}}
						>
							{#if tab === 'search'}
								<CancelIcon />
							{:else}
								<SearchIcon />
							{/if}
						</Button>
					{/if}

					{#if tab === ''}
						<Button
							style="h-[4.0rem] w-[4.1rem] flex justify-center items-center pr-10"
							delay={0.4}
							onClick={() => {
								set_tab('menu');
							}}
						>
							{#if tab === 'menu'}
								<CancelIcon />
							{:else}
								<MenuIcon />
							{/if}
						</Button>
					{:else}
						<Button
							style="h-[4.0rem] w-[4.0rem] flex justify-center items-center pr-10"
							delay={0.2}
							onClick={() => {
								set_tab('');
							}}
						>
							<CancelIcon />
						</Button>
					{/if}
				</div>
			</div>

			{#if tab !== ''}
				<div class="h-[3rem]"></div>
			{/if}

			<div class="px-6 flex flex-col justify-start items-start">
				{#if tab === 'search'}
					<SearchSection />
				{/if}

				{#if tab === 'menu'}
					<MenuSection set_tab={set_tab} />
				{/if}
			</div>
			{#if tab !== ''}
				<div class="h-[2rem]"></div>
			{/if}
		</div>
	</div>
{/if}
