// @ts-check
import netlify from '@astrojs/netlify';
import { defineConfig } from 'astro/config';

/**
 * @type {import('astro/config').AstroUserConfig}
 */
// @ai Ensure Netlify adapter is configured
export default defineConfig({
	output: 'server',
	adapter: netlify(),
});
