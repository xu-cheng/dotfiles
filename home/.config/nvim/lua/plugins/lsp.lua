local not_vscode = not vim.g.vscode

return {
    -- cmp

    -- lsp

    -- mason

    -- snip

    -- diagnostics
    {
        "folke/trouble.nvim",
        enabled = not_vscode,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        cmd = { "TroubleToggle", "Trouble" },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
            { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").previous({ skip_groups = true, jump = true })
                    else
                        vim.cmd.cprev()
                    end
                end,
                desc = "Previous trouble/quickfix item",
            },
            {
                "]q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next({ skip_groups = true, jump = true })
                    else
                        vim.cmd.cnext()
                    end
                end,
                desc = "Next trouble/quickfix item",
            },
        },
        opts = function()
            local icons = require("config/icons")

            return {
                use_diagnostic_signs = true,
                signs = {
                    error = icons.diagnostics.Error,
                    warning = icons.diagnostics.Warn,
                    hint = icons.diagnostics.Hint,
                    information = icons.diagnostics.Info,
                    other = icons.diagnostics.Other,
                },
            }
        end,
        main = "trouble",
        config = true,
      },

      -- format
}
