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
    {
      title: "Sizes",
      description: "Inputs in small, medium, and large sizes.",
      demo: <div style="display: flex; flex-direction: column; gap: 1rem; max-width: 300px;">
        <Input value={Static("")} placeholder="Small" size={Input.Sm} />
        <Input value={Static("")} placeholder="Medium (default)" size={Input.Md} />
        <Input value={Static("")} placeholder="Large" size={Input.Lg} />
      </div>,
      code: `<Input value={Static("")} placeholder="Small" size={Input.Sm} />
<Input value={Static("")} placeholder="Medium" size={Input.Md} />
<Input value={Static("")} placeholder="Large" size={Input.Lg} />`,
    },
    {
      title: "Error and ReadOnly",
      description: "Inputs with error styling and read-only state.",
      demo: <div style="display: flex; flex-direction: column; gap: 1rem; max-width: 300px;">
        <Input value={Static("invalid@")} error={true} placeholder="Email" type_=Input.Email />
        <Input value={Static("Read-only value")} readOnly={true} />
      </div>,
      code: `<Input value={Static("invalid@")} error={true} />
<Input value={Static("Read-only value")} readOnly={true} />`,
    },
  ]
}
