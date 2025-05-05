<script lang="js">
	import Icon from "./Icon.svelte";

	export let props = {};
	export let style = "";
</script>

<Icon damping={10.0}>
	<svg
		{...props}
		class={style}
		viewBox="0 0 400 400"
		fill="none"
		xmlns="http://www.w3.org/2000/svg"
	>
		<path
			d="M378.928 195.59C362.938 -3.16771 162.164 -43.5627 59.7045 93.6476C-42.7551 230.858 83.6376 370.423 200.12 370.423M363.922 210.09C360.171 215.09 34.3264 251.59 89.527 244.59M127.82 283.89C127.82 283.89 466.02 -184.174 196.103 311.423C163.97 370.423 155.106 380.583 155.106 380.583C144.192 395.089 152.231 384.089 156.269 379.077M140 269C138.275 273 121.147 290.59 129.852 281.09M194.752 370.325C215.47 370.423 226.798 373.693 191.889 370.193"
			stroke="currentColor"
			stroke-width="7"
			stroke-linecap="round"
		/>
		<path
			d="M115.351 241.733C167.422 238.34 140.786 266.5 136 274.5C144.173 261.5 156.894 241.495 115.351 241.733Z"
			stroke="currentColor"
			stroke-width="7"
			stroke-linecap="round"
		/>
		<path
			d="M360.5 210.5C370.5 209 380.5 208 378.5 188.5"
			stroke="currentColor"
			stroke-width="7"
			stroke-linecap="round"
		/>
		<path
			d="M23 188.5C94.5 -71.5 368 -11.5 378 188.5"
			stroke="currentColor"
			stroke-width="7"
			stroke-linecap="round"
		/>
		<path
			d="M167.5 366.5C58 330 -18 221.5 61 100.5"
			stroke="currentColor"
			stroke-width="7"
			stroke-linecap="round"
		/>
		<path
			d="M150.5 386C220.5 264.5 288 144 297.5 103"
			stroke="currentColor"
			stroke-width="7"
			stroke-linecap="round"
		/>
		<path
			d="M133.5 276.5C133.5 276.5 340.5 -2.99999 295.5 109.5"
			stroke="currentColor"
			stroke-width="7"
			stroke-linecap="round"
		/>
		<path
			d="M361.5 210.5C262.5 220 215 228 87 244.5"
			stroke="currentColor"
			stroke-width="7"
			stroke-linecap="round"
		/>
	</svg>
</Icon>
