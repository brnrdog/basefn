%%raw(`import './Eita__Breadcrumb.css'`)

open Xote

type breadcrumbItem = {
  label: string,
  href: option<string>,
  onClick: option<unit => unit>,
}

@jsx.component
let make = (~items: array<breadcrumbItem>, ~separator: string="/") => {
  <nav class="eita-breadcrumb">
    {items
    ->Array.mapWithIndex((item, index) => {
      let isLast = index == Array.length(items) - 1
      let className = isLast ? "eita-breadcrumb__link--active" : ""

      <div key={Int.toString(index)} class="eita-breadcrumb__item">
        {switch (item.href, item.onClick) {
        | (Some(href), _) =>
          <a href={href} class={"eita-breadcrumb__link " ++ className}>
            {Component.text(item.label)}
          </a>
        | (None, Some(onClick)) =>
          <button
            class={"eita-breadcrumb__link " ++ className}
            onClick={_ => onClick()}
            style="background: none; border: none; padding: 0; font: inherit;"
          >
            {Component.text(item.label)}
          </button>
        | (None, None) =>
          <span class={"eita-breadcrumb__link " ++ className}>
            {Component.text(item.label)}
          </span>
        }}
        {!isLast
          ? <span class="eita-breadcrumb__separator"> {Component.text(separator)} </span>
          : <> </>}
      </div>
    })
    ->Component.fragment}
  </nav>
}
