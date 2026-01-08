# basefn Documentation Website

This is the documentation website for the basefn UI component library, built with ReScript, Xote, and Vite.

## Prerequisites

- Node.js (v16 or higher)
- npm or yarn

## Installation

```bash
npm install
```

## Development

Run the development server:

```bash
npm run dev
```

This will:
1. Build the ReScript files
2. Start the Vite development server at `http://localhost:3000`

For continuous ReScript compilation during development, you can run in a separate terminal:

```bash
npm run res:watch
```

## Building for Production

Build the site for production:

```bash
npm run build
```

The built files will be in the `dist` directory.

## Preview Production Build

To preview the production build locally:

```bash
npm run preview
```

## Deploying to GitHub Pages

### Automatic Deployment (Configured)

A GitHub Actions workflow has been set up at `.github/workflows/deploy-docs.yml` that automatically deploys the documentation site when:
- Changes are pushed to the `main` branch in the `docs-website/` directory
- The workflow is manually triggered via the Actions tab

**To enable automatic deployment:**

1. Go to your repository Settings → Pages
2. Under "Build and deployment", select:
   - **Source**: GitHub Actions
3. Push changes to the `main` branch or manually trigger the workflow
4. The site will be available at `https://<username>.github.io/basefn/`

### Manual Deployment (Alternative)

If you prefer to deploy manually:

1. Build the project:
   ```bash
   npm run build
   ```

2. Deploy the `dist` folder to GitHub Pages using the `gh-pages` branch:
   ```bash
   npm install -g gh-pages
   gh-pages -d dist
   ```

## Project Structure

```
docs-website/
├── src/
│   ├── DocsApp.res           # Main application component
│   ├── DocsLayout.res         # Layout component
│   ├── DocsRoutes.res         # Routing configuration
│   ├── DocsComponentPage.res  # Component documentation page
│   ├── DocsExamples.res       # Component examples
│   ├── pages/                 # Documentation pages
│   │   ├── Homepage.res
│   │   ├── GettingStarted.res
│   │   ├── ApiReference.res
│   │   └── Changelog.res
│   └── styles/
│       └── variables.css      # CSS variables
├── public/                    # Static assets
├── index.html                 # Entry HTML file
├── package.json
├── rescript.json              # ReScript configuration
└── vite.config.js             # Vite configuration
```

## Technologies Used

- **ReScript**: Type-safe language that compiles to JavaScript
- **Xote**: React-like UI framework for ReScript
- **rescript-signals**: Reactive state management
- **basefn**: The UI component library being documented
- **Vite**: Fast build tool and development server
- **highlight.js**: Syntax highlighting for code examples

## Scripts

- `npm run res:build` - Build ReScript files
- `npm run res:clean` - Clean ReScript build artifacts
- `npm run res:watch` - Watch and rebuild ReScript files
- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build
