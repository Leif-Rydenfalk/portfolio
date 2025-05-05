<script>
import Icon from './Icon.svelte';

export let size = '2rem';
</script>

<Icon>
	<svg
		xmlns="http://www.w3.org/2000/svg"
		width={size}
		height={size}
		viewBox="0 0 24 24"
		><path
			fill="none"
			stroke="currentColor"
			stroke-linecap="round"
			stroke-linejoin="round"
			stroke-width="1.5"
			d="M19 5L5 19M5 5l14 14"
			color="currentColor"
		></path></svg
	>
</Icon>
