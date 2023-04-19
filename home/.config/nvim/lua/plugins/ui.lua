local not_vscode = not vim.g.vscode

return {
    -- colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = not_vscode,
        lazy = false, -- make sure we load this during startup
        priority = 1000, -- make sure to load this before all the other start plugins
        opts = {
            flavour = "frappe",
            show_end_of_buffer = false,
            dim_inactive = { enable = true },
            ntegrations = {
                -- TODO:
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                telescope = true,
                notify = true,
                ts_rainbow2 = true,
                treesitter = true,
                treesitter_context = true,
            },
        },
        main = "catppuccin",
        config = true,
    },
}
