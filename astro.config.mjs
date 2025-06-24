import { defineConfig } from 'astro/config';
import netlify from '@astrojs/netlify';
import mdx from '@astrojs/mdx';

export default defineConfig({
  integrations: [mdx(), netlify()],
});
