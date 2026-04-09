open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Basic Combobox",
    description: "A searchable dropdown for selecting from a list of options.",
    demo: {
      let selected = Signal.make("")
      <div style="width: 280px;">
        <Combobox
          value={selected}
          placeholder="Select a framework..."
          options=[
            {value: "react", label: "React"},
            {value: "vue", label: "Vue"},
            {value: "angular", label: "Angular"},
            {value: "svelte", label: "Svelte"},
            {value: "solid", label: "SolidJS"},
            {value: "rescript", label: "ReScript + Xote"},
          ]
        />
      </div>
    },
    code: `let selected = Signal.make("")

<Combobox
  value={selected}
  placeholder="Select a framework..."
  options=[
    {value: "react", label: "React"},
    {value: "vue", label: "Vue"},
    {value: "angular", label: "Angular"},
    {value: "svelte", label: "Svelte"},
    {value: "solid", label: "SolidJS"},
    {value: "rescript", label: "ReScript + Xote"},
  ]
/>`,
  },
]
