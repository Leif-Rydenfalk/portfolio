<script lang="js">
	import ButtonInternal from './ButtonInternal.svelte';

	export let onClick = () => {};
	export let style = '';
	export let type = 'ghost';
	export let disabled = false;
	export let delay = 0.0;
</script>

<ButtonInternal {onClick} {style} {delay} {type} {disabled} let:isHovering>
	<slot {isHovering} />
</ButtonInternal>
