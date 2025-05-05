<script>
import { scrollToSection } from './util';

import Text from "$lib/Text.svelte";
import Show from "$lib/Show.svelte";
import Button from "$lib/Button.svelte";
import Icon from "./icons/Icon.svelte";
</script>

<div
	class="hidden lg:inline fixed bottom-[0.5rem] right-[0.5rem] lg:bottom-[1.9rem] lg:right-[1.9rem] z-[1001]"
>
	<Button delay={0.2}>
		<div
			class="text-black justify-center items-center bg-white rounded-3xl drop-shadow-xl scale-90 hover:scale-100 transition-transform ease-spring-smooth-slow"
		>
			<div class="px-2">
				<Text text="Tap" size="tn" />
			</div>
		</div>
	</Button>
</div>

<div class="fixed bottom-[1rem] right-[1rem] lg:bottom-10 lg:right-10 z-[1000]">
	<Button
		onClick={(e) => {
			scrollToSection(e, 'contact-section');
		}}
	>
		<div
			class="text-white justify-center items-center bg-black rounded-3xl drop-shadow-xl shadow-[0_0px_35px_rgba(255,255,255,0.2)] scale-90 hover:scale-100 transition-transform ease-spring-smooth-slow"
		>
			<div class="p-4 lg:p-6">
				<div class="flex gap-3 items-center justify-center">
					<Icon>
						<Show delay={0.2}>
							<svg
								xmlns="http://www.w3.org/2000/svg"
								width="2.5rem"
								height="2.5rem"
								viewBox="0 0 24 24"
								><path
									fill="currentColor"
									d="M11.953 2.25c-2.317 0-4.118 0-5.52.15c-1.418.153-2.541.47-3.437 1.186c-.92.736-1.35 1.693-1.553 2.9c-.193 1.152-.193 2.618-.193 4.446v.183c0 1.782 0 3.015.2 3.934c.108.495.278.925.545 1.323c.264.392.6.722 1.001 1.042c.631.505 1.375.81 2.254 1V21a.75.75 0 0 0 1.123.65c.586-.335 1.105-.7 1.58-1.044l.304-.221a22 22 0 0 1 1.036-.73c.844-.548 1.65-.905 2.707-.905h.047c2.317 0 4.118 0 5.52-.15c1.418-.153 2.541-.47 3.437-1.186c.4-.32.737-.65 1-1.042c.268-.398.438-.828.546-1.323c.2-.919.2-2.152.2-3.934v-.183c0-1.828 0-3.294-.193-4.445c-.203-1.208-.633-2.165-1.553-2.901c-.896-.717-2.019-1.033-3.437-1.185c-1.402-.151-3.203-.151-5.52-.151zm.047 5a.75.75 0 0 1 .75.75v1.75h1.75a.75.75 0 0 1 0 1.5h-1.75V13a.75.75 0 0 1-1.5 0v-1.75H9.5a.75.75 0 0 1 0-1.5h1.75V8a.75.75 0 0 1 .75-.75"
								></path></svg
							>
						</Show>
					</Icon>
				</div>
			</div>
		</div>
	</Button>
</div>
