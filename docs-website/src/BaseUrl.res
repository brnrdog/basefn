type viteEnv = {"GITHUB_PAGES": bool}

@val external env: viteEnv = "import.meta.env"

let v = env["GITHUB_PAGES"] ? "/basefn/" : "/"
