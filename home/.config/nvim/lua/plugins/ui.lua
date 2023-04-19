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
            integrations = {
                cmp = true,
                gitsigns = true,
                mini = true,
                noice = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                ts_rainbow2 = true,
                which_key = true,
            },
        },
        main = "catppuccin",
        config = true,
    },

    -- which key
    {
        "folke/which-key.nvim",
        enabled = not_vscode,
        main = "which-key",
        config = true,
    },
}
