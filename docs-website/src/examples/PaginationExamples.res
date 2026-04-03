open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Basic Pagination",
    description: "Navigate through pages with prev/next and numbered buttons.",
    demo: {
      let page = Signal.make(1)
      <Pagination
        currentPage={page}
        totalPages={10}
        onPageChange={p => Signal.set(page, p)}
      />
    },
    code: `let page = Signal.make(1)

<Pagination
  currentPage={page}
  totalPages={10}
  onPageChange={p => Signal.set(page, p)}
/>`,
  },
  {
    title: "Few Pages",
    description: "With fewer pages, all page numbers are shown without ellipsis.",
    demo: {
      let page = Signal.make(1)
      <Pagination
        currentPage={page}
        totalPages={5}
        onPageChange={p => Signal.set(page, p)}
      />
    },
    code: `<Pagination
  currentPage={page}
  totalPages={5}
  onPageChange={p => Signal.set(page, p)}
/>`,
  },
]
