%%raw(`import './Eita__AppLayout.css'`)

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
    let hasSidebar = sidebar->Option.isSome ? " eita-app-layout--has-sidebar" : ""
    let sidebarSizeClass = switch sidebarSize {
    | Some("sm") => " eita-app-layout--sidebar-sm"
    | Some("lg") => " eita-app-layout--sidebar-lg"
    | _ => ""
    }
    let collapsedClass = sidebarCollapsed ? " eita-app-layout--sidebar-collapsed" : ""
    let sidebarOpenClass = Computed.make(() =>
      Signal.get(sidebarOpen) ? " eita-app-layout--sidebar-open" : ""
    )
    "eita-app-layout" ++ hasSidebar ++ sidebarSizeClass ++ collapsedClass
  }

  let getContentClass = () => {
    let widthClass = switch contentWidth {
    | FullWidth => " eita-app-layout--full-width"
    | Contained => " eita-app-layout--contained"
    }
    let paddingClass = noPadding ? " eita-app-layout__content-inner--no-padding" : ""
    "eita-app-layout__content-inner" ++ widthClass ++ paddingClass
  }

  let handleSidebarToggle = () => {
    Signal.update(sidebarOpen, prev => !prev)
  }

  <div
    class={Computed.make(() => {
      getLayoutClass() ++ Signal.get(Computed.make(() => Signal.get(sidebarOpen) ? " eita-app-layout--sidebar-open" : ""))
    })}
  >
    {switch sidebar {
    | Some(sidebarContent) =>
      <>
        <div class="eita-app-layout__sidebar"> {sidebarContent} </div>
        <div
          class="eita-app-layout__sidebar-backdrop"
          onClick={_ => Signal.set(sidebarOpen, false)}
        />
      </>
    | None => <> </>
    }}
    <div class="eita-app-layout__main-wrapper">
      {switch topbar {
      | Some(topbarContent) => <div class="eita-app-layout__topbar"> {topbarContent} </div>
      | None => <> </>
      }}
      <main class="eita-app-layout__content">
        <div class={getContentClass()}> {children} </div>
      </main>
    </div>
  </div>
}
