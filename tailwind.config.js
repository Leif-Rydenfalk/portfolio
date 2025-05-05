import { join } from 'path';

import { createRequire } from 'module';
const require = createRequire(import.meta.url);

const config = {
	// 2. Opt for dark mode to be handled via the class method
	darkMode: 'class',
	content: [
		'./src/**/*.{html,js,svelte,ts}',
	],
	theme: {
		extend: {}
	},
	plugins: [

	]
};

export default config;
