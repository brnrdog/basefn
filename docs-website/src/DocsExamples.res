open Xote
open Basefn

type example = {
  title: string,
  description: string,
  demo: Component.node,
  code: string,
}

// Demo components - these create signals internally so they persist across re-renders
module ButtonClickHandlerDemo = {
  @jsx.component
  let make = () => {
    open Component
    let count = Signal.make(0)
    let counterText = Computed.make(() => "Count: " ++ Int.toString(Signal.get(count)))
    <div style="display: flex; align-items: center; gap: 1rem;">
      <Button variant={Button.Primary} onClick={_ => Signal.update(count, c => c + 1)}>
        {text("Increment")}
      </Button>
      <Typography text={Reactive(counterText)} variant={Typography.H4} />
    </div>
  }
}

module ButtonReactiveDemo = {
  @jsx.component
  let make = () => {
    open Component
    let fetching = Signal.make(false)
    let onClick = event => {
      let _ = Basefn__Dom.preventDefault(event)
      Signal.set(fetching, true)
      let _ = setTimeout(() => {
        Signal.set(fetching, false)
      }, 1500)
    }

    <div style="display: flex; align-items: center; gap: 1rem;">
      <Button variant={Button.Primary} disabled={ReactiveProp.Reactive(fetching)} onClick>
        {textSignal(() => Signal.get(fetching) ? "Data fetching..." : "Simulate data fetching")}
      </Button>
    </div>
  }
}

