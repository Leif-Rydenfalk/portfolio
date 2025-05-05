<script lang="js">
import Text from "$lib/Text.svelte";
import Show from "$lib/Show.svelte";
import Button from "$lib/Button.svelte";
import { scrollToSection } from './util';
	
export let set_tab = () => {};
</script>

<Show timing="smooth">
	<div class="h-[3rem]">
		<Show timing="smooth">
			<Button
				delay={0.1}
				onClick={(e) => {
					set_tab('');
					scrollToSection(e, 'home-section');
				}}
			>
				<Text timing={{ delay: 0.2 }} text="Home" size="md" />
			</Button>
		</Show>
	</div>
	<div class="h-[3rem]">
		<Show timing="smooth">
			<Button
				delay={0.2}
				onClick={(e) => {
					set_tab('');
					scrollToSection(e, 'about-section');
				}}
			>
				<Text timing={{ delay: 0.3 }} text="About" size="md" />
			</Button>
		</Show>
	</div>
	<div class="h-[3rem]">
		<Show timing="smooth">
			<Button
				delay={0.3}
				onClick={(e) => {
					set_tab('');
					scrollToSection(e, 'projects-section');
				}}
			>
				<Text timing={{ delay: 0.4 }} text="Projects" size="md" />
			</Button>
		</Show>
	</div>
	<div class="h-[3rem]">
		<Show timing="smooth">
			<Button
				delay={0.4}
				onClick={(e) => {
					set_tab('');
					scrollToSection(e, 'skills-overview-section');
				}}
			>
				<Text timing={{ delay: 0.5 }} text="Skills" size="md" />
			</Button>
		</Show>
	</div>
	<div class="h-[3rem]">
		<Show timing="smooth">
			<Button
				delay={0.5}
				onClick={(e) => {
					set_tab('');
					scrollToSection(e, 'experience-section');
				}}
			>
				<Text timing={{ delay: 0.6 }} text="Experience" size="md" />
			</Button>
		</Show>
	</div>
	<div class="h-[3rem]">
		<Show timing="smooth">
			<Button
				delay={0.6}
				onClick={(e) => {
					set_tab('');
					scrollToSection(e, 'contact-section');
				}}
			>
				<Text timing={{ delay: 0.7 }} text="Contact" size="md" />
			</Button>
		</Show>
	</div>
</Show>
