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

    -- notify and ui
    {
        "rcarriga/nvim-notify",
        enabled = not_vscode,
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
        main = "notify",
        config = true,
        keys = {
            {
                "<leader>un",
                function() require("notify").dismiss({ silent = true, pending = true }) end,
                desc = "Delete all Notifications",
            },
        },
    },
    {
        "folke/noice.nvim",
        enabled = not_vscode,
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
            cmdline = {
                format = {
                    search_down = { icon = " " },
                    search_up = { icon = " " },
                },
            },
        },
        keys = {
            { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
            { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
            { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
            {
                "<C-f>",
                function()
                    if not require("noice.lsp").scroll(4) then
                        return "<C-f>"
                    end
                end,
                silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"}
            },
            {
                "<C-b>",
                function()
                    if not require("noice.lsp").scroll(-4) then
                        return "<C-b>"
                    end
                end,
                silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}
            },
        },
    },

    -- which key
    {
        "folke/which-key.nvim",
        enabled = not_vscode,
        main = "which-key",
        config = true,
    },

    -- dependencies
    {
        "nvim-tree/nvim-web-devicons",
        version = false,
        enabled = not_vscode,
        lazy = true,
    },
    {
        "MunifTanjim/nui.nvim",
        version = false,
        enabled = not_vscode,
        lazy = true
    },
}
