return {
    -- comments
    {
        "echasnovski/mini.comment",
        version = false,
        event = "VeryLazy",
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring()
                        or vim.bo.commentstring
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
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },
            }
        end,
        main = "mini.ai",
        config = true,
        init = function()
            if not vim.g.vscode then
                ---@type table<string, string|table>
                local i = {
                    [" "] = "Whitespace",
                    ['"'] = 'Balanced "',
                    ["'"] = "Balanced '",
                    ["`"] = "Balanced `",
                    ["("] = "Balanced (",
                    [")"] = "Balanced ) including white-space",
                    [">"] = "Balanced > including white-space",
                    ["<lt>"] = "Balanced <",
                    ["]"] = "Balanced ] including white-space",
                    ["["] = "Balanced [",
                    ["}"] = "Balanced } including white-space",
                    ["{"] = "Balanced {",
                    ["?"] = "User Prompt",
                    _ = "Underscore",
                    a = "Argument",
                    b = "Balanced ), ], }",
                    c = "Class",
                    f = "Function",
                    o = "Block, conditional, loop",
                    q = "Quote `, \", '",
                    t = "Tag",
                }
                local a = vim.deepcopy(i)
                for k, v in pairs(a) do
                    ---@diagnostic disable-next-line: param-type-mismatch
                    a[k] = v:gsub(" including.*", "")
                end

                local ic = vim.deepcopy(i)
                local ac = vim.deepcopy(a)
                for key, name in pairs({ n = "Next", l = "Last" }) do
                    i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
                    a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
                end
                require("which-key").register({
                    mode = { "o", "x" },
                    i = i,
                    a = a,
                })
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
                ["Select Cursor Down"] = "<M-C-Down>",
                ["Select Cursor Up"] = "<M-C-Up>",
            }
            vim.g.VM_highlight_matches = "red"
        end,
    },
}
