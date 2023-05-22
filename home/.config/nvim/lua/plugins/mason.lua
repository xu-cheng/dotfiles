local not_vscode = not vim.g.vscode

return {
    {
        "williamboman/mason.nvim",
        enabled = not_vscode,
        build = ":MasonUpdate",
        cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonLog" },
        opts = {
            ui = {
                icons = {
                    package_installed = "",
                    package_pending = "󰪠",
                    package_uninstalled = "",
                },
            },
        },
        main = "mason",
        config = true,
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        version = false,
        enabled = not_vscode,
        opts = {
            ensure_installed = {
                "bash-language-server",
                "black",
                "cspell",
                "editorconfig-checker",
                "isort",
                "json-lsp",
                "lua-language-server",
                "markdownlint",
                "prettier",
                "pyright",
                "rubocop",
                "ruff",
                "rust-analyzer",
                "shellcheck",
                "shfmt",
                "solargraph",
                "stylua",
                "taplo",
            },
            auto_update = true,
            run_on_start = true,
        },
        main = "mason-tool-installer",
        config = true,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        enabled = not_vscode,
        lazy = true,
        main = "mason-lspconfig",
        config = true,
    },
}
