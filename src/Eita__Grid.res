%%raw(`import "./Eita__Grid.css"`)

@jsx.component
let make = (~rows=2, ~cols=2, ~gap="0.5rem", ~children) => {
  let class = {
    "eita-grid"
  }

  let style = {
    "gap: " ++ gap ++ ";"
  }

  <div class style> {children} </div>
}
