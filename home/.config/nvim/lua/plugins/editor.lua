local not_vscode = not vim.g.vscode

return {
    -- buffer management
    {
        "echasnovski/mini.bufremove",
        version = false,
        enabled = not_vscode,
        event = "VeryLazy",
        keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
        },
        main = "mini.bufremove",
        config = true,
    },

}
