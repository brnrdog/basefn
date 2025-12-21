open Xote
open Eita

@jsx.component
let make = () => {
  <div style="max-width: 800px; padding: 3rem 0;">
    <div style="text-align: center; margin-bottom: 3rem;">
      <Typography text={Signal.make("eita UI")} variant={Typography.H1} />
      <Typography
        text={Signal.make("A modern ReScript UI component library built with Xote")} variant={Lead}
      />
      <div style="margin-top: 2rem; display: flex; gap: 1rem; justify-content: center;">
        {Router.link(
          ~to="/component/button",
          ~children=[<Button label={Signal.make("Get Started")} variant={Button.Primary} />],
          (),
        )}
        <a
          href="https://github.com/yourusername/eita-ui"
          target="_blank"
          style="text-decoration: none;"
        >
          <Button label={Signal.make("View on GitHub")} variant={Ghost} />
        </a>
      </div>
    </div>
    <Separator orientation={Separator.Horizontal} />
    <div style="margin-top: 3rem;">
      <Typography text={Signal.make("Features")} variant={Typography.H2} />
      <div
        style="margin-top: 1.5rem; display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem;"
      >
        <Card>
          <Typography text={Signal.make("🎨 Modern Design")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text("Clean and beautiful components with thoughtful design patterns.")}
          </p>
        </Card>
        <Card>
          <Typography text={Signal.make("⚡ Built with Xote")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text("Leverages Xote's fine-grained reactivity with Signals.")}
          </p>
        </Card>
        <Card>
          <Typography text={Signal.make("🔒 Type-Safe")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text("Written in ReScript for complete type safety.")}
          </p>
        </Card>
        <Card>
          <Typography text={Signal.make("📦 Comprehensive")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text("35+ components covering forms, navigation, and layouts.")}
          </p>
        </Card>
      </div>
    </div>
    <div style="margin-top: 3rem;">
      <Typography text={Signal.make("Component Categories")} variant={Typography.H2} />
      <div style="margin-top: 1.5rem; display: flex; flex-direction: column; gap: 1rem;">
        <div>
          <Typography text={Signal.make("Form Components")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text(
              "Button, Input, Textarea, Select, Checkbox, Radio, and Label components for building forms.",
            )}
          </p>
        </div>
        <div>
          <Typography text={Signal.make("Foundation Components")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text(
              "Badge, Spinner, Separator, Kbd, and Typography for basic UI elements.",
            )}
          </p>
        </div>
        <div>
          <Typography text={Signal.make("Display Components")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text("Card, Avatar, Grid, Alert, and Progress for displaying content.")}
          </p>
        </div>
        <div>
          <Typography text={Signal.make("Navigation Components")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text(
              "Tabs, Accordion, Breadcrumb, Stepper, and Timeline for navigation patterns.",
            )}
          </p>
        </div>
        <div>
          <Typography text={Signal.make("Interactive Components")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text(
              "Modal, Tooltip, Switch, Slider, Dropdown, Toast, and Drawer for interactive UI.",
            )}
          </p>
        </div>
        <div>
          <Typography text={Signal.make("Layout Components")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text(
              "Sidebar, Topbar, and AppLayout for building complete application layouts.",
            )}
          </p>
        </div>
      </div>
    </div>
  </div>
}
