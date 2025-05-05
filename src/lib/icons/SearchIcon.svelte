<script>
import Icon from './Icon.svelte';
</script>

<Icon>
	<svg
		xmlns="http://www.w3.org/2000/svg"
		width="2rem"
		height="2rem"
		viewBox="0 0 24 24"
		{...$$props}
	>
		<g fill="none" stroke="currentColor" stroke-width="1.5">
			<circle cx="11" cy="11" r="5.5"></circle>
			<path stroke-linecap="round" stroke-linejoin="round" d="m15 15l4 4"
			></path>
		</g>
	</svg>
</Icon>
