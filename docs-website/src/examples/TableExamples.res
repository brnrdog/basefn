open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Basic Table",
    description: "A simple table with header, body, and rows.",
    demo: <Table>
      <Table.Header>
        <Table.Row>
          <Table.Head> {Component.text("Name")} </Table.Head>
          <Table.Head> {Component.text("Email")} </Table.Head>
          <Table.Head> {Component.text("Role")} </Table.Head>
        </Table.Row>
      </Table.Header>
      <Table.Body>
        <Table.Row>
          <Table.Cell> {Component.text("Alice")} </Table.Cell>
          <Table.Cell> {Component.text("alice@example.com")} </Table.Cell>
          <Table.Cell> {Component.text("Admin")} </Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell> {Component.text("Bob")} </Table.Cell>
          <Table.Cell> {Component.text("bob@example.com")} </Table.Cell>
          <Table.Cell> {Component.text("Editor")} </Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell> {Component.text("Charlie")} </Table.Cell>
          <Table.Cell> {Component.text("charlie@example.com")} </Table.Cell>
          <Table.Cell> {Component.text("Viewer")} </Table.Cell>
        </Table.Row>
      </Table.Body>
    </Table>,
    code: `<Table>
  <Table.Header>
    <Table.Row>
      <Table.Head> {text("Name")} </Table.Head>
      <Table.Head> {text("Email")} </Table.Head>
      <Table.Head> {text("Role")} </Table.Head>
    </Table.Row>
  </Table.Header>
  <Table.Body>
    <Table.Row>
      <Table.Cell> {text("Alice")} </Table.Cell>
      <Table.Cell> {text("alice@example.com")} </Table.Cell>
      <Table.Cell> {text("Admin")} </Table.Cell>
    </Table.Row>
  </Table.Body>
</Table>`,
  },
  {
    title: "Striped Table",
    description: "Alternating row colors for better readability.",
    demo: <Table variant={Table.Striped}>
      <Table.Header>
        <Table.Row>
          <Table.Head> {Component.text("Item")} </Table.Head>
          <Table.Head> {Component.text("Qty")} </Table.Head>
          <Table.Head> {Component.text("Price")} </Table.Head>
        </Table.Row>
      </Table.Header>
      <Table.Body>
        <Table.Row>
          <Table.Cell> {Component.text("Widget")} </Table.Cell>
          <Table.Cell> {Component.text("10")} </Table.Cell>
          <Table.Cell> {Component.text("$5.00")} </Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell> {Component.text("Gadget")} </Table.Cell>
          <Table.Cell> {Component.text("3")} </Table.Cell>
          <Table.Cell> {Component.text("$12.00")} </Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell> {Component.text("Doohickey")} </Table.Cell>
          <Table.Cell> {Component.text("7")} </Table.Cell>
          <Table.Cell> {Component.text("$8.50")} </Table.Cell>
        </Table.Row>
      </Table.Body>
    </Table>,
    code: `<Table variant={Table.Striped}>
  <Table.Header>
    <Table.Row>
      <Table.Head> {text("Item")} </Table.Head>
      <Table.Head> {text("Qty")} </Table.Head>
      <Table.Head> {text("Price")} </Table.Head>
    </Table.Row>
  </Table.Header>
  <Table.Body>
    ...
  </Table.Body>
</Table>`,
  },
]
