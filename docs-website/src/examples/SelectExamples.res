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
    {
      title: "Placeholder and Sizes",
      description: "Select with a placeholder option and different sizes.",
      demo: {
        let value = Signal.make("")
        let options = Signal.make([
          {Select.value: "red", label: "Red"},
          {value: "green", label: "Green"},
          {value: "blue", label: "Blue"},
        ])
        <div style="display: flex; flex-direction: column; gap: 1rem; max-width: 300px;">
          <Select value options placeholder="Choose a color..." size={Select.Sm} name="color-sm" />
          <Select value options placeholder="Choose a color..." size={Select.Md} name="color-md" />
          <Select value options placeholder="Choose a color..." size={Select.Lg} name="color-lg" />
        </div>
      },
      code: `<Select
  value options
  placeholder="Choose a color..."
  size={Select.Md}
  name="color"
/>`,
    },
  ]
}
