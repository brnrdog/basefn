open Xote
open Basefn

module ComponentDoc = {
  @jsx.component
  let make = (~name: string, ~props: array<(string, string, string)>) => {
    let propsSignal = Signal.make(props)
    <Card style="margin-bottom: 1rem;">
      <Typography text={ReactiveProp.Static(name)} variant={Typography.H4} />
      <table style="width: 100%; border-collapse: collapse; margin-top: 0.5rem;">
        <thead>
          <tr style="border-bottom: 1px solid var(--border);">
            <th style="text-align: left; padding: 0.5rem; font-weight: 600;">
              {Component.text("Prop")}
            </th>
            <th style="text-align: left; padding: 0.5rem; font-weight: 600;">
              {Component.text("Type")}
            </th>
            <th style="text-align: left; padding: 0.5rem; font-weight: 600;">
              {Component.text("Description")}
            </th>
          </tr>
        </thead>
        <tbody>
          {Component.list(propsSignal, prop => {
            let (propName, propType, description) = prop
            <tr style="border-bottom: 1px solid var(--border);">
              <td style="padding: 0.5rem;">
                <code style="background: var(--muted); padding: 0.125rem 0.25rem; border-radius: 0.25rem;">
                  {Component.text(propName)}
                </code>
              </td>
              <td style="padding: 0.5rem; color: var(--muted-foreground);">
                {Component.text(propType)}
              </td>
              <td style="padding: 0.5rem;"> {Component.text(description)} </td>
            </tr>
          })}
        </tbody>
      </table>
    </Card>
  }
}

