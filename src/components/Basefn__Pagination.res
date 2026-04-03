%%raw(`import './Basefn__Pagination.css'`)

open Xote

@jsx.component
let make = (
  ~currentPage: Signal.t<int>,
  ~totalPages: int,
  ~onPageChange: int => unit,
  ~siblingCount: int=1,
) => {
  let buildRange = (start, end_) => {
    let arr = []
    for i in start to end_ {
      arr->Array.push(i)->ignore
    }
    arr
  }

  let content = Computed.make(() => {
    let current = Signal.get(currentPage)
    let hasPrev = current > 1
    let hasNext = current < totalPages

    // Build page numbers with ellipsis
    let pages: array<option<int>> = {
      let leftSibling = max(current - siblingCount, 1)
      let rightSibling = min(current + siblingCount, totalPages)
      let showLeftEllipsis = leftSibling > 2
      let showRightEllipsis = rightSibling < totalPages - 1

      let items: array<option<int>> = []

      // Always show first page
      if totalPages > 0 {
        items->Array.push(Some(1))->ignore
      }

      // Left ellipsis
      if showLeftEllipsis {
        items->Array.push(None)->ignore
      } else if leftSibling > 2 {
        // Show page 2 if no ellipsis needed
        items->Array.push(Some(2))->ignore
      }

      // Sibling pages
      let range = buildRange(max(leftSibling, 2), min(rightSibling, totalPages - 1))
      range->Array.forEach(p => items->Array.push(Some(p))->ignore)

      // Right ellipsis
      if showRightEllipsis {
        items->Array.push(None)->ignore
      } else if rightSibling < totalPages - 1 {
        items->Array.push(Some(totalPages - 1))->ignore
      }

      // Always show last page
      if totalPages > 1 {
        items->Array.push(Some(totalPages))->ignore
      }

      items
    }

    [
      <nav class="basefn-pagination" role="navigation">
        <button
          class="basefn-pagination__btn basefn-pagination__prev"
          disabled={!hasPrev}
          onClick={_ =>
            if hasPrev {
              onPageChange(current - 1)
            }}
        >
          {Component.text("\u2039")}
        </button>
        {pages
        ->Array.mapWithIndex((page, idx) => {
          switch page {
          | Some(p) => {
              let isActive = p === current
              let className =
                "basefn-pagination__btn basefn-pagination__page" ++
                (isActive ? " basefn-pagination__page--active" : "")
              <button
                key={Int.toString(idx)}
                class={className}
                onClick={_ => onPageChange(p)}
              >
                {Component.text(Int.toString(p))}
              </button>
            }
          | None =>
            <span key={Int.toString(idx)} class="basefn-pagination__ellipsis">
              {Component.text("\u2026")}
            </span>
          }
        })
        ->Component.fragment}
        <button
          class="basefn-pagination__btn basefn-pagination__next"
          disabled={!hasNext}
          onClick={_ =>
            if hasNext {
              onPageChange(current + 1)
            }}
        >
          {Component.text("\u203a")}
        </button>
      </nav>,
    ]
  })

  Component.signalFragment(content)
}
