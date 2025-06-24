import netlify from '@astrojs/netlify';
import { defineConfig } from 'astro/config';

export default defineConfig({
	output: 'server',
	site: 'https://example.com',
	integrations: [netlify()],
});