@jsx.component
let make = () => {
  <div class="docs-component-page">
    <Typography text={ReactiveProp.Static("API Reference")} variant={Typography.H2} />
    <Typography
      text={ReactiveProp.Static("Component props and types reference.")}
      variant={Typography.Lead}
    />
    // Form Components
    <Typography text={ReactiveProp.Static("Form Components")} variant={Typography.H3} />
    <ComponentDoc
      name="Button"
      props={[
        ("label", "ReactiveProp.t<string>", "Button text"),
        ("variant", "Button.variant", "Primary | Secondary | Outline | Ghost | Destructive"),
        ("size", "Button.size", "Sm | Md | Lg"),
        ("disabled", "Signal.t<bool>", "Disable the button"),
        ("onClick", "Event.t => unit", "Click handler"),
      ]}
    />
    <ComponentDoc
      name="Input"
      props={[
        ("value", "ReactiveProp.t<string>", "Input value"),
        ("type_", "Input.inputType", "Text | Email | Password | Number | Search | Tel | Url"),
        ("placeholder", "string", "Placeholder text"),
        ("disabled", "bool", "Disable the input"),
        ("onInput", "Event.t => unit", "Input change handler"),
      ]}
    />
    <ComponentDoc
      name="Textarea"
      props={[
        ("value", "ReactiveProp.t<string>", "Textarea value"),
        ("placeholder", "string", "Placeholder text"),
        ("rows", "int", "Number of visible rows"),
        ("disabled", "bool", "Disable the textarea"),
        ("onInput", "Event.t => unit", "Input change handler"),
      ]}
    />
    <ComponentDoc
      name="Select"
      props={[
        ("value", "Signal.t<string>", "Selected value"),
        ("options", "array<Select.option>", "Array of {value, label} options"),
        ("placeholder", "string", "Placeholder text"),
        ("disabled", "bool", "Disable the select"),
        ("onChange", "Event.t => unit", "Change handler"),
      ]}
    />
    <ComponentDoc
      name="Checkbox"
      props={[
        ("checked", "Signal.t<bool>", "Checked state"),
        ("label", "string", "Label text"),
        ("disabled", "bool", "Disable the checkbox"),
        ("onChange", "Event.t => unit", "Change handler"),
      ]}
    />
    <ComponentDoc
      name="Radio"
      props={[
        ("name", "string", "Radio group name"),
        ("value", "string", "Radio value"),
        ("checked", "Signal.t<bool>", "Checked state"),
        ("label", "string", "Label text"),
        ("onChange", "Event.t => unit", "Change handler"),
      ]}
    />
    <ComponentDoc
      name="Label"
      props={[
        ("text", "string", "Label text"),
        ("required", "bool", "Show required indicator"),
        ("htmlFor", "string", "Associated input id"),
      ]}
    />
    // Foundation Components
    <Typography text={ReactiveProp.Static("Foundation Components")} variant={Typography.H3} />
    <ComponentDoc
      name="Badge"
      props={[
        ("text", "ReactiveProp.t<string>", "Badge text"),
        ("variant", "Badge.variant", "Default | Primary | Secondary | Outline | Destructive"),
      ]}
    />
    <ComponentDoc
      name="Spinner"
      props={[("size", "Spinner.size", "Sm | Md | Lg"), ("color", "string", "Spinner color")]}
    />
    <ComponentDoc
      name="Separator"
      props={[
        ("orientation", "Separator.orientation", "Horizontal | Vertical"),
        ("variant", "Separator.variant", "Solid | Dashed | Dotted"),
      ]}
    />
    <ComponentDoc
      name="Kbd" props={[("children", "Xote.element", "Key content to display")]}
    />
    <ComponentDoc
      name="Typography"
      props={[
        ("text", "ReactiveProp.t<string>", "Text content"),
        (
          "variant",
          "Typography.variant",
          "H1 | H2 | H3 | H4 | H5 | H6 | P | Lead | Large | Small | Muted | Code",
        ),
      ]}
    />
    // Display Components
    <Typography text={ReactiveProp.Static("Display Components")} variant={Typography.H3} />
    <ComponentDoc
      name="Card"
      props={[
        ("children", "Xote.element", "Card content"),
        ("style", "string", "Inline styles"),
        ("class", "string", "CSS class"),
      ]}
    />
    <ComponentDoc
      name="Avatar"
      props={[
        ("src", "string", "Image source URL"),
        ("alt", "string", "Alt text"),
        ("fallback", "string", "Fallback initials"),
        ("size", "Avatar.size", "Sm | Md | Lg"),
      ]}
    />
    <ComponentDoc
      name="Grid"
      props={[
        ("children", "Xote.element", "Grid items"),
        ("columns", "Grid.columns", "One | Two | Three | Four | Six"),
        ("gap", "Grid.gap", "Sm | Md | Lg"),
      ]}
    />
    <ComponentDoc
      name="Alert"
      props={[
        ("title", "string", "Alert title"),
        ("message", "Signal.t<string>", "Alert message"),
        ("variant", "Alert.variant", "Default | Info | Success | Warning | Destructive"),
      ]}
    />
    <ComponentDoc
      name="Progress"
      props={[
        ("value", "Signal.t<int>", "Progress value (0-100)"),
        ("variant", "Progress.variant", "Default | Primary | Success | Warning | Destructive"),
      ]}
    />
    // Navigation Components
    <Typography text={ReactiveProp.Static("Navigation Components")} variant={Typography.H3} />
    <ComponentDoc
      name="Tabs"
      props={[
        ("items", "array<Tabs.item>", "Array of {value, label, content} items"),
        ("defaultValue", "string", "Default active tab"),
      ]}
    />
    <ComponentDoc
      name="Accordion"
      props={[
        ("items", "array<Accordion.item>", "Array of {value, title, content} items"),
        ("defaultOpen", "array<string>", "Initially open items"),
      ]}
    />
    <ComponentDoc
      name="Breadcrumb"
      props={[("items", "array<Breadcrumb.item>", "Array of {label, href} items")]}
    />
    <ComponentDoc
      name="Stepper"
      props={[
        ("steps", "array<Stepper.step>", "Array of {label, description} steps"),
        ("currentStep", "Signal.t<int>", "Current step index"),
      ]}
    />
    <ComponentDoc
      name="Timeline"
      props={[("items", "array<Timeline.item>", "Array of {title, description, date} items")]}
    />
    // Interactive Components
    <Typography text={ReactiveProp.Static("Interactive Components")} variant={Typography.H3} />
    <ComponentDoc
      name="Modal"
      props={[
        ("isOpen", "Signal.t<bool>", "Open state"),
        ("onClose", "unit => unit", "Close handler"),
        ("title", "string", "Modal title"),
        ("children", "Xote.element", "Modal content"),
      ]}
    />
    <ComponentDoc
      name="Tooltip"
      props={[
        ("content", "string", "Tooltip text"),
        ("children", "Xote.element", "Trigger element"),
        ("position", "Tooltip.position", "Top | Bottom | Left | Right"),
      ]}
    />
    <ComponentDoc
      name="Switch"
      props={[
        ("checked", "Signal.t<bool>", "Checked state"),
        ("onChange", "Event.t => unit", "Change handler"),
        ("disabled", "bool", "Disable the switch"),
      ]}
    />
    <ComponentDoc
      name="Slider"
      props={[
        ("value", "Signal.t<int>", "Slider value"),
        ("min", "int", "Minimum value"),
        ("max", "int", "Maximum value"),
        ("step", "int", "Step increment"),
        ("onChange", "Event.t => unit", "Change handler"),
      ]}
    />
    <ComponentDoc
      name="Dropdown"
      props={[
        ("trigger", "Xote.element", "Trigger element"),
        ("items", "array<Dropdown.item>", "Array of {label, onClick} items"),
      ]}
    />
    <ComponentDoc
      name="Toast"
      props={[
        ("message", "string", "Toast message"),
        ("variant", "Toast.variant", "Default | Success | Error | Warning | Info"),
        ("duration", "int", "Auto-dismiss duration in ms"),
      ]}
    />
    <ComponentDoc
      name="Drawer"
      props={[
        ("isOpen", "Signal.t<bool>", "Open state"),
        ("onClose", "unit => unit", "Close handler"),
        ("position", "Drawer.position", "Left | Right"),
        ("children", "Xote.element", "Drawer content"),
      ]}
    />
    // Layout Components
    <Typography text={ReactiveProp.Static("Layout Components")} variant={Typography.H3} />
    <ComponentDoc
      name="Sidebar"
      props={[
        ("children", "Xote.element", "Sidebar content"),
        ("width", "string", "Sidebar width"),
        ("collapsed", "Signal.t<bool>", "Collapsed state"),
      ]}
    />
    <ComponentDoc
      name="Topbar"
      props={[
        ("children", "Xote.element", "Topbar content"),
        ("height", "string", "Topbar height"),
        ("position", "Topbar.position", "Fixed | Static"),
      ]}
    />
    <ComponentDoc
      name="AppLayout"
      props={[
        ("sidebar", "Xote.element", "Sidebar component"),
        ("topbar", "Xote.element", "Topbar component"),
        ("children", "Xote.element", "Main content"),
        ("topbarPosition", "AppLayout.topbarPosition", "AboveSidebar | BesideSidebar"),
      ]}
    />
    // Media Components
    <Typography text={ReactiveProp.Static("Media Components")} variant={Typography.H3} />
    <ComponentDoc
      name="Icon"
      props={[
        ("name", "string", "Icon name"),
        ("size", "Icon.size", "Sm | Md | Lg"),
        ("color", "string", "Icon color"),
      ]}
    />
  </div>
}
