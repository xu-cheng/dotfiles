local not_vscode = not vim.g.vscode

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        enable = not_vscode,
        ---@module "snacks"
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            input = { enabled = true },
            explorer = { replace_netrw = true },
            picker = {
                sources = {
                    explorer = { hidden = true },
                },
            },
        },
        config = true,
        main = "snacks",
    },
}
