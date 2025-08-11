local not_vscode = not vim.g.vscode

return {
    -- auto-completion
    {
        "saghen/blink.cmp",
        version = "1.*",
        enabled = not_vscode,
        event = "InsertEnter",
        dependencies = {
            "Kaiser-Yang/blink-cmp-avante",
            "Kaiser-Yang/blink-cmp-git",
            "L3MON4D3/LuaSnip",
            "xzbdmw/colorful-menu.nvim",
            {
                "Kaiser-Yang/blink-cmp-dictionary",
                dependencies = { "nvim-lua/plenary.nvim" },
            },
        },
        ---@module "blink.cmp"
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
                default = { "avante", "lsp", "lazydev", "path", "snippets", "buffer", "git", "dictionary" },
                providers = {
                    avante = {
                        name = "Avante",
                        module = "blink-cmp-avante",
                    },
                    dictionary = {
                        name = "Dict",
                        module = "blink-cmp-dictionary",
                        min_keyword_length = 3,
                        opts = {
                            dictionary_files = {
                                "/usr/share/dict/words",
                                vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
                            },
                        },
                    },
                    git = {
                        name = "Git",
                        module = "blink-cmp-git",
                        -- only enable this source when filetype is gitcommit, markdown, or 'octo'
                        enabled = function()
                            return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
                        end,
                    },
                    lazydev = {
                        name = "Lazydev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    path = {
                        opts = {
                            show_hidden_files_by_default = true,
                        },
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
        enabled = not_vscode,
        event = "VeryLazy",
        config = true,
        main = "inc_rename",
    },
    {
        "rachartier/tiny-code-action.nvim",
        enabled = not_vscode,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        event = "LspAttach",
        main = "tiny-code-action",
        config = true,
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        priority = 1000,
        event = "LspAttach",
        opts = {
            preset = "modern",
            options = {
                show_source = { enabled = true, if_many = true },
                multilines = { enabled = true, always_show = true },
                set_arrow_to_diag_color = true,
                use_icons_from_diagnostic = true,
                severity = {
                    vim.diagnostic.severity.ERROR,
                    vim.diagnostic.severity.WARN,
                },
            },
        },
        main = "tiny-inline-diagnostic",
        config = true,
    },
    {
        "folke/lazydev.nvim",
        enabled = not_vscode,
        ft = "lua",
        config = true,
        main = "lazydev",
    },
    {
        "folke/neoconf.nvim",
        enabled = not_vscode,
        event = { "BufReadPre", "BufNewFile" },
        config = true,
        main = "neoconf",
    },
    {
        "b0o/schemastore.nvim",
        version = false,
        enabled = not_vscode,
        lazy = true,
    },
    {
        "icholy/lsplinks.nvim",
        enabled = not_vscode,
        lazy = true,
        config = true,
        main = "lsplinks",
    },
}
