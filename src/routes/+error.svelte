<script lang="ts">
import { onMount } from 'svelte';
import { goto } from '$app/navigation';
import { page } from '$app/stores';
import Show from '$lib/Show.svelte';
import Text from '$lib/Text.svelte';

onMount(() => {
	// Check specifically for the 404 (Not Found) status code
	if ($page.status === 404) {
		console.log(
			`Route not found (${window.location.pathname}). Redirecting to /`
		);
		// Redirect immediately to the root/main page.
		// 'replaceState: true' is important! It prevents the invalid URL
		// from being added to the browser's history stack.
		goto('/', { replaceState: true });
	}
	// You could add logic here to handle other error codes differently if needed
	// else {
	//   console.error("An unexpected error occurred:", $page.status, $page.error);
	//   // Maybe show a different message or log more details for non-404s
	// }
});
</script>

<div class="h-[100vh] flex flex-col justify-center text-center">
	<Show>
		<Text text={$page.status.toString()} size="xl_title" />
		<Text timing={{ delay: 0.2 }} text={$page.error?.message} size="xl_title" />
	</Show>
</div>
