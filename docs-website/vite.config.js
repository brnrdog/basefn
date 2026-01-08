import { defineConfig } from 'vite'

export default defineConfig({
  // Set base path for GitHub Pages
  // If deploying to https://username.github.io/basefn/, set base to '/basefn/'
  base: process.env.GITHUB_PAGES ? '/basefn/' : '/',

  build: {
    outDir: 'dist',
    emptyOutDir: true,
  },

  server: {
    port: 3000,
    open: true
  }
})
