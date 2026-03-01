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
]
