open Xote
open Basefn

let examples: array<DocsExample.t> = {
  open Component
  [
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
              <Button variant={Button.Ghost}> {text("Login")} </Button>
              <Button variant={Button.Primary}> {text("Sign Up")} </Button>
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
}
