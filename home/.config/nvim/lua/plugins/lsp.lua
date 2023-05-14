local not_vscode = not vim.g.vscode

return {
    -- auto-completion
    {
        "hrsh7th/nvim-cmp",
        version = false,
        enabled = not_vscode,
        event = "InsertEnter",
        dependencies = {
            {
                "hrsh7th/cmp-nvim-lsp",
                version = false,
                enabled = not_vscode,
            },
            {
                "hrsh7th/cmp-buffer",
                version = false,
                enabled = not_vscode,
            },
            {
                "hrsh7th/cmp-path",
                version = false,
                enabled = not_vscode,
            },
            {
                "saadparwaiz1/cmp_luasnip",
                version = false,
                enabled = not_vscode,
            },
            {
                "petertriho/cmp-git",
                version = false,
                enabled = not_vscode,
                dependencies = { "nvim-lua/plenary.nvim" },
                main = "cmp_git",
                config = true,
            },
            {
                "octaltree/cmp-look",
                version = false,
                enabled = not_vscode,
            },
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ select = true })
                        else
                            fallback()
                        end
                    end,
                    ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    -- Ref: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
                    -- Remove using tab to trigger auto-complete
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    {
                        name = "look",
                        keyword_length = 2,
                        option = {
                            convert_case = true,
                            loud = true,
                        }
                    },
                }),
                formatting = {
                    format = function(_, item)
                        local icons = require("config/icons").kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        return item
                    end,
                },
                experimental = {
                    ghost_text = { hl_group = "LspCodeLens" },
                },
            })

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                    {
                        name = "look",
                        keyword_length = 2,
                        option = {
                            convert_case = true,
                            loud = true,
                        }
                    },
                })
            })
        end,
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
            }
        },
        opts = {
            history = true,
            update_events = { "TextChanged", "TextChangedI" },
            delete_check_events = "TextChanged",
        },
        main = "luasnip",
        config = true,
    },

    -- lsp
    {
        "neovim/nvim-lspconfig",
        enabled = not_vscode,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        enabled = not_vscode,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "davidmh/cspell.nvim",
            "williamboman/mason.nvim",
            "nvim-lua/plenary.nvim",
        },
        opts = function()
            local null_ls = require("null-ls")
            local cspell = require("cspell")
            return {
                sources = {
                    cspell.code_actions,
                    cspell.diagnostics.with({
                        diagnostics_postprocess = function(diagnostic)
                            diagnostic.severity = vim.diagnostic.severity.HINT
                        end,
                    }),
                    null_ls.builtins.code_actions.shellcheck,
                    null_ls.builtins.diagnostics.chktex,
                    null_ls.builtins.diagnostics.dotenv_linter,
                    null_ls.builtins.diagnostics.editorconfig_checker.with({
                        diagnostics_postprocess = function(diagnostic)
                            diagnostic.severity = vim.diagnostic.severity.INFO
                        end,
                    }),
                    null_ls.builtins.diagnostics.markdownlint,
                    null_ls.builtins.diagnostics.rubocop,
                    null_ls.builtins.diagnostics.ruff,
                    null_ls.builtins.diagnostics.shellcheck,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.clang_format,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.jq,
                    null_ls.builtins.formatting.latexindent,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.rubocop,
                    null_ls.builtins.formatting.ruff,
                    null_ls.builtins.formatting.rustfmt,
                    null_ls.builtins.formatting.shfmt,
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.taplo,
                    null_ls.builtins.formatting.terraform_fmt,
                    null_ls.builtins.hover.printenv,
                },
            }
        end,
        main = "null-ls",
        config = true,
    },

    {
        "folke/trouble.nvim",
        enabled = not_vscode,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        cmd = { "TroubleToggle", "Trouble" },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
            { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").previous({ skip_groups = true, jump = true })
                    else
                        vim.cmd.cprev()
                    end
                end,
                desc = "Previous trouble/quickfix item",
            },
            {
                "]q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next({ skip_groups = true, jump = true })
                    else
                        vim.cmd.cnext()
                    end
                end,
                desc = "Next trouble/quickfix item",
            },
        },
        opts = {
            use_diagnostic_signs = true,
        },
        main = "trouble",
        config = true,
      },
}
