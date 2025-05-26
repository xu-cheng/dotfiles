return {
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
            procMacro = {
                enable = true,
            },
            inlayHints = {
                lifetimeElisionHints = {
                    enable = "skip_trivial",
                    useParameterNames = true,
                },
            },
            lens = {
                enable = true,
                run = { enable = true },
                debug = { enable = true },
            },
        },
    },
}
