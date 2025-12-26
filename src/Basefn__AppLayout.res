%%raw(`import './Basefn__AppLayout.css'`)

open Xote

type contentWidth = FullWidth | Contained

@jsx.component
let make = (
  ~sidebar: option<Component.node>=?,
  ~topbar: option<Component.node>=?,
  ~children: Component.node,
  ~contentWidth: contentWidth=FullWidth,
  ~noPadding: bool=false,
  ~sidebarSize: option<string>=?, // "sm" | "md" | "lg"
  ~sidebarCollapsed: bool=false,
) => {
  let sidebarOpen = Signal.make(false)

  let getLayoutClass = () => {
    let hasSidebar = sidebar->Option.isSome ? " basefn-app-layout--has-sidebar" : ""
    let sidebarSizeClass = switch sidebarSize {
    | Some("sm") => " basefn-app-layout--sidebar-sm"
    | Some("lg") => " basefn-app-layout--sidebar-lg"
    | _ => ""
    }
    let collapsedClass = sidebarCollapsed ? " basefn-app-layout--sidebar-collapsed" : ""
    let sidebarOpenClass = Computed.make(() =>
      Signal.get(sidebarOpen) ? " basefn-app-layout--sidebar-open" : ""
    )
    "basefn-app-layout" ++ hasSidebar ++ sidebarSizeClass ++ collapsedClass
  }

  let getContentClass = () => {
    let widthClass = switch contentWidth {
    | FullWidth => " basefn-app-layout--full-width"
    | Contained => " basefn-app-layout--contained"
    }
    let paddingClass = noPadding ? " basefn-app-layout__content-inner--no-padding" : ""
    "basefn-app-layout__content-inner" ++ widthClass ++ paddingClass
  }

  let handleSidebarToggle = () => {
    Signal.update(sidebarOpen, prev => !prev)
  }

  <div
    class={Computed.make(() => {
      getLayoutClass() ++
      Signal.get(
        Computed.make(() => Signal.get(sidebarOpen) ? " basefn-app-layout--sidebar-open" : ""),
      )
    })}
  >
    {switch sidebar {
    | Some(sidebarContent) =>
      <>
        <div class="basefn-app-layout__sidebar"> {sidebarContent} </div>
        <div
          class="basefn-app-layout__sidebar-backdrop" onClick={_ => Signal.set(sidebarOpen, false)}
        />
      </>
    | None => <> </>
    }}
    <div class="basefn-app-layout__main-wrapper">
      {switch topbar {
      | Some(topbarContent) => <div class="basefn-app-layout__topbar"> {topbarContent} </div>
      | None => <> </>
      }}
      <main class="basefn-app-layout__content">
        <div class={getContentClass()}> {children} </div>
      </main>
    </div>
  </div>
}
