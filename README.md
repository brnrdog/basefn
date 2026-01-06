# basefn-UI

A simple, neutrally styled UI component library for [Xote](https://github.com/brnrdog/xote) applications, primarily used to battle-test the Xote framework against a real-world user interface system.

## Installation

```bash
npm install basefn
```

Make sure you have installed [xote](https://github.com/brnrdog/xote) and [rescript-signals](https://github.com/brnrdog/rescript-signals).

## Usage Patterns

Components accept both regular values and signals. Use the `static()` for static values, or `reactive()` for reactive signals:

```rescript
open basefnUI
open ReactiveProp

// Using regular values (static)
<Button
  variant={Button.Primary}
  label={static("Click me")}
  onClick={_ => Console.log("You clicked!")}
/>

// Using signals (reactive)
let labelSignal = Signal.make("Click me")
<Button
  variant={Button.Primary}
  label={reactive(labelSignal)}
  onClick={_ => Signal.set(labelSignal, "You clicked!")}
/>
```

## Components

See the available components at [src/components](https://github.com/brnrdog/basefn-ui/tree/main/src/components). Contributions are welcome if features are missing.

## Theming

All components use CSS variables for styling, making them easy to customize. Override the variables in your CSS:

```css
:root {
  --basefn-color-primary: #your-color;
  --basefn-color-secondary: #your-color;
  /* ... other variables */
}
```

See `src/styles/variables.css` for all available CSS variables.

## Development

```bash
# Install dependencies
npm install

# Start development server with Vite (hot reload)
npm run dev

# Build ReScript code
npm run build

# Watch mode for ReScript
npm run watch

# Build for production
npm run build:vite

# Preview production build
npm run preview

# Clean ReScript build
npm run clean
```

### Running the Demo

1. Install dependencies: `npm install`
2. Build the ReScript code: `npm run build`
3. Start the dev server: `npm run dev`
4. Open your browser to `http://localhost:3000`

The demo application showcases all components with live form state updates.

## Project Structure

```
basefn-ui/
├── src/
│   ├── components/     # All UI components
│   ├── styles/         # CSS variables and theming
│   ├── Basefn__Dom.res # Simple dom bindings used in the lib
│   └── Basefn.res       # Main export file
├── package.json
└── rescript.json
```

## License

MIT
