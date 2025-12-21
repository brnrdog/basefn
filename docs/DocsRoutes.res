type componentInfo = {
  name: string,
  category: string,
  path: string,
}

// All components organized by category
let components: array<componentInfo> = [
  // Form Components
  {name: "Button", category: "Form", path: "/component/button"},
  {name: "Input", category: "Form", path: "/component/input"},
  {name: "Textarea", category: "Form", path: "/component/textarea"},
  {name: "Select", category: "Form", path: "/component/select"},
  {name: "Checkbox", category: "Form", path: "/component/checkbox"},
  {name: "Radio", category: "Form", path: "/component/radio"},
  {name: "Label", category: "Form", path: "/component/label"},
  // Foundation Components
  {name: "Badge", category: "Foundation", path: "/component/badge"},
  {name: "Spinner", category: "Spinner", path: "/component/spinner"},
  {name: "Separator", category: "Foundation", path: "/component/separator"},
  {name: "Kbd", category: "Foundation", path: "/component/kbd"},
  {name: "Typography", category: "Foundation", path: "/component/typography"},
  // Display Components
  {name: "Card", category: "Display", path: "/component/card"},
  {name: "Avatar", category: "Display", path: "/component/avatar"},
  {name: "Grid", category: "Display", path: "/component/grid"},
  {name: "Alert", category: "Display", path: "/component/alert"},
  {name: "Progress", category: "Display", path: "/component/progress"},
  // Navigation Components
  {name: "Tabs", category: "Navigation", path: "/component/tabs"},
  {name: "Accordion", category: "Navigation", path: "/component/accordion"},
  {name: "Breadcrumb", category: "Navigation", path: "/component/breadcrumb"},
  {name: "Stepper", category: "Navigation", path: "/component/stepper"},
  {name: "Timeline", category: "Navigation", path: "/component/timeline"},
  // Interactive Components
  {name: "Modal", category: "Interactive", path: "/component/modal"},
  {name: "Tooltip", category: "Interactive", path: "/component/tooltip"},
  {name: "Switch", category: "Interactive", path: "/component/switch"},
  {name: "Slider", category: "Interactive", path: "/component/slider"},
  {name: "Dropdown", category: "Interactive", path: "/component/dropdown"},
  {name: "Toast", category: "Interactive", path: "/component/toast"},
  {name: "Drawer", category: "Interactive", path: "/component/drawer"},
  // Layout Components
  {name: "Sidebar", category: "Layout", path: "/component/sidebar"},
  {name: "Topbar", category: "Layout", path: "/component/topbar"},
  {name: "AppLayout", category: "Layout", path: "/component/app-layout"},
]
