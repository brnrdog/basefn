%%raw(`import './Basefn__Sidebar.css'`)

open Xote

type theme = Dark | Light

type size = Sm | Md | Lg

type navItem = {
  label: string,
  icon: option<string>,
  active: bool,
  onClick: unit => unit,
}

type navSection = {
  title: option<string>,
  items: array<navItem>,
}

let themeToString = (theme: theme) => {
  switch theme {
  | Dark => "dark"
  | Light => "light"
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
  ~sections: array<navSection>,
  ~footer: option<Component.node>=?,
  ~theme: theme=Dark,
  ~size: size=Md,
  ~collapsed: bool=false,
) => {
  let getSidebarClass = () => {
    let themeClass = theme == Light ? " basefn-sidebar--light" : ""
    let sizeClass = " basefn-sidebar--" ++ sizeToString(size)
    let collapsedClass = collapsed ? " basefn-sidebar--collapsed" : ""
    "basefn-sidebar" ++ themeClass ++ sizeClass ++ collapsedClass
  }

  <div class={getSidebarClass()}>
    {switch logo {
    | Some(logoContent) =>
      <div class="basefn-sidebar__header">
        <div class="basefn-sidebar__logo"> {logoContent} </div>
      </div>
    | None => <> </>
    }}
    <nav class="basefn-sidebar__nav">
      {sections
      ->Array.map(section => {
        <div class="basefn-sidebar__section">
          {switch section.title {
          | Some(title) =>
            <div class="basefn-sidebar__section-title"> {Component.text(title)} </div>
          | None => <> </>
          }}
          {section.items
          ->Array.mapWithIndex((item, index) => {
            let itemClass =
              "basefn-sidebar__item" ++ (item.active ? " basefn-sidebar__item--active" : "")

            <div key={Int.toString(index)} class={itemClass} onClick={_ => item.onClick()}>
              {switch item.icon {
              | Some(icon) => <div class="basefn-sidebar__item-icon"> {Component.text(icon)} </div>
              | None => <> </>
              }}
              <div class="basefn-sidebar__item-text"> {Component.text(item.label)} </div>
            </div>
          })
          ->Component.fragment}
        </div>
      })
      ->Component.fragment}
    </nav>
    {switch footer {
    | Some(footerContent) => <div class="basefn-sidebar__footer"> {footerContent} </div>
    | None => <> </>
    }}
  </div>
}
