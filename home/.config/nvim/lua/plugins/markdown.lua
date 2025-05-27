local not_vscode = not vim.g.vscode

return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        enabled = not_vscode,
        ft = { "markdown", "Avante" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ---@module "render-markdown"
        ---@type render.md.UserConfig
        opts = {
            completions = { lsp = { enabled = true } },
            file_types = { "markdown", "Avante" },
        },
        config = true,
        main = "render-markdown",
    },
}
