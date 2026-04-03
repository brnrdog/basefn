open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Basic Dropdown",
    description: "Menu with multiple actions.",
    demo: <Dropdown
      trigger={<Button variant={Button.Secondary}> {Component.text("Actions")} </Button>}
      items={[
        Item({label: "Edit", onClick: () => ()}),
        Item({label: "Duplicate", onClick: () => ()}),
        Separator,
        Item({label: "Delete", onClick: () => (), danger: true}),
      ]}
    />,
    code: `<Dropdown
  trigger={<Button label={("Actions")} />}
  items={[
    Item({label: "Edit", onClick: () => ()}),
    Item({label: "Delete", onClick: () => (), danger: true}),
  ]}
/>`,
  },
  {
    title: "Keyboard Navigation",
    description: "Use Arrow Up/Down to navigate items and Escape to close. The first item is auto-focused when the menu opens.",
    demo: <Dropdown
      trigger={<Button variant={Button.Ghost}> {Component.text("Try keyboard nav")} </Button>}
      items={[
        Item({label: "Copy", onClick: () => ()}),
        Item({label: "Paste", onClick: () => ()}),
        Item({label: "Cut", onClick: () => ()}),
        Separator,
        Item({label: "Select All", onClick: () => ()}),
      ]}
    />,
    code: `// Arrow Up/Down navigates, Enter selects, Escape closes
<Dropdown
  trigger={<Button> {text("Menu")} </Button>}
  items={[
    Item({label: "Copy", onClick: () => ()}),
    Item({label: "Paste", onClick: () => ()}),
  ]}
/>`,
  },
]
