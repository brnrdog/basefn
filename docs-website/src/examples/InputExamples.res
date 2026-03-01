open Xote
open Basefn

let examples: array<DocsExample.t> = {
  open Component
  [
    {
      title: "Input Types",
      description: "Different input types for various use cases.",
      demo: {
        let textValue = Signal.make("")
        let emailValue = Signal.make("")

        <div style="display: flex; flex-direction: column; gap:1rem;">
          <Input value={Reactive(textValue)} placeholder="Enter username" name="username" />
          <Input
            value={Reactive(emailValue)} placeholder="Enter email" type_=Input.Email name="email"
          />
        </div>
      },
      code: `let username = Signal.make("")
let email = Signal.make("")

<Input
  name="username"
  placeholder="Enter username"
  value={username}
/>
<Input
  value={email}
  placeholder="Enter email"
  type_=Input.Email
  name="email"
/>
        `,
    },
    {
      title: "Disabled state",
      description: "Disabled and other properties can be either static or reactive (signal).",
      demo: {
        let checked = Signal.make(false)
        let disabled = Computed.make(() => !Signal.get(checked))
        let onChange = e => {
          let v = Basefn__Dom.target(e)["checked"]
          Signal.set(checked, v)
        }

        <div style="display: flex; flex-direction: column; gap:2rem;">
          <Checkbox label="The button will only be enabled when checked" checked onChange />
          <div>
            <Button disabled={Reactive(disabled)}> {Component.text("Submit")} </Button>
          </div>
        </div>
      },
      code: `let checked = Signal.make(false)
let disabled = Computed.make(() => !Signal.get(checked))
let onChange = e => {
  let v = Basefn__Dom.target(e)["checked"]
  Signal.set(checked, v)
}

<div style="display: flex; flex-direction: column; gap:2rem;">
  <Checkbox label="The button will only be enabled when checked" checked onChange />
  <div>
    <Button disabled={Reactive(disabled)}> {Component.text("Submit")} </Button>
  </div>
</div>
        `,
    },
  ]
}
