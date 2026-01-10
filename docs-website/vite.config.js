import { defineConfig } from 'vite'
import path from 'path'
import { fileURLToPath } from 'url'

const __dirname = path.dirname(fileURLToPath(import.meta.url))

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
  },

  resolve: {
    alias: {
      // Force all xote imports to use docs-website's version
      // This ensures basefn components use the same Xote Router instance
      'xote': path.resolve(__dirname, 'node_modules/xote')
    }
  },

  define: {
    // Expose GITHUB_PAGES to the client-side code
    'import.meta.env.GITHUB_PAGES': JSON.stringify(process.env.GITHUB_PAGES === 'true')
  }
})
