local excluded_filetypes = {
    "Trouble",
    "alpha",
    "checkhealth",
    "help",
    "lazy",
    "lspinfo",
    "man",
    "mason",
    "neo-tree",
}

return {
    -- show indent guide
    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = not vim.g.vscode,
        event = "VeryLazy",
        opts = {
            char = "│",
            filetype_exclude = excluded_filetypes,
            show_current_context = true,
        },
        main = "indent_blankline",
        config = ture,
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
        config = ture,
        init = function()
            local augroup = require("utils").augroup
            vim.api.nvim_create_autocmd("FileType", {
                pattern = excluded_filetypes,
                group = augroup("disable_mini_indentscope_on_filetype"),
                callback = function()
                    vim.b.miniindentscope_disable = true
                end
            })
        end
    },
}
