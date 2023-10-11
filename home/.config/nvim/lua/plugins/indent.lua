local excluded_filetypes = {
    "",
    "TelescopePrompt",
    "TelescopeResults",
    "Trouble",
    "alpha",
    "checkhealth",
    "gitcommit",
    "help",
    "lazy",
    "lspinfo",
    "man",
    "mason",
    "neo-tree",
    "noice",
    "notify",
}

return {
    -- show indent guide
    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = not vim.g.vscode,
        event = "VeryLazy",
        opts = {
            indent = { char = "│" },
            exclude = { filetypes = excluded_filetypes },
        },
        main = "ibl",
        config = true,
    },
    -- provide text object
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = "VeryLazy",
        opts = {
            symbol = "", -- disable drawing
        },
        main = "mini.indentscope",
        config = true,
        init = function()
            local augroup = require("utils").augroup
            vim.api.nvim_create_autocmd("FileType", {
                pattern = excluded_filetypes,
                group = augroup("disable_mini_indentscope_on_filetype"),
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
}
