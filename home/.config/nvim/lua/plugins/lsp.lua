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
                ghost_text = { enabled = true },
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
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
            {
                "folke/neoconf.nvim",
                config = true,
                main = "neoconf",
            },
            {
                "folke/lazydev.nvim",
                ft = "lua",
                config = true,
                main = "lazydev",
            },
            {
                "smjonas/inc-rename.nvim",
                version = false,
                config = true,
                main = "inc_rename",
            },
        },
        opts = {
            servers = {
                bashls = {},
                cssls = {},
                efm = {},
                eslint = {},
                html = {},
                jsonls = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            ["hint.enable"] = true,
                            ["hint.arrayIndex"] = "Disable",
                        },
                    },
                },
                pyright = {},
                rust_analyzer = {},
                solargraph = {},
                taplo = {},
            },
        },
        config = function(_, opts)
            local utils = require("utils")
            local navic = require("nvim-navic")
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local lsp_defaults = lspconfig.util.default_config

            lsp_defaults.capabilities =
                vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("blink.cmp").get_lsp_capabilities())

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                group = utils.augroup("UserLspConfig"),
                callback = function(event)
                    local buffer = event.buf
                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    if client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, buffer)
                    end

                    if client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
                    end

                    local function map(m, lhs, rhs, desc, opts)
                        local opts = opts or {}
                        if opts.has then
                            if not client.server_capabilities[opts.has .. "Provider"] then
                                return
                            end
                            opts.has = nil
                        end
                        opts.buffer = buffer
                        opts.silent = opts.silent ~= false
                        opts.desc = desc
                        vim.keymap.set(m, lhs, rhs, opts)
                    end

                    -- LSP actions
                    map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action", { has = "codeAction" })
                    map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
                    map(
                        { "n", "x" },
                        "<leader>cf",
                        "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
                        "Format",
                        { has = "documentFormatting" }
                    )
                    map("n", "<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
                    map("n", "<leader>cr", function()
                        return ":IncRename " .. vim.fn.expand("<cword>")
                    end, "Rename", { expr = true, has = "rename" })

                    map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", "Goto Definition", { has = "definition" })
                    map("n", "gr", "<cmd>Telescope lsp_references<cr>", "References")
                    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
                    map("n", "gI", "<cmd>Telescope lsp_implementations<cr>", "Goto Implementation")
                    map("n", "gT", "<cmd>Telescope lsp_type_definitions<cr>", "Goto Type Definition")
                    map("n", "K", vim.lsp.buf.hover, "Hover")
                    map("n", "gK", vim.lsp.buf.signature_help, "Signature Help", { has = "signatureHelp" })
                    map("i", "<c-k>", vim.lsp.buf.signature_help, "Signature Help", { has = "signatureHelp" })
                end,
            })

            for server_name, server_opts in pairs(opts.servers) do
                lspconfig[server_name].setup(server_opts)
            end
            local servers = mason_lspconfig.get_installed_servers()
            for _, server_name in ipairs(servers) do
                if opts.servers[server_name] == nil then
                    lspconfig[server_name].setup({})
                end
            end
        end,
    },
}
