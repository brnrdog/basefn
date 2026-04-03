type componentInfo = {
  name: string,
  category: string,
  path: string,
}

// Raw paths without base path
let rawPaths = [
  {name: "Getting Started", category: "Learn", path: "/getting-started"},
  {name: "Accordion", category: "Components", path: "/component/accordion"},
  {name: "Alert", category: "Components", path: "/component/alert"},
  {name: "AppLayout", category: "Components", path: "/component/app-layout"},
  {name: "Avatar", category: "Components", path: "/component/avatar"},
  {name: "Badge", category: "Components", path: "/component/badge"},
  {name: "Breadcrumb", category: "Components", path: "/component/breadcrumb"},
  {name: "Button", category: "Components", path: "/component/button"},
  {name: "Card", category: "Components", path: "/component/card"},
  {name: "Checkbox", category: "Components", path: "/component/checkbox"},
  {name: "Drawer", category: "Components", path: "/component/drawer"},
  {name: "Dropdown", category: "Components", path: "/component/dropdown"},
  {name: "Grid", category: "Components", path: "/component/grid"},
  {name: "Icon", category: "Components", path: "/component/icon"},
  {name: "Input", category: "Components", path: "/component/input"},
  {name: "Kbd", category: "Components", path: "/component/kbd"},
  {name: "Label", category: "Components", path: "/component/label"},
  {name: "Modal", category: "Components", path: "/component/modal"},
  {name: "Progress", category: "Components", path: "/component/progress"},
  {name: "Radio", category: "Components", path: "/component/radio"},
  {name: "Resizable", category: "Components", path: "/component/resizable"},
  {name: "Select", category: "Components", path: "/component/select"},
  {name: "Separator", category: "Components", path: "/component/separator"},
  {name: "Sidebar", category: "Components", path: "/component/sidebar"},
  {name: "Slider", category: "Components", path: "/component/slider"},
  {name: "Spinner", category: "Components", path: "/component/spinner"},
  {name: "Spotlight", category: "Components", path: "/component/spotlight"},
  {name: "Stepper", category: "Components", path: "/component/stepper"},
  {name: "Switch", category: "Components", path: "/component/switch"},
  {name: "Tabs", category: "Components", path: "/component/tabs"},
  {name: "Textarea", category: "Components", path: "/component/textarea"},
  {name: "Timeline", category: "Components", path: "/component/timeline"},
  {name: "Toast", category: "Components", path: "/component/toast"},
  {name: "Tooltip", category: "Components", path: "/component/tooltip"},
  {name: "Topbar", category: "Components", path: "/component/topbar"},
  {name: "Typography", category: "Components", path: "/component/typography"},
]

// All components - paths are relative to Router basePath
let components: array<componentInfo> = rawPaths