// Helper to get examples for a component
let getExamples = (componentName: string): array<example> => {
  open Component

  switch componentName {
  | "button" => [
      {
        title: "Variants",
        description: "Different button styles for various use cases.",
        demo: <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
          <Button variant={Button.Primary}> {text("Primary")} </Button>
          <Button variant={Button.Secondary}> {text("Secondary")} </Button>
          <Button variant={Button.Ghost}> {text("Ghost")} </Button>
        </div>,
        code: `<Button variant={Button.Primary}> {text("Primary")} </Button>
<Button variant={Button.Secondary}> {text("Secondary")} </Button>
<Button variant={Button.Ghost}> {text("Ghost")} </Button>`,
      },
      {
        title: "Button with Click Handler",
        description: "Buttons can handle click events.",
        demo: <ButtonClickHandlerDemo />,
        code: `let count = Signal.make(0)
let counterText = Computed.make(() => "Count: " ++ Int.toString(Signal.get(count)))

<Typography text={counterText} variant={Typography.H4} />
<Button
  variant={Button.Primary}
  onClick={_ => Signal.update(count, c => c + 1)}
>
  {text("Increment")}
</Button>
`,
      },
      {
        title: "Reactive button attributes",
        description: "Button attributes can be static or it can react to signals.",
        demo: <ButtonReactiveDemo />,
        code: `let fetching = Signal.make(false)
let disabled = fetching

/* Simulate waiting for data fetching */
let onClick = event => {
  Basefn__Dom.preventDefault(event)
  Signal.set(fetching, true)
  let _ = setTimeout(() => {
    Signal.set(fetching, false)
  }, 1500)
}

<div style="display: flex; align-items: center; gap: 1rem;">
  <Button variant={Button.Primary} disabled onClick>
    {textSignal(() => Signal.get(fetching) ? "Loading data..." : "Load data")}
  </Button>
</div>
`,
      },
    ]

  | "badge" => [
      {
        title: "Badge Variants",
        description: "Different badge styles for status indicators.",
        demo: <div style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: center;">
          <Badge label={Signal.make("Default")} variant={Badge.Default} />
          <Badge label={Signal.make("Primary")} variant={Badge.Primary} />
          <Badge label={Signal.make("Success")} variant={Badge.Success} />
          <Badge label={Signal.make("Warning")} variant={Badge.Warning} />
        </div>,
        code: `<Badge label={Signal.make("Default")} variant={Badge.Default} />
<Badge label={Signal.make("Primary")} variant={Badge.Primary} />
<Badge label={Signal.make("Success")} variant={Badge.Success} />
<Badge label={Signal.make("Warning")} variant={Badge.Warning} />`,
      },
      {
        title: "Badge Sizes",
        description: "Badges come in small, medium, and large sizes.",
        demo: <div style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: center;">
          <Badge label={Signal.make("Small")} size={Badge.Sm} variant={Badge.Primary} />
          <Badge label={Signal.make("Medium")} size={Badge.Md} variant={Badge.Primary} />
          <Badge label={Signal.make("Large")} size={Badge.Lg} variant={Badge.Primary} />
        </div>,
        code: `<Badge label={Signal.make("Small")} size={Badge.Sm} variant={Badge.Primary} />
<Badge label={Signal.make("Medium")} size={Badge.Md} variant={Badge.Primary} />
<Badge label={Signal.make("Large")} size={Badge.Lg} variant={Badge.Primary} />`,
      },
    ]

  | "card" => [
      {
        title: "Basic Card",
        description: "A simple card container for grouping content.",
        demo: <Card>
          <Typography
            text={ReactiveProp.Static("Card Title")}
            variant={Typography.H5}
            style="margin-bottom: 1rem;"
          />
          <Typography
            text={ReactiveProp.static(
              "This is a basic card component. It can contain any content.",
            )}
            style="margin-bottom: 2rem;"
            variant={P}
          />
          <Button> {Component.text("Call to Action")} </Button>
        </Card>,
        code: `<Card>
  <Typography text={ReactiveProp.Static("Card Title")} variant={Typography.H4} />
  <p>{Component.text("This is a basic card component.")}</p>
</Card>`,
      },
    ]

  | "input" => [
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

  | "alert" => [
      {
        title: "Alert Variants",
        description: "Different alert styles for various message types.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Alert
            title={"Info"}
            message={Signal.make("This is an informational message.")}
            variant={Alert.Info}
          />
          <Alert
            title={"Success"}
            message={Signal.make("Operation completed successfully!")}
            variant={Alert.Success}
          />
          <Alert
            title={"Warning"}
            message={Signal.make("Please review your settings.")}
            variant={Alert.Warning}
          />
          <Alert
            title={"Error"}
            message={Signal.make("An error occurred during the operation.")}
            variant={Alert.Error}
          />
        </div>,
        code: `<Alert
  title={Signal.make("Info")}
  message={Signal.make("This is an informational message.")}
  variant={Alert.Info}
/>
<Alert
  title={Signal.make("Success")}
  message={Signal.make("Operation completed successfully!")}
  variant={Alert.Success}
/>`,
      },
    ]

  | "tabs" => [
      {
        title: "Basic Tabs",
        description: "Organize content in tabbed sections.",
        demo: {
          <Tabs
            tabs={[
              {
                label: "Profile",
                value: "tab1",
                content: <div style="padding: 1rem;">
                  <Typography
                    text={ReactiveProp.Static("Profile Settings")} variant={Typography.H5}
                  />
                  <p> {Component.text("Manage your profile information here.")} </p>
                </div>,
              },
              {
                label: "Account",
                value: "tab2",
                content: <div style="padding: 1rem;">
                  <Typography
                    text={ReactiveProp.Static("Account Settings")} variant={Typography.H5}
                  />
                  <p> {Component.text("Manage your account settings here.")} </p>
                </div>,
              },
              {
                label: "Notifications",
                value: "tab3",
                content: <div style="padding: 1rem;">
                  <Typography
                    text={ReactiveProp.Static("Notification Preferences")} variant={Typography.H5}
                  />
                  <p> {Component.text("Configure your notification preferences.")} </p>
                </div>,
              },
            ]}
          />
        },
        code: `let activeTab = Signal.make("tab1")

<Tabs
  tabs={[
    {
      label: "Profile",
      value: "tab1",
      content: <div>Profile content</div>,
    },
    {
      label: "Account",
      value: "tab2",
      content: <div>Account content</div>,
    },
  ]}
/>`,
      },
    ]

  | "textarea" => [
      {
        title: "Basic Textarea",
        description: "Multi-line text input for longer content.",
        demo: {
          let value = Signal.make("")
          <div style="max-width: 400px;">
            <Label text="Message" required={true} />
            <Textarea value={Reactive(value)} placeholder="Enter your message..." />
          </div>
        },
        code: `let value = Signal.make("")

<Textarea
  value
  placeholder="Enter your message..."
/>`,
      },
      {
        title: "Controlled Textarea",
        description: "Textarea with character count.",
        demo: {
          let value = Signal.make("")
          let charCount = Computed.make(() => String.length(Signal.get(value)))
          let message = Computed.make(() => Signal.get(charCount)->Int.toString ++ " characters")
          <div style="max-width: 400px; display: flex; flex-direction: column; gap: 0.5rem;">
            <Textarea value={Reactive(value)} placeholder="Write something..." />
            <Typography text={Reactive(message)} variant={Typography.Small} />
          </div>
        },
        code: `let value = Signal.make("")
let charCount = Computed.make(() => String.length(Signal.get(value)))

<div>
  <Textarea value placeholder="Write something..." />
  <Typography text={charCount} variant={Typography.Small} />
</div>`,
      },
    ]

  | "select" => [
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

  | "checkbox" => [
      {
        title: "Basic Checkbox",
        description: "Toggle options on and off.",
        demo: {
          let checked = Signal.make(false)
          <div style="display: flex; flex-direction: column; gap: 1rem;">
            <Checkbox checked label="Accept terms and conditions" />
            <Checkbox checked={Signal.make(true)} label="Subscribe to newsletter" />
            <Checkbox checked={Signal.make(false)} label="Enable notifications" disabled={true} />
          </div>
        },
        code: `let checked = Signal.make(false)

<Checkbox checked label="Accept terms and conditions" />`,
      },
      {
        title: "Checkbox Group",
        description: "Multiple checkboxes for selecting options.",
        demo: {
          let option1 = Signal.make(true)
          let option2 = Signal.make(false)
          let option3 = Signal.make(true)
          <div style="display: flex; flex-direction: column; gap: 0.75rem;">
            <Typography text={ReactiveProp.Static("Select features:")} variant={Typography.H6} />
            <Checkbox checked={option1} label="Dark mode" />
            <Checkbox checked={option2} label="Email notifications" />
            <Checkbox checked={option3} label="Auto-save" />
          </div>
        },
        code: `let option1 = Signal.make(true)
let option2 = Signal.make(false)

<div>
  <Checkbox checked={option1} label="Dark mode" />
  <Checkbox checked={option2} label="Email notifications" />
</div>`,
      },
    ]

  | "radio" => [
      {
        title: "Radio Group",
        description: "Select a single option from multiple choices.",
        demo: {
          let selected = Signal.make("option1")
          <div style="display: flex; flex-direction: column; gap: 0.75rem;">
            <Typography text={ReactiveProp.Static("Choose a plan:")} variant={Typography.H6} />
            <Radio
              checked={Computed.make(() => Signal.get(selected) == "option1")}
              value="option1"
              label="Free"
              name="plan"
              onChange={_ => Signal.set(selected, "option1")}
            />
            <Radio
              checked={Computed.make(() => Signal.get(selected) == "option2")}
              value="option2"
              label="Pro"
              name="plan"
              onChange={_ => Signal.set(selected, "option2")}
            />
            <Radio
              checked={Computed.make(() => Signal.get(selected) == "option3")}
              value="option3"
              label="Enterprise"
              name="plan"
              onChange={_ => Signal.set(selected, "option3")}
            />
          </div>
        },
        code: `let selected = Signal.make("option1")

<Radio
  checked={Computed.make(() => Signal.get(selected) == "option1")}
  value="option1"
  label="Free"
  name="plan"
  onChange={_ => Signal.set(selected, "option1")}
/>`,
      },
    ]

  | "label" => [
      {
        title: "Basic Label",
        description: "Label for form inputs.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <div>
            <Label text="Email address" />
            <Input value={Static("")} placeholder="Enter email" type_=Input.Email />
          </div>
          <div>
            <Label text="Password" required={true} />
            <Input value={Static("")} placeholder="Enter password" type_=Input.Password />
          </div>
          <div>
            <Label text="Bio" required={true} />
            <Textarea value={Static("")} placeholder="Describe yourself in a few words..." />
          </div>
        </div>,
        code: `<Label text="Email address" />
<Input value={Signal.make("")} placeholder="Enter email" />

<Label text="Password" required={true} />
<Input value={Signal.make("")} placeholder="Enter password" />`,
      },
    ]

  | "typography" => [
      {
        title: "Typography Variants",
        description: "Different text styles for headings and content.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Typography text={ReactiveProp.Static("Heading 1")} variant={Typography.H1} />
          <Typography text={ReactiveProp.Static("Heading 2")} variant={Typography.H2} />
          <Typography text={ReactiveProp.Static("Heading 3")} variant={Typography.H3} />
          <Typography text={ReactiveProp.Static("Paragraph text")} variant={Typography.P} />
          <Typography
            text={ReactiveProp.Static("Lead text for introductions")} variant={Typography.Lead}
          />
          <Typography text={ReactiveProp.Static("Small text")} variant={Typography.Small} />
          <Typography text={ReactiveProp.Static("Muted text")} variant={Typography.Muted} />
          <Typography text={ReactiveProp.Static("inline code")} variant={Typography.Code} />
        </div>,
        code: `<Typography text={ReactiveProp.Static("Heading 1")} variant={Typography.H1} />
<Typography text={ReactiveProp.Static("Paragraph text")} variant={Typography.P} />
<Typography text={ReactiveProp.Static("Muted text")} variant={Typography.Muted} />`,
      },
      {
        title: "Text Alignment",
        description: "Control text alignment.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Typography text={ReactiveProp.Static("Left aligned")} align={Typography.Left} />
          <Typography text={ReactiveProp.Static("Center aligned")} align={Typography.Center} />
          <Typography text={ReactiveProp.Static("Right aligned")} align={Typography.Right} />
        </div>,
        code: `<Typography text={ReactiveProp.Static("Center aligned")} align={Typography.Center} />`,
      },
    ]

  | "spinner" => [
      {
        title: "Spinner Sizes",
        description: "Loading indicators in different sizes.",
        demo: <div style="display: flex; gap: 2rem; align-items: center;">
          <Spinner size={Spinner.Sm} />
          <Spinner size={Spinner.Md} />
          <Spinner size={Spinner.Lg} />
          <Spinner size={Spinner.Xl} />
        </div>,
        code: `<Spinner size={Spinner.Sm} />
<Spinner size={Spinner.Md} />
<Spinner size={Spinner.Lg} />`,
      },
      {
        title: "Spinner Variants with Labels",
        description: "Colored spinners with loading messages.",
        demo: <div style="display: flex; flex-direction: column; gap: 1.5rem;">
          <Spinner variant={Spinner.Default} label="Loading..." />
          <Spinner variant={Spinner.Primary} label="Processing..." />
          <Spinner variant={Spinner.Secondary} label="Please wait..." />
        </div>,
        code: `<Spinner variant={Spinner.Primary} label="Loading..." />`,
      },
    ]

  | "separator" => [
      {
        title: "Horizontal Separator",
        description: "Divide content sections horizontally.",
        demo: <div style="display: flex; flex-direction: column;">
          <Typography text={ReactiveProp.Static("Section 1")} variant={Typography.Unstyled} />
          <Separator orientation={Separator.Horizontal} />
          <Typography text={ReactiveProp.Static("Section 2")} variant={Typography.Unstyled} />
        </div>,
        code: `<Separator orientation={Separator.Horizontal} />`,
      },
      {
        title: "Vertical Separator",
        description: "Divide content sections vertically.",
        demo: <div
          style="display: flex; flex-direction: column; align-items: center; gap: 2rem; width: 100%;"
        >
          <div
            style="display: flex; width: 100%; flex-direction: row; height: 2.5rem; gap: 2rem; height: 2.5rem; gap: 2rem;"
          >
            <Typography
              text={ReactiveProp.Static("Solid Separators")}
              variant={Typography.Unstyled}
              style="width: 100px;"
            />
            <Separator orientation={Vertical} variant={Solid} />
            <Typography
              text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
            />
          </div>
          <div style="display: flex; width: 100%; flex-direction: row; height: 2.5rem; gap: 2rem;">
            <Typography
              text={ReactiveProp.Static("Dashed Separators")}
              variant={Typography.Unstyled}
              style="width: 100px;"
            />
            <Separator orientation={Vertical} variant={Dashed} />
            <Typography
              text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
            />
          </div>
          <div style="display: flex; width: 100%; flex-direction: row; height: 2.5rem; gap: 2rem;">
            <Typography
              text={ReactiveProp.Static("Dotted Separators")}
              variant={Typography.Unstyled}
              style="width: 100px;"
            />
            <Separator orientation={Vertical} variant={Dotted} />
            <Typography
              text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
            />
          </div>
        </div>,
        code: `<Separator orientation={Separator.Vertical} />`,
      },
      {
        title: "Horizontal Separators",
        description: "Divides content sections horizontally.",
        demo: <div style="display: flex; align-items: center; gap: 2rem; width: 100%;">
          <div style="display: flex; width: 100%; flex-direction: column;">
            <Typography
              text={ReactiveProp.Static("Solid Separators")} variant={Typography.Unstyled}
            />
            <Separator variant={Solid} />
            <Typography
              text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
            />
          </div>
          <div style="display: flex; width: 100%; flex-direction: column;">
            <Typography
              text={ReactiveProp.Static("Dashed Separators")} variant={Typography.Unstyled}
            />
            <Separator variant={Dashed} />
            <Typography
              text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
            />
          </div>
          <div style="display: flex; width: 100%; flex-direction: column;">
            <Typography
              text={ReactiveProp.Static("Dotted Separators")} variant={Typography.Unstyled}
            />
            <Separator variant={Dotted} />
            <Typography
              text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
            />
          </div>
          <div style="display: flex; width: 100%; flex-direction: column; width: 100%;">
            <Typography
              text={ReactiveProp.Static("Separator with a label")} variant={Typography.Unstyled}
            />
            <Separator variant={Solid} label="With a label" />
            <Typography
              text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
            />
          </div>
        </div>,
        code: `<Separator variant={Solid} />
<Separator variant={Dashed} />
<Separator variant={Dotted} />
<Separator variant={Dotted} label="Section name"/>`,
      },
    ]

  | "kbd" => [
      {
        title: "Keyboard Shortcuts",
        description: "Display keyboard keys and shortcuts.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <div style="display: flex; gap: 0.5rem; align-items: center;">
            <Typography text={ReactiveProp.Static("Save:")} variant={Typography.P} />
            <Kbd keys={["Ctrl", "S"]->Signal.make} />
          </div>
          <div style="display: flex; gap: 0.5rem; align-items: center;">
            <Typography text={ReactiveProp.Static("Copy:")} variant={Typography.P} />
            <Kbd keys={["Ctrl", "C"]->Signal.make} />
          </div>
          <div style="display: flex; gap: 0.5rem; align-items: center;">
            <Typography text={ReactiveProp.Static("Undo:")} variant={Typography.P} />
            <Kbd keys={["Ctrl", "Z"]->Signal.make} />
          </div>
        </div>,
        code: `<Kbd keys={["Ctrl", "S"]->Signal.make} />
<Kbd keys={["Cmd", "Shift", "P"]->Signal.make} />`,
      },
      {
        title: "Kbd Sizes",
        description: "Different sizes for keyboard shortcuts.",
        demo: <div style="display: flex; gap: 1rem; align-items: center;">
          <Kbd keys={["Esc"]->Signal.make} size={Kbd.Sm} />
          <Kbd keys={["Enter"]->Signal.make} size={Kbd.Md} />
          <Kbd keys={["Tab"]->Signal.make} size={Kbd.Lg} />
        </div>,
        code: `<Kbd keys={["Esc"]->Signal.make} size={Kbd.Sm} />`,
      },
    ]

  | "avatar" => [
      {
        title: "Avatar Sizes",
        description: "User avatars in different sizes.",
        demo: <div style="display: flex; gap: 1rem; align-items: center;">
          <Avatar name="John Doe" size={Avatar.Sm} src="https://i.pravatar.cc" />
          <Avatar name="Jane Smith" size={Avatar.Md} src="https://i.pravatar.cc" />
          <Avatar name="Bob Johnson" size={Avatar.Lg} src="https://i.pravatar.cc" />
        </div>,
        code: `<Avatar name="John Doe" size={Avatar.Sm} />
<Avatar name="Jane Smith" size={Avatar.Md} />`,
      },
      {
        title: "Avatar with Image",
        description: "Avatar displaying profile images.",
        demo: <div style="display: flex; gap: 1rem;">
          <Avatar src="https://i.pravatar.cc" name="User 1" />
          <Avatar src="https://i.pravatar.cc" name="User 2" />
          <Avatar src="https://i.pravatar.cc" name="User 3" />
        </div>,
        code: `<Avatar src="https://i.pravatar.cc" name="User 1" />`,
      },
    ]

  | "grid" => [
      {
        title: "Simple Column Count",
        description: "Create an equal-width grid with a simple column count.",
        demo: <Grid columns={Count(3)} gap="1rem">
          <Card>
            <Typography text={ReactiveProp.Static("Item 1")} variant={Typography.H5} />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Item 2")} variant={Typography.H5} />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Item 3")} variant={Typography.H5} />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Item 4")} variant={Typography.H5} />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Item 5")} variant={Typography.H5} />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Item 6")} variant={Typography.H5} />
          </Card>
        </Grid>,
        code: `<Grid columns={Count(3)} gap="1rem">
  <Card><Typography text={ReactiveProp.Static("Item 1")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Item 2")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Item 3")} /></Card>
</Grid>`,
      },
      {
        title: "Responsive Auto-Fit",
        description: "Grid that automatically fits items based on available space.",
        demo: <Grid columns={AutoFit("minmax(200px, 1fr)")} gap="1rem">
          <Card>
            <Typography text={ReactiveProp.Static("Card 1")} variant={Typography.H5} />
            <Typography
              text={ReactiveProp.Static("Resizes automatically")} variant={Typography.Small}
            />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Card 2")} variant={Typography.H5} />
            <Typography
              text={ReactiveProp.Static("Try resizing window")} variant={Typography.Small}
            />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Card 3")} variant={Typography.H5} />
            <Typography text={ReactiveProp.Static("Flexible layout")} variant={Typography.Small} />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Card 4")} variant={Typography.H5} />
            <Typography text={ReactiveProp.Static("No media queries")} variant={Typography.Small} />
          </Card>
        </Grid>,
        code: `<Grid columns={AutoFit("minmax(200px, 1fr)")} gap="1rem">
  <Card><Typography text={ReactiveProp.Static("Card 1")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Card 2")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Card 3")} /></Card>
</Grid>`,
      },
      {
        title: "Custom Template",
        description: "Define exact column sizes with custom templates.",
        demo: <Grid columns={Template("2fr 1fr 1fr")} gap="1rem">
          <Card>
            <Typography
              text={ReactiveProp.Static("2fr - Twice as wide")} variant={Typography.Small}
            />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("1fr")} variant={Typography.Small} />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("1fr")} variant={Typography.Small} />
          </Card>
        </Grid>,
        code: `<Grid columns={Template("2fr 1fr 1fr")} gap="1rem">
  <Card><Typography text={ReactiveProp.Static("2fr - Twice as wide")} /></Card>
  <Card><Typography text={ReactiveProp.Static("1fr")} /></Card>
  <Card><Typography text={ReactiveProp.Static("1fr")} /></Card>
</Grid>`,
      },
      {
        title: "Grid with Spanning Items",
        description: "Items can span multiple columns or rows.",
        demo: <Grid columns={Count(4)} gap="1rem">
          <Grid.Item column={Span(2)}>
            <Card>
              <Typography text={ReactiveProp.Static("Spans 2 columns")} variant={Typography.H5} />
            </Card>
          </Grid.Item>
          <Card>
            <Typography text={ReactiveProp.Static("Normal")} variant={Typography.Small} />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Normal")} variant={Typography.Small} />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Normal")} variant={Typography.Small} />
          </Card>
          <Grid.Item column={Span(3)}>
            <Card>
              <Typography text={ReactiveProp.Static("Spans 3 columns")} variant={Typography.H5} />
            </Card>
          </Grid.Item>
        </Grid>,
        code: `<Grid columns={Count(4)} gap="1rem">
  <Grid.Item column={Span(2)}>
    <Card><Typography text={ReactiveProp.Static("Spans 2 columns")} /></Card>
  </Grid.Item>
  <Card><Typography text={ReactiveProp.Static("Normal")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Normal")} /></Card>
</Grid>`,
      },
      {
        title: "Alignment Options",
        description: "Control item alignment with justifyItems and alignItems.",
        demo: <Grid
          columns={Count(3)}
          gap="1rem"
          justifyItems={Center}
          alignItems={Center}
          style={ReactiveProp.static("min-height: 200px;")}
        >
          <Badge variant={Badge.Default} label={Signal.make("Centered")} />
          <Badge variant={Badge.Primary} label={Signal.make("Centered")} />
          <Badge variant={Badge.Success} label={Signal.make("Centered")} />
        </Grid>,
        code: `<Grid
  columns={Count(3)}
  gap="1rem"
  justifyItems={Center}
  alignItems={Center}
>
  <Badge variant={Badge.Default} label={Signal.make("Centered")} />
  <Badge variant={Badge.Primary} label={Signal.make("Centered")} />
</Grid>`,
      },
      {
        title: "Separate Row and Column Gaps",
        description: "Control row and column gaps independently.",
        demo: <Grid columns={Count(2)} rowGap="2rem" columnGap="0.5rem">
          <Card>
            <Typography text={ReactiveProp.Static("Large row gap")} variant={Typography.Small} />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Small column gap")} variant={Typography.Small} />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Item 3")} variant={Typography.Small} />
          </Card>
          <Card>
            <Typography text={ReactiveProp.Static("Item 4")} variant={Typography.Small} />
          </Card>
        </Grid>,
        code: `<Grid columns={Count(2)} rowGap="2rem" columnGap="0.5rem">
  <Card><Typography text={ReactiveProp.Static("Large row gap")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Small column gap")} /></Card>
</Grid>`,
      },
      {
        title: "Dashboard Layout",
        description: "Classic dashboard with header, sidebar, and content area.",
        demo: <Grid
          columns={Template("250px 1fr")}
          rows={Template("60px 1fr")}
          gap="1rem"
          style={ReactiveProp.static("height: 400px;")}
        >
          <Grid.Item column={StartEnd(1, 3)}>
            <Card style="height: 100%; display: flex; align-items: center; padding: 0 1rem;">
              <Typography text={ReactiveProp.Static("Header")} variant={Typography.H5} />
            </Card>
          </Grid.Item>
          <Card style="height: 100%; display: flex; align-items: center; justify-content: center;">
            <Typography text={ReactiveProp.Static("Sidebar")} variant={Typography.Muted} />
          </Card>
          <Card style="height: 100%; display: flex; align-items: center; justify-content: center;">
            <Typography text={ReactiveProp.Static("Main Content")} variant={Typography.Muted} />
          </Card>
        </Grid>,
        code: `<Grid
  columns={Template("250px 1fr")}
  rows={Template("60px 1fr")}
  gap="1rem"
>
  <Grid.Item column={StartEnd(1, 3)}>
    <Card><Typography text={ReactiveProp.Static("Header")} /></Card>
  </Grid.Item>
  <Card><Typography text={ReactiveProp.Static("Sidebar")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Main Content")} /></Card>
</Grid>`,
      },
      {
        title: "Feature Grid",
        description: "Highlight a featured item alongside regular items.",
        demo: <Grid columns={Count(3)} rows={Repeat(2, "200px")} gap="1rem">
          <Grid.Item column={Span(2)} row={Span(2)}>
            <Card
              style="height: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center; background: var(--primary-500); color: white;"
            >
              <Typography text={ReactiveProp.Static("Featured")} variant={Typography.H3} />
              <Typography
                text={ReactiveProp.Static("Main highlight")}
                variant={Typography.Small}
                style="color: white; opacity: 0.9;"
              />
            </Card>
          </Grid.Item>
          <Card style="height: 100%; display: flex; align-items: center; justify-content: center;">
            <Typography text={ReactiveProp.Static("Item 1")} variant={Typography.Small} />
          </Card>
          <Card style="height: 100%; display: flex; align-items: center; justify-content: center;">
            <Typography text={ReactiveProp.Static("Item 2")} variant={Typography.Small} />
          </Card>
        </Grid>,
        code: `<Grid columns={Count(3)} rows={Repeat(2, "200px")} gap="1rem">
  <Grid.Item column={Span(2)} row={Span(2)}>
    <Card style="background: var(--primary-500); color: white;">
      <Typography text={ReactiveProp.Static("Featured")} />
    </Card>
  </Grid.Item>
  <Card><Typography text={ReactiveProp.Static("Item 1")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Item 2")} /></Card>
</Grid>`,
      },
      {
        title: "Product Grid",
        description: "Responsive product card layout with auto-fit.",
        demo: <Grid columns={AutoFit("minmax(150px, 1fr)")} gap="1.5rem">
          <Card>
            <div
              style="width: 100%; height: 100px; background: var(--gray-200); border-radius: 0.5rem; margin-bottom: 0.5rem;"
            />
            <Typography text={ReactiveProp.Static("Product 1")} variant={Typography.H6} />
            <Typography text={ReactiveProp.Static("$29.99")} variant={Typography.Muted} />
          </Card>
          <Card>
            <div
              style="width: 100%; height: 100px; background: var(--gray-200); border-radius: 0.5rem; margin-bottom: 0.5rem;"
            />
            <Typography text={ReactiveProp.Static("Product 2")} variant={Typography.H6} />
            <Typography text={ReactiveProp.Static("$39.99")} variant={Typography.Muted} />
          </Card>
          <Card>
            <div
              style="width: 100%; height: 100px; background: var(--gray-200); border-radius: 0.5rem; margin-bottom: 0.5rem;"
            />
            <Typography text={ReactiveProp.Static("Product 3")} variant={Typography.H6} />
            <Typography text={ReactiveProp.Static("$49.99")} variant={Typography.Muted} />
          </Card>
          <Card>
            <div
              style="width: 100%; height: 100px; background: var(--gray-200); border-radius: 0.5rem; margin-bottom: 0.5rem;"
            />
            <Typography text={ReactiveProp.Static("Product 4")} variant={Typography.H6} />
            <Typography text={ReactiveProp.Static("$59.99")} variant={Typography.Muted} />
          </Card>
        </Grid>,
        code: `<Grid columns={AutoFit("minmax(150px, 1fr)")} gap="1.5rem">
  <Card>
    <div style="width: 100%; height: 100px; background: var(--gray-200);" />
    <Typography text={ReactiveProp.Static("Product 1")} />
    <Typography text={ReactiveProp.Static("$29.99")} variant={Typography.Muted} />
  </Card>
  {/* More products... */}
</Grid>`,
      },
      {
        title: "Holy Grail Layout",
        description: "Classic holy grail layout with header, footer, sidebar, ads, and content.",
        demo: <Grid
          columns={Template("200px 1fr 150px")}
          rows={Template("auto 1fr auto")}
          gap="1rem"
          style={ReactiveProp.static("min-height: 400px;")}
        >
          <Grid.Item column={StartEnd(1, 4)}>
            <Card style="padding: 1rem;">
              <Typography text={ReactiveProp.Static("Header")} variant={Typography.H5} />
            </Card>
          </Grid.Item>
          <Card style="padding: 1rem;">
            <Typography text={ReactiveProp.Static("Sidebar")} variant={Typography.Small} />
          </Card>
          <Card style="padding: 1rem;">
            <Typography text={ReactiveProp.Static("Main Content")} variant={Typography.H6} />
            <Typography
              text={ReactiveProp.Static("This area expands to fill available space")}
              variant={Typography.Small}
            />
          </Card>
          <Card style="padding: 1rem;">
            <Typography text={ReactiveProp.Static("Ads")} variant={Typography.Small} />
          </Card>
          <Grid.Item column={StartEnd(1, 4)}>
            <Card style="padding: 1rem;">
              <Typography text={ReactiveProp.Static("Footer")} variant={Typography.Small} />
            </Card>
          </Grid.Item>
        </Grid>,
        code: `<Grid
  columns={Template("200px 1fr 150px")}
  rows={Template("auto 1fr auto")}
  gap="1rem"
>
  <Grid.Item column={StartEnd(1, 4)}>
    <Card><Typography text={ReactiveProp.Static("Header")} /></Card>
  </Grid.Item>
  <Card><Typography text={ReactiveProp.Static("Sidebar")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Main Content")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Ads")} /></Card>
  <Grid.Item column={StartEnd(1, 4)}>
    <Card><Typography text={ReactiveProp.Static("Footer")} /></Card>
  </Grid.Item>
</Grid>`,
      },
      {
        title: "Stats Grid",
        description: "Grid for displaying statistics or metrics.",
        demo: <Grid columns={AutoFit("minmax(180px, 1fr)")} gap="1rem">
          <Card style="text-align: center; padding: 1.5rem;">
            <Typography text={ReactiveProp.Static("1,234")} variant={Typography.H3} />
            <Typography text={ReactiveProp.Static("Total Users")} variant={Typography.Muted} />
          </Card>
          <Card style="text-align: center; padding: 1.5rem;">
            <Typography text={ReactiveProp.Static("567")} variant={Typography.H3} />
            <Typography text={ReactiveProp.Static("Active Today")} variant={Typography.Muted} />
          </Card>
          <Card style="text-align: center; padding: 1.5rem;">
            <Typography text={ReactiveProp.Static("89%")} variant={Typography.H3} />
            <Typography text={ReactiveProp.Static("Satisfaction")} variant={Typography.Muted} />
          </Card>
          <Card style="text-align: center; padding: 1.5rem;">
            <Typography text={ReactiveProp.Static("$12.5k")} variant={Typography.H3} />
            <Typography text={ReactiveProp.Static("Revenue")} variant={Typography.Muted} />
          </Card>
        </Grid>,
        code: `<Grid columns={AutoFit("minmax(180px, 1fr)")} gap="1rem">
  <Card style="text-align: center;">
    <Typography text={ReactiveProp.Static("1,234")} variant={Typography.H3} />
    <Typography text={ReactiveProp.Static("Total Users")} variant={Typography.Muted} />
  </Card>
  {/* More stats... */}
</Grid>`,
      },
      {
        title: "Masonry-Style Grid",
        description: "Auto-flow dense for a masonry-like effect.",
        demo: <Grid columns={Count(3)} autoFlow={RowDense} gap="1rem">
          <Card style="padding: 2rem;">
            <Typography text={ReactiveProp.Static("Tall Item")} variant={Typography.H6} />
          </Card>
          <Card style="padding: 1rem;">
            <Typography text={ReactiveProp.Static("Short")} variant={Typography.Small} />
          </Card>
          <Card style="padding: 3rem;">
            <Typography text={ReactiveProp.Static("Very Tall Item")} variant={Typography.H6} />
          </Card>
          <Card style="padding: 1rem;">
            <Typography text={ReactiveProp.Static("Short")} variant={Typography.Small} />
          </Card>
          <Grid.Item column={Span(2)}>
            <Card style="padding: 1.5rem;">
              <Typography text={ReactiveProp.Static("Wide Item")} variant={Typography.H6} />
            </Card>
          </Grid.Item>
          <Card style="padding: 1rem;">
            <Typography text={ReactiveProp.Static("Short")} variant={Typography.Small} />
          </Card>
        </Grid>,
        code: `<Grid columns={Count(3)} autoFlow={RowDense} gap="1rem">
  <Card style="padding: 2rem;">
    <Typography text={ReactiveProp.Static("Tall Item")} />
  </Card>
  <Card style="padding: 1rem;">
    <Typography text={ReactiveProp.Static("Short")} />
  </Card>
  <Grid.Item column={Span(2)}>
    <Card><Typography text={ReactiveProp.Static("Wide Item")} /></Card>
  </Grid.Item>
</Grid>`,
      },
      {
        title: "Form Layout",
        description: "Use grid for complex form layouts.",
        demo: <Grid columns={Count(2)} gap="1rem">
          <div>
            <Label text="First Name" />
            <Input type_={Text} value={Static("")} />
          </div>
          <div>
            <Label text="Last Name" />
            <Input type_={Text} value={Static("")} />
          </div>
          <Grid.Item column={Span(2)}>
            <Label text="Email" />
            <Input type_={Email} value={Static("")} />
          </Grid.Item>
          <Grid.Item column={Span(2)}>
            <Label text="Address" />
            <Textarea value={Static("")} />
          </Grid.Item>
          <div>
            <Label text="City" />
            <Input type_={Text} value={Static("")} />
          </div>
          <div>
            <Label text="Zip Code" />
            <Input type_={Text} value={Static("")} />
          </div>
        </Grid>,
        code: `<Grid columns={Count(2)} gap="1rem">
  <div>
    <Label text="First Name" />
    <Input type_={Text} value={Static("")} />
  </div>
  <div>
    <Label text="Last Name" />
    <Input type_={Text} value={Static("")} />
  </div>
  <Grid.Item column={Span(2)}>
    <Label text="Email" />
    <Input type_={Email} value={Static("")} />
  </Grid.Item>
</Grid>`,
      },
    ]

  | "progress" => [
      {
        title: "Progress Variants",
        description: "Progress bars with different colors.",
        demo: <div style="display: flex; flex-direction: column; gap: 1.5rem;">
          <div>
            <Typography text={ReactiveProp.Static("Default")} variant={Typography.Small} />
            <Progress value={Signal.make(45.0)} variant={Progress.Default} />
          </div>
          <div>
            <Typography text={ReactiveProp.Static("Primary")} variant={Typography.Small} />
            <Progress value={Signal.make(60.0)} variant={Progress.Primary} />
          </div>
          <div>
            <Typography text={ReactiveProp.Static("Success")} variant={Typography.Small} />
            <Progress value={Signal.make(75.0)} variant={Progress.Success} />
          </div>
          <div>
            <Typography text={ReactiveProp.Static("Warning")} variant={Typography.Small} />
            <Progress value={Signal.make(45.0)} variant={Progress.Warning} />
          </div>
          <div>
            <Typography text={ReactiveProp.Static("Error")} variant={Typography.Small} />
            <Progress value={Signal.make(30.0)} variant={Progress.Error} />
          </div>
        </div>,
        code: `<Progress value={Signal.make(60.0)} variant={Progress.Primary} />
<Progress value={Signal.make(75.0)} variant={Progress.Success} />`,
      },
      {
        title: "Progress Sizes",
        description: "Different sizes for progress bars.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Progress value={Signal.make(50.0)} size={Progress.Sm} />
          <Progress value={Signal.make(50.0)} size={Progress.Md} />
          <Progress value={Signal.make(50.0)} size={Progress.Lg} />
        </div>,
        code: `<Progress value={Signal.make(50.0)} size={Progress.Md} />`,
      },
    ]

  | "breadcrumb" => [
      {
        title: "Basic Breadcrumb",
        description: "Navigation breadcrumbs showing current location.",
        demo: <Breadcrumb
          items={[
            {label: "Home", href: Some("/"), onClick: None},
            {label: "Products", href: Some("/products"), onClick: None},
            {label: "Electronics", href: Some("/products/electronics"), onClick: None},
            {label: "Laptop", href: None, onClick: None},
          ]}
        />,
        code: `<Breadcrumb
  items={[
    {label: "Home", href: Some("/"), onClick: None},
    {label: "Products", href: Some("/products"), onClick: None},
    {label: "Laptop", href: None, onClick: None},
  ]}
/>`,
      },
    ]

  | "accordion" => [
      {
        title: "Basic Accordion",
        description: "Collapsible content panels.",
        demo: <Accordion
          items={[
            {
              value: "item1",
              title: "What is basefn-UI?",
              content: <p>
                {Component.text(
                  "basefn-UI is a modern ReScript UI component library built with Xote for fine-grained reactivity.",
                )}
              </p>,
            },
            {
              value: "item2",
              title: "How do I install it?",
              content: <p>
                {Component.text(
                  "You can install basefn-UI via npm or use it directly in your ReScript project.",
                )}
              </p>,
            },
            {
              value: "item3",
              title: "Is it free?",
              content: <p> {Component.text("Yes, basefn-UI is open source and free to use.")} </p>,
            },
          ]}
        />,
        code: `<Accordion
  items={[
    {
      value: "item1",
      title: "Question?",
      content: <p>{Component.text("Answer here")}</p>,
    },
  ]}
/>`,
      },
    ]

  | "modal" => [
      {
        title: "Basic Modal",
        description: "Display content in an overlay dialog.",
        demo: {
          let isOpen = Signal.make(false)
          <div>
            <Button label={Static("Open Modal")} onClick={_ => Signal.set(isOpen, true)} />
            <Modal isOpen onClose={() => Signal.set(isOpen, false)} title={"Welcome"}>
              <p>
                {Component.text(
                  "This is a modal dialog. Click outside or press the close button to dismiss.",
                )}
              </p>
            </Modal>
          </div>
        },
        code: `let isOpen = Signal.make(false)

<Button label={("Open Modal")} onClick={_ => Signal.set(isOpen, true)} />
<Modal isOpen onClose={() => Signal.set(isOpen, false)} title={"Welcome"}>
  <p>{Component.text("Modal content")}</p>
</Modal>`,
      },
      {
        title: "Modal Sizes",
        description: "Modals in different sizes.",
        demo: {
          let isSmOpen = Signal.make(false)
          let isMdOpen = Signal.make(false)
          let isLgOpen = Signal.make(false)
          <div style="display: flex; gap: 0.5rem;">
            <Button
              label={Static("Small")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(isSmOpen, true)}
            />
            <Button
              label={Static("Medium")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(isMdOpen, true)}
            />
            <Button
              label={Static("Large")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(isLgOpen, true)}
            />
            <Modal
              isOpen={isSmOpen}
              onClose={() => Signal.set(isSmOpen, false)}
              title={"Small Modal"}
              size={Modal.Sm}
            >
              <p> {Component.text("Small modal content.")} </p>
            </Modal>
            <Modal
              isOpen={isMdOpen}
              onClose={() => Signal.set(isMdOpen, false)}
              title={"Medium Modal"}
              size={Modal.Md}
            >
              <p> {Component.text("Medium modal content.")} </p>
            </Modal>
            <Modal
              isOpen={isLgOpen}
              onClose={() => Signal.set(isLgOpen, false)}
              title={"Large Modal"}
              size={Modal.Lg}
            >
              <p> {Component.text("Large modal content.")} </p>
            </Modal>
          </div>
        },
        code: `<Modal isOpen onClose={onClose} title={"Title"} size={Modal.Lg}>
  <p>{Component.text("Content")}</p>
</Modal>`,
      },
    ]

  | "switch" => [
      {
        title: "Basic Switch",
        description: "Toggle between on and off states.",
        demo: {
          let isEnabled = Signal.make(false)
          <div style="display: flex; flex-direction: column; gap: 1rem;">
            <Switch checked={isEnabled} label="Enable notifications" />
            <Switch checked={Signal.make(true)} label="Dark mode" />
            <Switch checked={Signal.make(false)} label="Auto-save" disabled={true} />
          </div>
        },
        code: `let isEnabled = Signal.make(false)

<Switch checked={isEnabled} label="Enable notifications" />`,
      },
      {
        title: "Switch Sizes",
        description: "Switches in different sizes.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Switch checked={Signal.make(true)} label="Small" size={Switch.Sm} />
          <Switch checked={Signal.make(true)} label="Medium" size={Switch.Md} />
          <Switch checked={Signal.make(true)} label="Large" size={Switch.Lg} />
        </div>,
        code: `<Switch checked={Signal.make(true)} label="Medium" size={Switch.Md} />`,
      },
    ]

  | "slider" => [
      {
        title: "Basic Slider",
        description: "Select a value from a range.",
        demo: {
          let value = Signal.make(50.0)
          <Slider value label="Volume" min={0.0} max={100.0} />
        },
        code: `let value = Signal.make(50.0)

<Slider value label="Volume" min={0.0} max={100.0} />`,
      },
      {
        title: "Slider with Markers",
        description: "Slider with labeled markers.",
        demo: {
          let value = Signal.make(2.0)
          <Slider
            value
            label="Quality"
            min={0.0}
            max={4.0}
            step={1.0}
            markers={["Low", "Med", "High", "Max", "Ultra"]}
          />
        },
        code: `let value = Signal.make(2.0)

<Slider value label="Quality" min={0.0} max={4.0} step={1.0} markers={["Low", "Med", "High", "Max", "Ultra"]} />`,
      },
    ]

  | "tooltip" => [
      {
        title: "Tooltip Positions",
        description: "Show helpful hints on hover.",
        demo: <div style="display: flex; gap: 2rem; justify-content: center; padding: 3rem;">
          <Tooltip content="Tooltip on top" position={Tooltip.Top}>
            <Button label={Static("Top")} variant={Button.Ghost} />
          </Tooltip>
          <Tooltip content="Tooltip on bottom" position={Tooltip.Bottom}>
            <Button label={Static("Bottom")} variant={Button.Ghost} />
          </Tooltip>
          <Tooltip content="Tooltip on left" position={Tooltip.Left}>
            <Button label={Static("Left")} variant={Button.Ghost} />
          </Tooltip>
          <Tooltip content="Tooltip on right" position={Tooltip.Right}>
            <Button label={Static("Right")} variant={Button.Ghost} />
          </Tooltip>
        </div>,
        code: `<Tooltip content="Helpful hint" position={Tooltip.Top}>
  <Button label={("Hover me")} />
</Tooltip>`,
      },
    ]

  | "dropdown" => [
      {
        title: "Basic Dropdown",
        description: "Menu with multiple actions.",
        demo: <Dropdown
          trigger={<Button label={Static("Actions")} variant={Button.Secondary} />}
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

  | "toast" => [
      {
        title: "Toast Notifications",
        description: "Temporary notification messages.",
        demo: {
          let showSuccess = Signal.make(false)
          let showError = Signal.make(false)
          let showWarning = Signal.make(false)
          <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
            <Button
              label={Static("Success")}
              variant={Button.Primary}
              onClick={_ => Signal.set(showSuccess, true)}
            />
            <Button
              label={Static("Error")}
              variant={Button.Secondary}
              onClick={_ => Signal.set(showError, true)}
            />
            <Button
              label={Static("Warning")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(showWarning, true)}
            />
            <Toast
              isVisible={showSuccess}
              onClose={() => Signal.set(showSuccess, false)}
              title={"Success"}
              message="Operation completed successfully!"
              variant={Toast.Success}
            />
            <Toast
              isVisible={showError}
              onClose={() => Signal.set(showError, false)}
              title={"Error"}
              message="Something went wrong."
              variant={Toast.Error}
            />
            <Toast
              isVisible={showWarning}
              onClose={() => Signal.set(showWarning, false)}
              title={"Warning"}
              message="Please review your changes."
              variant={Toast.Warning}
            />
          </div>
        },
        code: `let isVisible = Signal.make(false)

<Button label={("Show Toast")} onClick={_ => Signal.set(isVisible, true)} />
<Toast
  isVisible
  onClose={() => Signal.set(isVisible, false)}
  title={"Success"}
  message="Operation completed!"
  variant={Toast.Success}
/>`,
      },
    ]

  | "stepper" => [
      {
        title: "Horizontal Stepper",
        description: "Guide users through a multi-step process.",
        demo: {
          let currentStep = Signal.make(1)
          <div style="display: flex; flex-direction: column; gap: 1.5rem;">
            <Stepper
              steps={[
                {
                  title: "Account Details",
                  description: Some("Enter your personal information"),
                  status: Stepper.Completed,
                },
                {
                  title: "Verification",
                  description: Some("Verify your email address"),
                  status: Stepper.Active,
                },
                {
                  title: "Preferences",
                  description: Some("Customize your settings"),
                  status: Stepper.Inactive,
                },
                {
                  title: "Complete",
                  description: Some("Review and finish setup"),
                  status: Stepper.Inactive,
                },
              ]}
              currentStep={currentStep}
              orientation={Stepper.Horizontal}
            />
            <div style="display: flex; gap: 0.5rem; justify-content: center;">
              <Button
                label={Static("Previous")}
                variant={Button.Secondary}
                onClick={_ => Signal.update(currentStep, step => step > 0 ? step - 1 : step)}
              />
              <Button
                label={Static("Next")}
                variant={Button.Primary}
                onClick={_ => Signal.update(currentStep, step => step < 3 ? step + 1 : step)}
              />
            </div>
          </div>
        },
        code: `let currentStep = Signal.make(1)

<Stepper
  steps={[
    {
      title: "Account Details",
      description: Some("Enter your personal information"),
      status: Stepper.Completed,
    },
    {
      title: "Verification",
      description: Some("Verify your email address"),
      status: Stepper.Active,
    },
  ]}
  currentStep={currentStep}
  orientation={Stepper.Horizontal}
/>`,
      },
      {
        title: "Vertical Stepper",
        description: "Vertical layout for detailed step content.",
        demo: {
          let currentStep = Signal.make(0)
          <Stepper
            steps={[
              {
                title: "Create Account",
                description: Some("Sign up with your email"),
                status: Stepper.Active,
              },
              {
                title: "Verify Email",
                description: Some("Check your inbox for verification link"),
                status: Stepper.Inactive,
              },
              {
                title: "Complete Profile",
                description: Some("Add your profile information"),
                status: Stepper.Inactive,
              },
            ]}
            currentStep={currentStep}
            orientation={Stepper.Vertical}
          />
        },
        code: `<Stepper
  steps={[
    {
      title: "Create Account",
      description: Some("Sign up with your email"),
      status: Stepper.Active,
    },
    {
      title: "Verify Email",
      description: Some("Check your inbox"),
      status: Stepper.Inactive,
    },
  ]}
  orientation={Stepper.Vertical}
/>`,
      },
    ]

  | "drawer" => [
      {
        title: "Drawer Positions",
        description: "Drawers can slide in from any edge of the screen.",
        demo: {
          let isRightOpen = Signal.make(false)
          let isLeftOpen = Signal.make(false)
          <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
            <Button
              label={Static("Open Righ)t Drawer")}
              variant={Button.Primary}
              onClick={_ => Signal.set(isRightOpen, true)}
            />
            <Button
              label={Static("Open Lef)t Drawer")}
              variant={Button.Secondary}
              onClick={_ => Signal.set(isLeftOpen, true)}
            />
            <Drawer
              isOpen={isRightOpen}
              onClose={() => Signal.set(isRightOpen, false)}
              position={Drawer.Right}
              title={"Settings"}
            >
              <div style="display: flex; flex-direction: column; gap: 1rem;">
                <Typography text={ReactiveProp.Static("Drawer Content")} variant={Typography.H5} />
                <p> {Component.text("This drawer slides in from the right side.")} </p>
              </div>
            </Drawer>
            <Drawer
              isOpen={isLeftOpen}
              onClose={() => Signal.set(isLeftOpen, false)}
              position={Drawer.Left}
              title={"Navigation"}
            >
              <div style="display: flex; flex-direction: column; gap: 1rem;">
                <Typography text={ReactiveProp.Static("Menu Items")} variant={Typography.H5} />
                <p> {Component.text("This drawer slides in from the left side.")} </p>
              </div>
            </Drawer>
          </div>
        },
        code: `let isOpen = Signal.make(false)

<Button
  label={Signal.make("Open Drawer")}
  onClick={_ => Signal.set(isOpen, true)}
/>

<Drawer
  isOpen={isOpen}
  onClose={() => Signal.set(isOpen, false)}
  position={Drawer.Right}
  title={"Settings"}
>
  <p>{Component.text("Drawer content")}</p>
</Drawer>`,
      },
      {
        title: "Drawer Sizes",
        description: "Control drawer width with size variants.",
        demo: {
          let isSmallOpen = Signal.make(false)
          let isMediumOpen = Signal.make(false)
          let isLargeOpen = Signal.make(false)
          <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
            <Button
              label={Static("Small")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(isSmallOpen, true)}
            />
            <Button
              label={Static("Medium")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(isMediumOpen, true)}
            />
            <Button
              label={Static("Large")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(isLargeOpen, true)}
            />
            <Drawer
              isOpen={isSmallOpen}
              onClose={() => Signal.set(isSmallOpen, false)}
              size={Drawer.Sm}
              title={"Small Drawer"}
            >
              <p> {Component.text("This is a small drawer (240px).")} </p>
            </Drawer>
            <Drawer
              isOpen={isMediumOpen}
              onClose={() => Signal.set(isMediumOpen, false)}
              size={Drawer.Md}
              title={"Medium Drawer"}
            >
              <p> {Component.text("This is a medium drawer (320px).")} </p>
            </Drawer>
            <Drawer
              isOpen={isLargeOpen}
              onClose={() => Signal.set(isLargeOpen, false)}
              size={Drawer.Lg}
              title={"Large Drawer"}
            >
              <p> {Component.text("This is a large drawer (480px).")} </p>
            </Drawer>
          </div>
        },
        code: `<Drawer
  isOpen={isOpen}
  onClose={() => Signal.set(isOpen, false)}
  size={Drawer.Sm}
  title={"Small Drawer"}
>
  <p>{Component.text("Content")}</p>
</Drawer>`,
      },
    ]

  | "timeline" => [
      {
        title: "Vertical Timeline",
        description: "Display events in chronological order.",
        demo: <Timeline
          items={[
            {
              title: "Project Created",
              timestamp: Some("2 hours ago"),
              description: Some("Initial project setup and configuration"),
              variant: Timeline.Success,
              icon: Some("\u2713"),
            },
            {
              title: "First Commit",
              timestamp: Some("1 hour ago"),
              description: Some("Added basic component structure"),
              variant: Timeline.Primary,
              icon: None,
            },
            {
              title: "Deploy to Staging",
              timestamp: Some("30 minutes ago"),
              description: Some("Deployed latest changes to staging environment"),
              variant: Timeline.Warning,
              icon: None,
            },
            {
              title: "Production Release",
              timestamp: Some("Pending"),
              description: Some("Awaiting final approval"),
              variant: Timeline.Default,
              icon: None,
            },
          ]}
          orientation={Timeline.Vertical}
        />,
        code: `<Timeline
  items={[
    {
      title: "Project Created",
      timestamp: Some("2 hours ago"),
      description: Some("Initial setup"),
      variant: Timeline.Success,
      icon: Some("\u2713"),
    },
    {
      title: "First Commit",
      timestamp: Some("1 hour ago"),
      description: Some("Added components"),
      variant: Timeline.Primary,
      icon: None,
    },
  ]}
  orientation={Timeline.Vertical}
/>`,
      },
      {
        title: "Timeline Variants",
        description: "Different color variants for timeline items.",
        demo: <Timeline
          items={[
            {
              title: "Success Event",
              timestamp: None,
              description: Some("Operation completed successfully"),
              variant: Timeline.Success,
              icon: Some("\u2713"),
            },
            {
              title: "Warning Event",
              timestamp: None,
              description: Some("Action requires attention"),
              variant: Timeline.Warning,
              icon: Some("!"),
            },
            {
              title: "Error Event",
              timestamp: None,
              description: Some("An error occurred"),
              variant: Timeline.Error,
              icon: Some("\u00d7"),
            },
          ]}
          orientation={Timeline.Vertical}
        />,
        code: `<Timeline
  items={[
    {
      title: "Success",
      variant: Timeline.Success,
      icon: Some("\u2713"),
    },
    {
      title: "Warning",
      variant: Timeline.Warning,
      icon: Some("!"),
    },
  ]}
/>`,
      },
    ]

  | "sidebar" => [
      {
        title: "Dark Sidebar",
        description: "Navigation sidebar with dark theme.",
        demo: {
          let activePage = Signal.make("dashboard")
          <div
            style="height: 400px; background: #f9fafb; border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;"
          >
            <Sidebar
              logo={<div> {Component.text("MyApp")} </div>}
              sections={[
                {
                  title: None,
                  items: [
                    {
                      label: "Dashboard",
                      icon: Some("\u{1F4CA}"),
                      active: Signal.get(activePage) == "dashboard",
                      url: "/dashboard",
                    },
                    {
                      label: "Projects",
                      icon: Some("\u{1F4C1}"),
                      active: Signal.get(activePage) == "projects",
                      url: "/projects",
                    },
                  ],
                },
                {
                  title: Some("Settings"),
                  items: [
                    {
                      label: "Profile",
                      icon: Some("\u{1F464}"),
                      active: Signal.get(activePage) == "profile",
                      url: "/profile",
                    },
                    {
                      label: "Preferences",
                      icon: Some("\u2699\uFE0F"),
                      active: Signal.get(activePage) == "preferences",
                      url: "/profile",
                    },
                  ],
                },
              ]}
              footer={<div style="font-size: 0.75rem; color: #9ca3af;">
                {Component.text("v1.0.0")}
              </div>}
            />
          </div>
        },
        code: `let activePage = Signal.make("dashboard")

<Sidebar
  logo={Some(<div>{Component.text("MyApp")}</div>)}
  theme={Sidebar.Dark}
  sections={[
    {
      title: None,
      items: [
        {
          label: "Dashboard",
          icon: Some("\u{1F4CA}"),
          active: Signal.get(activePage) == "dashboard",
          onClick: () => Signal.set(activePage, "dashboard"),
        },
      ],
    },
  ]}
/>`,
      },
      {
        title: "Light Sidebar",
        description: "Sidebar with light theme variant.",
        demo: {
          let activePage = Signal.make("home")
          <div
            style="height: 400px; background: #1f2937; border: 1px solid #374151; border-radius: 0.5rem; overflow: hidden;"
          >
            <Sidebar
              logo={<div> {Component.text("Dashboard")} </div>}
              size={Sidebar.Md}
              sections={[
                {
                  title: Some("Main"),
                  items: [
                    {
                      label: "Home",
                      icon: Some("\u{1F3E0}"),
                      active: Signal.get(activePage) == "home",
                      url: "/profile",
                    },
                    {
                      label: "Analytics",
                      icon: Some("\u{1F4C8}"),
                      active: Signal.get(activePage) == "analytics",
                      url: "/profile",
                    },
                    {
                      label: "Reports",
                      icon: Some("\u{1F4CB}"),
                      active: Signal.get(activePage) == "reports",
                      url: "/profile",
                    },
                  ],
                },
              ]}
            />
          </div>
        },
        code: `<Sidebar
  logo={Some(<div>{Component.text("Dashboard")}</div>)}
  theme={Sidebar.Light}
  sections={[
    {
      title: Some("Main"),
      items: [
        {label: "Home", icon: Some("\u{1F3E0}"), active: true, onClick: () => ()},
        {label: "Analytics", icon: Some("\u{1F4C8}"), active: false, onClick: () => ()},
      ],
    },
  ]}
/>`,
      },
    ]

  | "topbar" => [
      {
        title: "Light Topbar",
        description: "Application header with navigation.",
        demo: {
          let activeNav = Signal.make("home")
          <div style="border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;">
            <Topbar
              logo={<div> {Component.text("Brand")} </div>}
              navItems={[
                {
                  label: "Home",
                  active: Signal.get(activeNav) == "home",
                  onClick: () => Signal.set(activeNav, "home"),
                },
                {
                  label: "Features",
                  active: Signal.get(activeNav) == "features",
                  onClick: () => Signal.set(activeNav, "features"),
                },
                {
                  label: "Pricing",
                  active: Signal.get(activeNav) == "pricing",
                  onClick: () => Signal.set(activeNav, "pricing"),
                },
              ]}
              rightContent={<div style="display: flex; gap: 0.5rem;">
                <Button label={Static("Login")} variant={Button.Ghost} />
                <Button label={Static("Sign Up")} variant={Button.Primary} />
              </div>}
            />
          </div>
        },
        code: `let activeNav = Signal.make("home")

<Topbar
  logo={Some(<div>{Component.text("Brand")}</div>)}
  theme={Topbar.Light}
  navItems={Some([
    {
      label: "Home",
      active: Signal.get(activeNav) == "home",
      onClick: () => Signal.set(activeNav, "home"),
    },
    {label: "Features", active: false, onClick: () => ()},
  ])}
  rightContent={Some(<Button label={Signal.make("Login")} />)}
/>`,
      },
      {
        title: "Dark Topbar with Menu",
        description: "Dark themed topbar with menu button.",
        demo: {
          let menuOpen = Signal.make(false)
          <div style="border: 1px solid #374151; border-radius: 0.5rem; overflow: hidden;">
            <Topbar
              logo={<div> {Component.text("App")} </div>}
              size={Topbar.Md}
              onMenuClick={() => Signal.update(menuOpen, m => !m)}
              rightContent={<div style="display: flex; gap: 0.75rem; align-items: center;">
                <Badge label={Signal.make("3")} variant={Badge.Primary} size={Badge.Sm} />
                <Avatar size={Avatar.Sm} name="User" />
              </div>}
            />
          </div>
        },
        code: `let menuOpen = Signal.make(false)

<Topbar
  logo={Some(<div>{Component.text("App")}</div>)}
  theme={Topbar.Dark}
  onMenuClick={Some(() => Signal.update(menuOpen, m => !m))}
  rightContent={Some(
    <div style="display: flex; gap: 0.75rem;">
      <Badge label={Signal.make("3")} variant={Badge.Primary} />
      <Avatar size={Avatar.Sm} name="User" />
    </div>
  )}
/>`,
      },
    ]

  | "icon" => [
      {
        title: "All Available Icons",
        description: "Complete list of icons included in basefn-UI.",
        demo: <div
          style="display: grid; grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); gap: 1.5rem; padding: 1rem;"
        >
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Check} />
            <Typography text={ReactiveProp.Static("Check")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.X} />
            <Typography text={ReactiveProp.Static("X")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.ChevronDown} />
            <Typography text={ReactiveProp.Static("ChevronDown")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.ChevronUp} />
            <Typography text={ReactiveProp.Static("ChevronUp")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.ChevronLeft} />
            <Typography text={ReactiveProp.Static("ChevronLeft")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.ChevronRight} />
            <Typography text={ReactiveProp.Static("ChevronRight")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Search} />
            <Typography text={ReactiveProp.Static("Search")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Menu} />
            <Typography text={ReactiveProp.Static("Menu")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Home} />
            <Typography text={ReactiveProp.Static("Home")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.User} />
            <Typography text={ReactiveProp.Static("User")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Settings} />
            <Typography text={ReactiveProp.Static("Settings")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Info} />
            <Typography text={ReactiveProp.Static("Info")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.AlertCircle} />
            <Typography text={ReactiveProp.Static("AlertCircle")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.AlertTriangle} />
            <Typography text={ReactiveProp.Static("AlertTriangle")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Loader} />
            <Typography text={ReactiveProp.Static("Loader")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Plus} />
            <Typography text={ReactiveProp.Static("Plus")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Minus} />
            <Typography text={ReactiveProp.Static("Minus")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Trash} />
            <Typography text={ReactiveProp.Static("Trash")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Edit} />
            <Typography text={ReactiveProp.Static("Edit")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Copy} />
            <Typography text={ReactiveProp.Static("Copy")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.ExternalLink} />
            <Typography text={ReactiveProp.Static("ExternalLink")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Download} />
            <Typography text={ReactiveProp.Static("Download")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Upload} />
            <Typography text={ReactiveProp.Static("Upload")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Heart} />
            <Typography text={ReactiveProp.Static("Heart")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Star} />
            <Typography text={ReactiveProp.Static("Star")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Sun} />
            <Typography text={ReactiveProp.Static("Sun")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Moon} />
            <Typography text={ReactiveProp.Static("Moon")} variant={Typography.Small} />
          </div>
        </div>,
        code: `<Icon name={Icon.Check} />
<Icon name={Icon.Search} />
<Icon name={Icon.Settings} />
<Icon name={Icon.Heart} />
// See all icons in the example above`,
      },
      {
        title: "Icon Sizes",
        description: "Icons come in four sizes: small, medium, large, and extra large.",
        demo: <div style="display: flex; gap: 2rem; align-items: center;">
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Heart} size={Icon.Sm} />
            <Typography text={ReactiveProp.Static("Small (16px)")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Heart} size={Icon.Md} />
            <Typography text={ReactiveProp.Static("Medium (24px)")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Heart} size={Icon.Lg} />
            <Typography text={ReactiveProp.Static("Large (32px)")} variant={Typography.Small} />
          </div>
          <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Heart} size={Icon.Xl} />
            <Typography text={ReactiveProp.Static("XLarge (48px)")} variant={Typography.Small} />
          </div>
        </div>,
        code: `<Icon name={Icon.Heart} size={Icon.Sm} />
<Icon name={Icon.Heart} size={Icon.Md} />
<Icon name={Icon.Heart} size={Icon.Lg} />
<Icon name={Icon.Heart} size={Icon.Xl} />`,
      },
      {
        title: "Colored Icons",
        description: "Icons inherit color from their context or can be colored explicitly.",
        demo: <div style="display: flex; gap: 1.5rem; align-items: center; flex-wrap: wrap;">
          <Icon name={Icon.Heart} color={ReactiveProp.static("red")} size={Icon.Lg} />
          <Icon name={Icon.Star} color={ReactiveProp.static("gold")} size={Icon.Lg} />
          <Icon name={Icon.Check} color={ReactiveProp.static("green")} size={Icon.Lg} />
          <Icon name={Icon.AlertCircle} color={ReactiveProp.static("orange")} size={Icon.Lg} />
          <Icon name={Icon.X} color={ReactiveProp.static("red")} size={Icon.Lg} />
          <Icon name={Icon.Info} color={ReactiveProp.static("blue")} size={Icon.Lg} />
        </div>,
        code: `<Icon name={Icon.Heart} color={ReactiveProp.static("red")} />
<Icon name={Icon.Star} color={ReactiveProp.static("gold")} />
<Icon name={Icon.Check} color={ReactiveProp.static("green")} />`,
      },
      {
        title: "Icons in Buttons",
        description: "Icons work great alongside text in buttons and other components.",
        demo: <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
          <Button variant={Button.Primary}>
            <div style="display: flex; align-items: center; gap: 0.5rem;">
              <Icon name={Icon.Download} size={Icon.Sm} />
              {Component.text("Download")}
            </div>
          </Button>
          <Button variant={Button.Secondary}>
            <div style="display: flex; align-items: center; gap: 0.5rem;">
              <Icon name={Icon.Upload} size={Icon.Sm} />
              {Component.text("Upload")}
            </div>
          </Button>
          <Button variant={Button.Ghost}>
            <div style="display: flex; align-items: center; gap: 0.5rem;">
              <Icon name={Icon.Trash} size={Icon.Sm} />
              {Component.text("Delete")}
            </div>
          </Button>
          <Button variant={Button.Primary}>
            <div style="display: flex; align-items: center; gap: 0.5rem;">
              {Component.text("Next")}
              <Icon name={Icon.ChevronRight} size={Icon.Sm} />
            </div>
          </Button>
        </div>,
        code: `<Button variant={Button.Primary}>
  <div style="display: flex; align-items: center; gap: 0.5rem;">
    <Icon name={Icon.Download} size={Icon.Sm} />
    {Component.text("Download")}
  </div>
</Button>`,
      },
    ]

  | "app-layout" => [
      {
        title: "Complete App Layout",
        description: "Full application layout with sidebar and topbar.",
        demo: {
          let activePage = Signal.make("dashboard")
          let activeNav = Signal.make("overview")
          <div
            style="position: relative; height: 500px; border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;"
          >
            <AppLayout
              sidebar={<Sidebar
                logo={<div> {Component.text("MyApp")} </div>}
                size={Sidebar.Md}
                sections={[
                  {
                    title: None,
                    items: [
                      {
                        label: "Dashboard",
                        icon: Some("\u{1F4CA}"),
                        active: Signal.get(activePage) == "dashboard",
                        url: "/profile",
                      },
                      {
                        label: "Users",
                        icon: Some("\u{1F464}"),
                        active: Signal.get(activePage) == "users",
                        url: "/profile",
                      },
                    ],
                  },
                ]}
              />}
              topbar={<Topbar
                navItems={[
                  {
                    label: "Overview",
                    active: Signal.get(activeNav) == "overview",
                    onClick: () => Signal.set(activeNav, "overview"),
                  },
                  {
                    label: "Analytics",
                    active: Signal.get(activeNav) == "analytics",
                    onClick: () => Signal.set(activeNav, "analytics"),
                  },
                ]}
                rightContent={<Avatar size={Avatar.Sm} name="User" />}
              />}
              contentWidth={AppLayout.Contained}
            >
              <Card>
                <Typography
                  text={ReactiveProp.Static("Welcome to your dashboard!")} variant={Typography.H4}
                />
                <p style="margin-top: 1rem; color: #6b7280;">
                  {Component.text("This is a complete application layout example.")}
                </p>
              </Card>
            </AppLayout>
          </div>
        },
        code: `<AppLayout
  sidebar={Some(
    <Sidebar
      logo={Some(<div>{Component.text("MyApp")}</div>)}
      sections={[...]}
    />
  )}
  topbar={Some(
    <Topbar
      navItems={Some([...])}
      rightContent={Some(<Avatar name="User" />)}
    />
  )}
  contentWidth={AppLayout.Contained}
>
  <Card>
    <Typography text={ReactiveProp.Static("Content")} variant={Typography.H4} />
  </Card>
</AppLayout>`,
      },
      {
        title: "Simple Layout",
        description: "Layout with topbar only.",
        demo: <div
          style="position: relative; height: 300px; border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;"
        >
          <AppLayout
            topbar={<Topbar
              logo={<div> {Component.text("Simple App")} </div>}
              rightContent={<Button label={Static("Get Starte")} variant={Button.Primary} />}
            />}
            contentWidth={AppLayout.FullWidth}
            noPadding={false}
          >
            <div style="padding: 2rem;">
              <Typography
                text={ReactiveProp.Static("Simple layout without sidebar")} variant={Typography.H3}
              />
              <p style="margin-top: 1rem; color: #6b7280;">
                {Component.text("Perfect for landing pages and simple applications.")}
              </p>
            </div>
          </AppLayout>
        </div>,
        code: `<AppLayout
  topbar={Some(
    <Topbar
      logo={Some(<div>{Component.text("App")}</div>)}
      rightContent={Some(<Button label={Signal.make("Start")} />)}
    />
  )}
  contentWidth={AppLayout.FullWidth}
>
  <div>
    <Typography text={ReactiveProp.Static("Content")} variant={Typography.H3} />
  </div>
</AppLayout>`,
      },
    ]

  | _ => [
      {
        title: "Component Examples Coming Soon",
        description: "Documentation for this component is being prepared.",
        demo: <div style="padding: 2rem; text-align: center;">
          <Typography
            text={ReactiveProp.Static("Examples coming soon...")} variant={Typography.Muted}
          />
        </div>,
        code: `// Examples for this component will be added soon`,
      },
    ]
  }
}
