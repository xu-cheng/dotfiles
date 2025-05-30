local not_vscode = not vim.g.vscode

return {
    -- measure startuptime
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },

    -- session management
    {
        "folke/persistence.nvim",
        version = false,
        enabled = not_vscode,
        event = "BufReadPre",
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
        keys = {
            {
                "<leader>qs",
                function()
                    require("persistence").load()
                end,
                desc = "Restore Session",
            },
            {
                "<leader>ql",
                function()
                    require("persistence").load({ last = true })
                end,
                desc = "Restore Last Session",
            },
            {
                "<leader>qd",
                function()
                    require("persistence").stop()
                end,
                desc = "Don't Save Current Session",
            },
        },
    },

    -- library used by other plugins
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },

    -- makes some plugins dot-repeatable
    {
        "tpope/vim-repeat",
        version = false,
        event = "VeryLazy",
    },

    -- a collection of small plugins
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
        },
        config = true,
        main = "snacks",
    },
}
