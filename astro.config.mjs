/**
 * @ai
 */

import netlify from '@astrojs/netlify/functions';
import { defineConfig } from 'astro/config';

export default defineConfig({
	adapter: netlify(),
});
