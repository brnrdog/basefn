open Xote
open Basefn

let examples: array<DocsExample.t> = {
  open Component
  [
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
}
