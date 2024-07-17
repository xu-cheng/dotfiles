return {
    -- comments
    {
        "echasnovski/mini.comment",
        version = false,
        event = "VeryLazy",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
                end,
            },
        },
        main = "mini.comment",
        config = true,
    },

    -- auto pairs
    {
        "echasnovski/mini.pairs",
        version = false,
        event = "VeryLazy",
        main = "mini.pairs",
        config = true,
    },

    -- surrounding
    {
        "echasnovski/mini.surround",
        version = false,
        event = "VeryLazy",
        -- mimic tpope/vim-surround's keymap
        -- Ref: *MiniSurround-vim-surround-config*
        opts = {
            mappings = {
                add = "ys",
                delete = "ds",
                replace = "cs",

                find = "",
                find_left = "",
                highlight = "",
                update_n_lines = "",
            },
            search_method = "cover_or_next",
        },
        config = function(_, opts)
            require("mini.surround").setup(opts)
            -- remap adding surrounding to Visual mode selection
            vim.keymap.del("x", "ys")
            vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], { silent = true })
            -- make special mapping for "add surrounding for line"
            vim.keymap.set("n", "yss", "ys_", { remap = true })
        end,
    },

    -- splitjoin
    {
        "echasnovski/mini.splitjoin",
        version = false,
        event = "VeryLazy",
        opts = {
            mappings = {
                toggle = "",
                split = "gS",
                join = "gJ",
            },
        },
        main = "mini.splitjoin",
        config = true,
    },

    -- align
    {
        "echasnovski/mini.align",
        version = false,
        event = "VeryLazy",
        main = "mini.align",
        config = true,
    },

    -- a/i textobjects
    {
        "echasnovski/mini.ai",
        version = false,
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({ -- code block
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
                    d = { "%f[%d]%d+" }, -- digits
                    e = { -- Word with case
                        {
                            "%u[%l%d]+%f[^%l%d]",
                            "%f[%S][%l%d]+%f[^%l%d]",
                            "%f[%P][%l%d]+%f[^%l%d]",
                            "^[%l%d]+%f[^%l%d]",
                        },
                        "^().*()$",
                    },
                    u = ai.gen_spec.function_call(), -- u for "Usage"
                    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
                },
            }
        end,
        main = "mini.ai",
        config = true,
        init = function()
            if not vim.g.vscode then
                local objects = {
                    { " ", desc = "whitespace" },
                    { '"', desc = '" string' },
                    { "'", desc = "' string" },
                    { "(", desc = "() block" },
                    { ")", desc = "() block with ws" },
                    { "<", desc = "<> block" },
                    { ">", desc = "<> block with ws" },
                    { "?", desc = "user prompt" },
                    { "U", desc = "use/call without dot" },
                    { "[", desc = "[] block" },
                    { "]", desc = "[] block with ws" },
                    { "_", desc = "underscore" },
                    { "`", desc = "` string" },
                    { "a", desc = "argument" },
                    { "b", desc = ")]} block" },
                    { "c", desc = "class" },
                    { "d", desc = "digit(s)" },
                    { "e", desc = "CamelCase / snake_case" },
                    { "f", desc = "function" },
                    { "i", desc = "indent" },
                    { "o", desc = "block, conditional, loop" },
                    { "q", desc = "quote `\"'" },
                    { "t", desc = "tag" },
                    { "u", desc = "use/call" },
                    { "{", desc = "{} block" },
                    { "}", desc = "{} with ws" },
                }

                local ret = { mode = { "o", "x" } }
                ---@type table<string, string>
                local mappings = {
                    around = "a",
                    inside = "i",
                    around_next = "an",
                    inside_next = "in",
                    around_last = "al",
                    inside_last = "il",
                }

                for name, prefix in pairs(mappings) do
                    name = name:gsub("^around_", ""):gsub("^inside_", "")
                    ret[#ret + 1] = { prefix, group = name }
                    for _, obj in ipairs(objects) do
                        local desc = obj.desc
                        if prefix:sub(1, 1) == "i" then
                            desc = desc:gsub(" with ws", "")
                        end
                        ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
                    end
                end
                require("which-key").add(ret, { notify = false })
            end
        end,
    },

    -- jump
    {
        "echasnovski/mini.bracketed",
        version = false,
        event = "VeryLazy",
        opts = {
            -- disable unwanted mappings
            quickfix = { suffix = "" },
        },
        main = "mini.bracketed",
        config = true,
    },
    {
        "echasnovski/mini.jump",
        version = false,
        event = "VeryLazy",
        main = "mini.jump",
        config = true,
    },

    -- multi cursors
    {
        "mg979/vim-visual-multi",
        version = false,
        enabled = not vim.g.vscode,
        event = "VeryLazy",
        init = function()
            vim.g.VM_maps = {
                ["Find Under"] = "<C-d>",
                ["Find Subword Under"] = "<C-d>",
                ["Select Cursor Down"] = "<M-j>",
                ["Select Cursor Up"] = "<M-k>",
            }
            vim.g.VM_highlight_matches = "red"
        end,
    },
}
