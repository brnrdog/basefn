open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Basic Breadcrumb",
    description: "Navigation breadcrumbs showing current location.",
    demo: <Breadcrumb
      items={[
        {label: "Home", href: Some("/"), onClick: None},
        {label: "Products", href: Some("/products"), onClick: None},
        {label: "Electronics", href: Some("/products/electronics"), onClick: None},
        {label: "Laptop", href: None, onClick: None},
      ]}
    />,
    code: `<Breadcrumb
  items={[
    {label: "Home", href: Some("/"), onClick: None},
    {label: "Products", href: Some("/products"), onClick: None},
    {label: "Laptop", href: None, onClick: None},
  ]}
/>`,
  },
]
