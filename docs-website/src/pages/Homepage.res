open Xote
open Xote.Component
open Basefn

%%raw(`import './Homepage.css'`)

@jsx.component
let make = () => {
  <div style="max-width: 800px; padding: 3rem 0; margin: auto;">
    <div style="text-align: center; margin-bottom: 3rem; max-width: 72ch; margin: auto;">
      <Typography
        text={ReactiveProp.Static("base")} variant={Typography.Unstyled} class="logo logo-a"
      />
      <Typography
        text={ReactiveProp.Static("fn")} variant={Typography.Unstyled} class="logo logo-b"
      />
      <Typography
        text={ReactiveProp.Static(
          "A modern user interface component library written in ReScript for Xote applications.",
        )}
        variant={Lead}
      />
      <div style="margin-top: 2rem; display: flex; gap: 1rem; justify-content: center;">
        {Router.link(
          ~to="/component/button",
          ~children=[<Button> {text("Get Started")} </Button>],
          (),
        )}
        <a
          href="https://github.com/yourusername/basefn-ui"
          target="_blank"
          style="text-decoration: none;"
        >
          <Button variant={Ghost}> {text("View on GitHub")} </Button>
        </a>
      </div>
    </div>
    <div style="margin-top: 5rem;">
      <Typography text={ReactiveProp.Static("Features")} variant={Typography.H2} />
      <div
        style="margin-top: 1.5rem; display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem;"
      >
        <Card>
          <Typography text={ReactiveProp.Static("🎨 Modern Design")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text("Clean and beautiful components with thoughtful design patterns.")}
          </p>
        </Card>
        <Card>
          <Typography text={ReactiveProp.Static("⚡ Built with Xote")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text("Leverages Xote's fine-grained reactivity with Signals.")}
          </p>
        </Card>
        <Card>
          <Typography text={ReactiveProp.Static("🔒 Type-Safe")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text("Written in ReScript for complete type safety.")}
          </p>
        </Card>
        <Card>
          <Typography text={ReactiveProp.Static("📦 Comprehensive")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text("35+ components covering forms, navigation, and layouts.")}
          </p>
        </Card>
      </div>
    </div>
    <div style="margin-top: 3rem;">
      <Typography text={ReactiveProp.Static("Component Categories")} variant={Typography.H2} />
      <div style="margin-top: 1.5rem; display: flex; flex-direction: column; gap: 1rem;">
        <div>
          <Typography text={ReactiveProp.Static("Form Components")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text(
              "Button, Input, Textarea, Select, Checkbox, Radio, and Label components for building forms.",
            )}
          </p>
        </div>
        <div>
          <Typography text={ReactiveProp.Static("Foundation Components")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text(
              "Badge, Spinner, Separator, Kbd, and Typography for basic UI elements.",
            )}
          </p>
        </div>
        <div>
          <Typography text={ReactiveProp.Static("Display Components")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text("Card, Avatar, Grid, Alert, and Progress for displaying content.")}
          </p>
        </div>
        <div>
          <Typography text={ReactiveProp.Static("Navigation Components")} variant={Typography.H5} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text(
              "Tabs, Accordion, Breadcrumb, Stepper, and Timeline for navigation patterns.",
            )}
          </p>
        </div>
        <div>
          <Typography
            text={ReactiveProp.Static("Interactive Components")} variant={Typography.H5}
          />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text(
              "Modal, Tooltip, Switch, Slider, Dropdown, Toast, and Drawer for interactive UI.",
            )}
          </p>
        </div>
        <div>
          <Typography text={ReactiveProp.Static("Layout Components")} variant={Typography.H5} />
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
