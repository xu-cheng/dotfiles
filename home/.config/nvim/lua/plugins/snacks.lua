local not_vscode = not vim.g.vscode
local Utils = require("utils");

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        enable = not_vscode,
        keys = {
            {
                "<leader>fe",
                function()
                    Snacks.explorer({ cwd = Utils.project_root() })
                end,
                desc = "Open Explorer",
            },
            {
                "<leader>fE",
                function()
                    Snacks.explorer()
                end,
                desc = "Open Explorer (cwd)",
            },
        },
        ---@module "snacks"
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            input = { enabled = true },
            explorer = { replace_netrw = true },
            picker = {
                sources = {
                    explorer = { hidden = true },
                    files = { hidden = true },
                },
            },
        },
        config = true,
        main = "snacks",
    },
}
