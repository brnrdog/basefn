open Xote
open Basefn

let examples: array<DocsExample.t> = {
  open Component
  [
    {
      title: "Basic Select",
      description: "Dropdown selection from a list of options.",
      demo: {
        let value = Signal.make("option1")
        let options = Signal.make([
          {Select.value: "option1", label: "Option 1"},
          {value: "option2", label: "Option 2"},
          {value: "option3", label: "Option 3"},
        ])
        <div style="max-width: 300px;">
          <Label text="Choose an option" />
          <Select value options />
        </div>
      },
      code: `let value = Signal.make("option1")
let options = Signal.make([
  {value: "option1", label: "Option 1"},
  {value: "option2", label: "Option 2"},
  {value: "option3", label: "Option 3"},
])

<Select value options />`,
    },
    {
      title: "Select with Dynamic Options",
      description: "Dropdown with categories.",
      demo: {
        let value = Signal.make("apple")
        let options = Signal.make([
          {Select.value: "apple", label: "Apple"},
          {value: "banana", label: "Banana"},
          {value: "orange", label: "Orange"},
          {value: "grape", label: "Grape"},
        ])
        let selectedValue = Computed.make(() => Signal.get(value))

        let onClickOption = optionValue =>
          _evt => {
            Signal.set(value, optionValue)
          }

        <div style="max-width: 300px; display: flex; flex-direction: column; gap: 1rem;">
          <Select value options />
          <Typography
            text={ReactiveProp.Reactive(
              Computed.make(() => "Selected: " ++ Signal.get(selectedValue)),
            )}
            variant={Typography.Small}
          />
          <div style="display: flex; gap: 4rem;">
            <Button variant={Ghost} onClick={onClickOption("apple")}>
              {Component.text("🍎")}
            </Button>
            <Button variant={Ghost} onClick={onClickOption("banana")}>
              {Component.text("🍌")}
            </Button>
            <Button variant={Ghost} onClick={onClickOption("orange")}>
              {Component.text("🍊")}
            </Button>
            <Button variant={Ghost} onClick={onClickOption("grape")}>
              {Component.text("🍇")}
            </Button>
          </div>
        </div>
      },
      code: `let value = Signal.make("apple")
let options = Signal.make([
  {value: "apple", label: "Apple"},
  {value: "banana", label: "Banana"},
])

<Select value options />`,
    },
  ]
}
