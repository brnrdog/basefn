%%raw(`import './Eita__Tabs.css'`)

open Xote

type tab = {
  value: string,
  label: string,
  content: Component.node,
  disabled: option<bool>,
}

@jsx.component
let make = (
  ~tabs: array<tab>,
  ~defaultValue: option<string>=?,
  ~activeTab: option<Signal.t<string>>=?,
) => {
  // Use provided signal or create internal one
  let internalActiveTab = Signal.make(
    switch defaultValue {
    | Some(value) => value
    | None =>
      tabs
      ->Array.get(0)
      ->Option.map(tab => tab.value)
      ->Option.getOr("")
    },
  )

  let activeTabSignal = switch activeTab {
  | Some(signal) => signal
  | None => internalActiveTab
  }

  let handleTabClick = (value: string, disabled: option<bool>) => {
    switch disabled {
    | Some(true) => ()
    | _ => Signal.set(activeTabSignal, value)
    }
  }

  let computed = Computed.make(() => {
    [
      <div class="eita-tabs">
        <div class="eita-tabs__list">
          {tabs
          ->Array.map(tab => {
            let isActive = Computed.make(() => Signal.get(activeTabSignal) == tab.value)
            let className = Computed.make(
              () => {
                let baseClass = "eita-tabs__trigger"
                let activeClass = Signal.get(isActive) ? " eita-tabs__trigger--active" : ""
                baseClass ++ activeClass
              },
            )

            <button
              key={tab.value}
              class={className}
              onClick={_ => handleTabClick(tab.value, tab.disabled)}
              disabled={tab.disabled->Option.getOr(false)}
            >
              {Component.text(tab.label)}
            </button>
          })
          ->Component.fragment}
        </div>
        <div class="eita-tabs__content">
          {Component.LazyComponent(
            () => {
              let activeValue = Signal.get(activeTabSignal)
              tabs
              ->Array.find(tab => tab.value == activeValue)
              ->Option.map(tab => tab.content)
              ->Option.getOr(<> </>)
            },
          )}
        </div>
      </div>,
    ]
  })

  Component.signalFragment(computed)
}
