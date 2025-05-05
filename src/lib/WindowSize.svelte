<script>
	$: innerWidth = 0
	$: innerHeight = 0
</script>

<svelte:window bind:innerWidth bind:innerHeight />

<slot width={innerWidth} height={innerHeight} />

