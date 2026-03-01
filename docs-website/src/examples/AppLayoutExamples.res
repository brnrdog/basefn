open Xote
open Basefn

let examples: array<DocsExample.t> = {
  open Component
  [
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
            rightContent={<Button label={Static("Get Started")} variant={Button.Primary} />}
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
}
