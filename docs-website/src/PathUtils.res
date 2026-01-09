// Base path for routing (for GitHub Pages deployment)
let basePath = BaseUrl.v

// Helper to prepend base path to a route
let toRoute = (path: string): string => {
  basePath ++ path
}

// Helper to strip base path from a pathname (for comparisons)
let stripBasePath = (pathname: string): string => {
  if basePath !== "" && pathname->String.startsWith(basePath) {
    pathname->String.sliceToEnd(~start=String.length(basePath))
  } else {
    pathname
  }
}
