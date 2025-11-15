return {
    cmd = { 'ruff', 'server'  },
    filetypes = { 'python' },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
    init_options = {
        settings = {
            codeAction = {
                disableRuleComment = { enable = true },
                showDocumentation = { enable = true }
            },
            lint = { enable = true }
        }
    }
}
