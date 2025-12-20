# Eita-UI

A simple, neutral-styled UI component library for Xote applications, built with ReScript and fine-grained reactivity.

## Features

- **Flexible reactivity** - Accept both regular values and signals for maximum flexibility
- **Fine-grained updates** - Use Xote's signal-based reactivity for optimal performance
- **Neutral, professional design** with clean aesthetics
- **Fully themeable** using CSS variables
- **Type-safe** with ReScript's powerful type system
- **Accessible** with proper ARIA attributes and semantic HTML
- **Lightweight** with minimal dependencies

## Installation

```bash
npm install
```

## Usage Patterns

Components accept both regular values and signals. Use the `Value()` constructor for static values, or `SignalValue()` for reactive signals:

```rescript
open EitaUI

// Using regular values (static)
<Button
  label={Value("Click me")}
  onClick={Some(handleClick)}
  variant={Value(Button.Primary)}
/>

// Using signals (reactive)
let labelSignal = Signal.make("Click me")
<Button
  label={SignalValue(labelSignal)}
  onClick={Some(handleClick)}
  variant={Value(Button.Primary)}
/>

// Mix and match as needed
let count = Signal.make(0)
<Button
  label={SignalValue(Signal.derived(() => `Count: ${Int.toString(Signal.get(count))}`)}
  variant={Value(Button.Primary)}  // Static variant
/>
```

For convenience, you can use the helper functions:

```rescript
open EitaUI

<Button
  label={value("Click me")}        // Same as Value("Click me")
  variant={signal(mySignal)}        // Same as SignalValue(mySignal)
/>
```

## Components

### Button
A versatile button component with three variants: Primary, Secondary, and Ghost.

```rescript
open EitaUI

let handleClick = (_evt) => Console.log("Clicked!")

// Static button
<Button
  label={value("Click me")}
  onClick={Some(handleClick)}
  variant={value(Button.Primary)}
  disabled={value(false)}
/>

// Dynamic button with signal
let isLoading = Signal.make(false)
<Button
  label={signal(Signal.derived(() =>
    Signal.get(isLoading) ? "Loading..." : "Submit"
  ))}
  onClick={Some(handleClick)}
  disabled={signal(isLoading)}
/>
```

### Input
A flexible input component supporting various input types (text, email, password, etc.).

```rescript
open EitaUI

let inputValue = Signal.make("")
let handleChange = (evt) => {
  let target = evt->JsxEvent.Form.target
  Signal.set(inputValue, target["value"])
}

<Input
  value={signal(inputValue)}
  onChange={Some(handleChange)}
  type_={value(Input.Text)}
  placeholder={value("Enter text...")}
/>
```

### Textarea
A multi-line text input component.

```rescript
open EitaUI

let textValue = Signal.make("")
let handleChange = (evt) => {
  let target = evt->JsxEvent.Form.target
  Signal.set(textValue, target["value"])
}

<Textarea
  value={signal(textValue)}
  onChange={Some(handleChange)}
  placeholder={value("Enter text...")}
  rows={value(4)}
/>
```

### Select
A dropdown selection component.

```rescript
open EitaUI

let selectedValue = Signal.make("option1")
let options = Signal.make([
  {value: "option1", label: "Option 1"},
  {value: "option2", label: "Option 2"},
  {value: "option3", label: "Option 3"},
])

<Select
  value={signal(selectedValue)}
  options={signal(options)}
  onChange={Some(handleChange)}
/>
```

### Checkbox
A checkbox input component with an integrated label.

```rescript
open EitaUI

let checked = Signal.make(false)
let handleChange = (_evt) => {
  Signal.update(checked, prev => !prev)
}

<Checkbox
  checked={signal(checked)}
  onChange={Some(handleChange)}
  label={value("Accept terms")}
/>
```

### Radio
A radio button component for mutually exclusive selections.

```rescript
open EitaUI

let selectedValue = Signal.make("option1")
let handleChange = (evt) => {
  let target = evt->JsxEvent.Form.target
  Signal.set(selectedValue, target["value"])
}

<Radio
  checked={signal(Signal.derived(() => Signal.get(selectedValue) == "option1"))}
  onChange={Some(handleChange)}
  name={value("choices")}
  value={value("option1")}
  label={value("Option 1")}
/>
```

### Label
A form label component with optional required indicator.

```rescript
open EitaUI

<Label
  htmlFor={value("email-input")}
  text={value("Email")}
  required={value(true)}
/>
```

## Theming

All components use CSS variables for styling, making them easy to customize. Override the variables in your CSS:

```css
:root {
  --eita-color-primary: #your-color;
  --eita-color-secondary: #your-color;
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
eita-ui/
├── src/
│   ├── components/     # All UI components
│   ├── styles/         # CSS variables and theming
│   └── index.res       # Main export file
├── package.json
└── rescript.json
```

## License

MIT
