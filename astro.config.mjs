import mdx from '@astrojs/mdx';
/**
 * @ai
 */
import { defineConfig } from 'astro/config';

export default defineConfig({
	integrations: [mdx()],
});
