<script>
import Icon from './Icon.svelte';
</script>

<Icon>
	<svg
		xmlns="http://www.w3.org/2000/svg"
		width="1.5rem"
		height="1.5rem"
		viewBox="0 0 16 16"
		{...$$props}
	>
		<path
			fill="currentColor"
			fill-rule="evenodd"
			d="M1.25 3.25A.75.75 0 0 1 2 2.5h12A.75.75 0 0 1 14 4H2a.75.75 0 0 1-.75-.75m0 4.75A.75.75 0 0 1 2 7.25h12a.75.75 0 0 1 0 1.5H2A.75.75 0 0 1 1.25 8M2 12a.75.75 0 0 0 0 1.5h12a.75.75 0 0 0 0-1.5z"
			clip-rule="evenodd"
		></path>
	</svg>
</Icon>
