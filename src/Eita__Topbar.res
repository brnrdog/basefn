%%raw(`import './Eita__Topbar.css'`)

open Xote

type theme = Light | Dark

type size = Sm | Md | Lg

type navItem = {
  label: string,
  active: bool,
  onClick: unit => unit,
}

let themeToString = (theme: theme) => {
  switch theme {
  | Light => "light"
  | Dark => "dark"
  }
}

let sizeToString = (size: size) => {
  switch size {
  | Sm => "sm"
  | Md => "md"
  | Lg => "lg"
  }
}

@jsx.component
let make = (
  ~logo: option<Component.node>=?,
  ~navItems: option<array<navItem>>=?,
  ~leftContent: option<Component.node>=?,
  ~centerContent: option<Component.node>=?,
  ~rightContent: option<Component.node>=?,
  ~onMenuClick: option<unit => unit>=?,
  ~theme: theme=Light,
  ~size: size=Md,
) => {
  let getTopbarClass = () => {
    let themeClass = theme == Dark ? " eita-topbar--dark" : ""
    let sizeClass = " eita-topbar--" ++ sizeToString(size)
    "eita-topbar" ++ themeClass ++ sizeClass
  }

  <header class={getTopbarClass()}>
    <div class="eita-topbar__left">
      {switch onMenuClick {
      | Some(handler) =>
        <button class="eita-topbar__menu-button" onClick={_ => handler()}>
          {Component.text("\u2630")}
        </button>
      | None => <> </>
      }}
      {switch logo {
      | Some(logoContent) => <div class="eita-topbar__logo"> {logoContent} </div>
      | None => <> </>
      }}
      {switch leftContent {
      | Some(content) => content
      | None => <> </>
      }}
    </div>
    <div class="eita-topbar__center">
      {switch navItems {
      | Some(items) =>
        <nav class="eita-topbar__nav">
          {items
          ->Array.mapWithIndex((item, index) => {
            let className =
              "eita-topbar__nav-item" ++ (item.active ? " eita-topbar__nav-item--active" : "")

            <button key={Int.toString(index)} class={className} onClick={_ => item.onClick()}>
              {Component.text(item.label)}
            </button>
          })
          ->Component.fragment}
        </nav>
      | None => <> </>
      }}
      {switch centerContent {
      | Some(content) => content
      | None => <> </>
      }}
    </div>
    <div class="eita-topbar__right">
      {switch rightContent {
      | Some(content) => content
      | None => <> </>
      }}
    </div>
  </header>
}
