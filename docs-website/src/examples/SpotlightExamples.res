open Xote
open Basefn

let examples: array<DocsExample.t> = {
  open Component
  [
    {
      title: "Basic Spotlight",
      description: "A searchable command palette with keyboard navigation.",
      demo: {
        let isOpen = Signal.make(false)
        let items: array<Spotlight.spotlightItem> = [
          {
            id: "home",
            label: "Home",
            description: ?Some("Go to the homepage"),
            group: ?Some("Pages"),
            onSelect: () => (),
          },
          {
            id: "docs",
            label: "Documentation",
            description: ?Some("Read the docs"),
            group: ?Some("Pages"),
            onSelect: () => (),
          },
          {
            id: "api",
            label: "API Reference",
            description: ?Some("View API details"),
            group: ?Some("Pages"),
            onSelect: () => (),
          },
          {
            id: "toggle-theme",
            label: "Toggle Theme",
            description: ?Some("Switch between light and dark mode"),
            group: ?Some("Actions"),
            onSelect: () => (),
          },
          {
            id: "github",
            label: "GitHub Repository",
            description: ?Some("View source code"),
            group: ?Some("Actions"),
            onSelect: () => (),
          },
        ]
        <div>
          <Button onClick={_ => Signal.set(isOpen, true)}>
            {text("Open Spotlight")}
          </Button>
          <Spotlight isOpen items onClose={() => Signal.set(isOpen, false)} />
        </div>
      },
      code: `let isOpen = Signal.make(false)

let items: array<Spotlight.spotlightItem> = [
  {
    id: "home",
    label: "Home",
    description: ?Some("Go to the homepage"),
    group: ?Some("Pages"),
    onSelect: () => (),
  },
  {
    id: "toggle-theme",
    label: "Toggle Theme",
    description: ?Some("Switch light/dark mode"),
    group: ?Some("Actions"),
    onSelect: () => Theme.toggle(),
  },
]

<Button onClick={_ => Signal.set(isOpen, true)}>
  {Component.text("Open Spotlight")}
</Button>
<Spotlight
  isOpen
  items
  onClose={() => Signal.set(isOpen, false)}
/>`,
    },
    {
      title: "Custom Placeholder & Empty State",
      description: "Customize the placeholder text and empty results message.",
      demo: {
        let isOpen = Signal.make(false)
        let items: array<Spotlight.spotlightItem> = [
          {
            id: "button",
            label: "Button",
            description: ?Some("Interactive button component"),
            onSelect: () => (),
          },
          {
            id: "input",
            label: "Input",
            description: ?Some("Text input field"),
            onSelect: () => (),
          },
          {
            id: "modal",
            label: "Modal",
            description: ?Some("Overlay dialog component"),
            onSelect: () => (),
          },
        ]
        <div>
          <Button variant={Button.Ghost} onClick={_ => Signal.set(isOpen, true)}>
            {text("Search Components")}
          </Button>
          <Spotlight
            isOpen
            items
            onClose={() => Signal.set(isOpen, false)}
            placeholder="Search components..."
            emptyMessage="No components match your search."
          />
        </div>
      },
      code: `<Spotlight
  isOpen
  items
  onClose={() => Signal.set(isOpen, false)}
  placeholder="Search components..."
  emptyMessage="No components match your search."
/>`,
    },
  ]
}
