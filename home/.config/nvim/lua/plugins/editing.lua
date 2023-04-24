return {
    -- comments
    {
        "echasnovski/mini.comment",
        version = false,
        event = "VeryLazy",
        opts = {
            hooks = {
                pre = function()
                    require("ts_context_commentstring.internal").update_commentstring({})
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
        main = "mini.surround",
        config = true,
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
        end
    },

}
