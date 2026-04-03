%%raw(`import './Basefn__Table.css'`)

open Xote

type variant = Default | Striped

let variantToString = (v: variant) =>
  switch v {
  | Default => "default"
  | Striped => "striped"
  }

@jsx.component
let make = (
  ~children: Component.node,
  ~variant: variant=Default,
  ~className: string="",
) => {
  let class = {
    let base = "basefn-table-wrapper"
    let variantClass = " basefn-table--" ++ variantToString(variant)
    let custom = className !== "" ? " " ++ className : ""
    base ++ variantClass ++ custom
  }

  <div class>
    <table class="basefn-table"> {children} </table>
  </div>
}

module Header = {
  @jsx.component
  let make = (~children: Component.node) => {
    <thead class="basefn-table__head"> {children} </thead>
  }
}

module Body = {
  @jsx.component
  let make = (~children: Component.node) => {
    <tbody class="basefn-table__body"> {children} </tbody>
  }
}

module Row = {
  @jsx.component
  let make = (~children: Component.node, ~className: string="") => {
    let class = "basefn-table__row" ++ (className !== "" ? " " ++ className : "")
    <tr class> {children} </tr>
  }
}

module Head = {
  @jsx.component
  let make = (~children: Component.node, ~className: string="") => {
    let class = "basefn-table__th" ++ (className !== "" ? " " ++ className : "")
    <th class> {children} </th>
  }
}

module Cell = {
  @jsx.component
  let make = (~children: Component.node, ~className: string="") => {
    let class = "basefn-table__td" ++ (className !== "" ? " " ++ className : "")
    <td class> {children} </td>
  }
}

module Footer = {
  @jsx.component
  let make = (~children: Component.node) => {
    <tfoot class="basefn-table__foot"> {children} </tfoot>
  }
}

module Caption = {
  @jsx.component
  let make = (~children: Component.node) => {
    <caption class="basefn-table__caption"> {children} </caption>
  }
}
