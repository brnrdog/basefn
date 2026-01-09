type viteEnv = {"GITHUB_PAGES": bool}

@val external env: viteEnv = "import.meta.env"

let basePath = env["GITHUB_PAGES"] ? "basefn" : ""

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
