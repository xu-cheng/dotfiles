local not_vscode = not vim.g.vscode

return {
    -- auto-completion
    {
        "saghen/blink.cmp",
        version = "1.*",
        enabled = not_vscode,
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "Kaiser-Yang/blink-cmp-dictionary",
            "Kaiser-Yang/blink-cmp-git",
            "xzbdmw/colorful-menu.nvim",
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "super-tab",
                ["<CR>"] = { "accept", "fallback" },
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            snippets = { preset = "luasnip" },
            signature = { enabled = true },
            completion = {
                ghost_text = { enabled = true, show_without_selection = true },
                list = { selection = { preselect = false, auto_insert = true } },
                documentation = { auto_show = true },
                menu = {
                    draw = {
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "git", "dictionary" },
                providers = {
                    git = {
                        name = "Git",
                        module = "blink-cmp-git",
                    },
                    dictionary = {
                        name = "Dict",
                        module = "blink-cmp-dictionary",
                        min_keyword_length = 3,
                    },
                },
            },
            cmdline = {
                keymap = {
                    preset = "inherit",
                    ["<CR>"] = { "accept_and_enter", "fallback" },
                },
                completion = {
                    ghost_text = { enabled = false },
                    list = { selection = { preselect = false, auto_insert = true } },
                    menu = { auto_show = true },
                },
            },
            fuzzy = { implementation = "prefer_rust" },
        },
        opts_extend = { "sources.default" },
        config = true,
        main = "blink.cmp",
    },

    -- snippets
    {
        "L3MON4D3/LuaSnip",
        enabled = not_vscode,
        build = "make install_jsregexp",
        lazy = true,
        dependencies = {
            {
                "rafamadriz/friendly-snippets",
                version = false,
                enabled = not_vscode,
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
        opts = {
            history = true,
            update_events = { "TextChanged", "TextChangedI" },
            delete_check_events = "TextChanged",
        },
        config = function(_, opts)
            local ls = require("luasnip")
            local s = ls.snippet
            local sn = ls.snippet_node
            local i = ls.insert_node
            local d = ls.dynamic_node

            ls.setup(opts)
            ls.add_snippets("all", {
                s({
                    trig = "uuid",
                    name = "UUID",
                    dscr = "Generate a unique UUID",
                }, {
                    d(1, function()
                        local uuid, _ = vim.fn.system("uuidgen"):gsub("\n", ""):lower()
                        return sn(nil, i(nil, uuid))
                    end),
                }),
            })
        end,
    },

    -- lsp
    {
        "neovim/nvim-lspconfig",
        enabled = not_vscode,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lspconfig = require("lspconfig")
            local lsp_defaults = lspconfig.util.default_config

            lsp_defaults.capabilities =
                vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("blink.cmp").get_lsp_capabilities())
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        version = false,
        event = "VeryLazy",
        config = true,
        main = "inc_rename",
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        config = true,
        main = "lazydev",
    },
    {
        "folke/neoconf.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
        main = "neoconf",
    },
}
