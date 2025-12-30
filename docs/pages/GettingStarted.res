module Component = Xote.Component

@jsx.component
let make = () => {
  <div> {Component.text("Hello world")} </div>
}
