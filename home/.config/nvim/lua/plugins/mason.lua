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
                "rubocop",
            },
            linux_ensure_installed = {
                "basedpyright",
                "bash-language-server",
                "cspell",
                "css-lsp",
                "editorconfig-checker",
                "efm",
                "eslint-lsp",
                "html-lsp",
                "json-lsp",
                "lua-language-server",
                "markdownlint",
                "mdformat",
                "prettier",
                "ruby-lsp",
                "ruff",
                "shellcheck",
                "shfmt",
                "stylua",
                "taplo",
                "typescript-language-server",
                "yaml-language-server",
            },
            auto_update = true,
            run_on_start = true,
            debounce_hours = 168,
        },
        config = function(_, opts)
            if vim.fn.has("mac") == 0 then
                for _, entry in ipairs(opts["linux_ensure_installed"]) do
                    table.insert(opts["ensure_installed"], entry)
                end
            end
            opts["linux_ensure_installed"] = nil
            require("mason-tool-installer").setup(opts)
        end,
    },
}
