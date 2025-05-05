<script lang="js">
	import Text from "$lib/Text.svelte";
	import Show from "$lib/Show.svelte";
	import Button from "$lib/Button.svelte";
	import SearchBar from './SearchBar.svelte';
	import SeachResult from './SeachResult.svelte';
			
	let searchValue = '';
</script>


<Show preset="slide" delay={0.1}>
	<SearchBar placeholder="Search adamec.me" bind:searchValue />
	
	<div class="h-[3rem]"></div>

	<SeachResult bind:searchValue />
</Show>