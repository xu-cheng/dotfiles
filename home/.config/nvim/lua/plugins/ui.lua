local not_vscode = not vim.g.vscode

return {
    -- colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = not_vscode,
        lazy = false,    -- make sure we load this during startup
        priority = 1000, -- make sure to load this before all the other start plugins
        opts = {
            flavour = "frappe",
            show_end_of_buffer = false,
            dim_inactive = { enable = true },
            integrations = {
                alpha = true,
                barbecue = {
                    dim_dirname = true,
                    bold_basename = true,
                    dim_context = false,
                },
                blink_cmp = true,
                gitsigns = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                lsp_trouble = true,
                markdown = true,
                mason = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = {},
                        warnings = {},
                        hints = {},
                        information = {},
                    },
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                navic = {
                    enabled = true,
                    custom_bg = "NONE",
                },
                neotree = true,
                noice = true,
                notify = true,
                rainbow_delimiters = true,
                telescope = {
                    enabled = true,
                },
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
            custom_highlights = function(colors)
                return {
                    SpellBad = { sp = colors.teal, style = { "undercurl" } },
                    SpellCap = { sp = colors.teal, style = { "undercurl" } },
                    SpellLocal = { sp = colors.teal, style = { "undercurl" } },
                    SpellRare = { sp = colors.teal, style = { "undercurl" } },
                }
            end,
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    -- notify and ui
    {
        "rcarriga/nvim-notify",
        enabled = not_vscode,
        lazy = true,
        opts = {
            timeout = 2000,
            render = "compact",
            stages = "fade",
            top_down = false,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
        main = "notify",
        config = true,
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Delete all Notifications",
            },
        },
    },
    {
        "folke/noice.nvim",
        enabled = not_vscode,
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                -- override markdown rendering so that plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true,            -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
            cmdline = {
                format = {
                    search_down = { icon = " ", opts = { win_options = { winblend = 0 } } },
                    search_up = { icon = " ", opts = { win_options = { winblend = 0 } } },
                },
            },
            routes = {
                -- stop builtin spelling suggestion view, use which-key instead
                {
                    filter = { event = "msg_show", find = "Type number and <Enter> or click with the mouse" },
                    opts = { skip = true },
                },
            },
        },
        keys = {
            {
                "<S-Enter>",
                function()
                    require("noice").redirect(vim.fn.getcmdline())
                end,
                mode = "c",
                desc = "Redirect Cmdline",
            },
            {
                "<leader>snl",
                function()
                    require("noice").cmd("last")
                end,
                desc = "Noice Last Message",
            },
            {
                "<leader>snh",
                function()
                    require("noice").cmd("history")
                end,
                desc = "Noice History",
            },
            {
                "<leader>sna",
                function()
                    require("noice").cmd("all")
                end,
                desc = "Noice All",
            },
            {
                "<leader>snd",
                function()
                    require("noice").cmd("dismiss")
                end,
                desc = "Dismiss All",
            },
            {
                "<C-f>",
                function()
                    if not require("noice.lsp").scroll(4) then
                        return "<C-f>"
                    end
                end,
                silent = true,
                expr = true,
                desc = "Scroll forward",
                mode = { "i", "n", "s" },
            },
            {
                "<C-b>",
                function()
                    if not require("noice.lsp").scroll(-4) then
                        return "<C-b>"
                    end
                end,
                silent = true,
                expr = true,
                desc = "Scroll backward",
                mode = { "i", "n", "s" },
            },
        },
    },

    -- bufferline
    {
        "akinsho/bufferline.nvim",
        enabled = not_vscode,
        event = "VeryLazy",
        opts = {
            options = {
                mode = "tabs",
                always_show_bufferline = false,
                color_icons = true,
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diag)
                    local icons = require("config/icons").diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                        .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
        config = function(_, opts)
            opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
            require("bufferline").setup(opts)
        end,
    },

    -- winbar
    {
        "SmiteshP/nvim-navic",
        version = false,
        enabled = not_vscode,
        lazy = true,
        opts = function()
            return {
                highlight = true,
                depth_limit = 5,
                depth_limit_indicator = "…",
                separator = "",
                icons = require("config/icons").kinds,
                click = true,
            }
        end,
        main = "nvim-navic",
        config = true,
    },
    {
        "utilyre/barbecue.nvim",
        enabled = not_vscode,
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        event = "VeryLazy",
        opts = function()
            local kinds = vim.deepcopy(require("config/icons").kinds)
            for key, value in pairs(kinds) do
                kinds[key] = value:sub(1, -2)
            end
            return {
                attach_navic = false,
                theme = "catppuccin",
                symbols = {
                    ellipsis = "…",
                    separator = "",
                },
                kinds = kinds,
            }
        end,
        config = true,
        main = "barbecue",
    },

    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        version = false,
        enabled = not_vscode,
        event = "VeryLazy",
        dependencies = {
            "folke/noice.nvim",
        },
        opts = function()
            local icons = require("config/icons")
            local function fg(name)
                local hl = vim.api.nvim_get_hl(0, { name = name })
                local fg = hl and hl.fg
                return fg and { fg = string.format("#%06x", fg) }
            end
            local opts = {
                options = {
                    theme = "catppuccin",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "alpha" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {
                        "branch",
                        {
                            "diff",
                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },
                        },
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },
                            on_click = function(_, _, _)
                                vim.cmd("Trouble diagnostics toggle")
                            end,
                        },
                    },
                    lualine_c = {
                        {
                            "filetype",
                            icon_only = true,
                            separator = "",
                            padding = {
                                left = 1,
                                right = 0,
                            },
                        },
                        {
                            "filename",
                            path = 1,
                            symbols = { modified = "  ", readonly = "  ", unnamed = "" },
                        },
                    },
                    lualine_x = {
                        {
                            require("noice").api.status.command.get,
                            cond = require("noice").api.status.command.has,
                            color = fg("Statement"),
                        },
                        -- {
                        --     function() return "  " .. require("dap").status() end,
                        --     cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
                        --     color = fg("Debug"),
                        -- },
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            color = fg("Special"),
                            on_click = function(_, _, _)
                                require("lazy").update()
                            end,
                        },
                    },
                    lualine_y = {
                        {
                            "encoding",
                            separator = " ",
                            padding = { left = 1, right = 0 },
                            draw_empty = true,
                        },
                        { "fileformat", padding = { left = 0, right = 1 } },
                    },
                    lualine_z = {
                        { "progress", separator = " ", padding = { left = 1, right = 0 }, draw_empty = true },
                        { "location", icon = "", padding = { left = 0, right = 1 } },
                    },
                },
                extensions = {
                    "fugitive",
                    "lazy",
                    "neo-tree",
                    "quickfix",
                    "trouble",
                },
            }
            return opts
        end,
        main = "lualine",
        config = true,
    },

    -- which key
    {
        "folke/which-key.nvim",
        enabled = not_vscode,
        event = "VeryLazy",
        opts = {
            plugins = {
                spelling = {
                    enabled = true,
                    suggestions = 26,
                },
            },
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader><tab>", group = "tabs" },
                    { "<leader>a", group = "avante" },
                    { "<leader>c", group = "code" },
                    { "<leader>e", group = "open" },
                    { "<leader>f", group = "find" },
                    { "<leader>fg", group = "find git" },
                    { "<leader>g", group = "git" },
                    { "<leader>gh", group = "hunks" },
                    { "<leader>q", group = "session" },
                    { "<leader>s", group = "search" },
                    { "<leader>sn", group = "noice" },
                    { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
                    { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
                    { "[", group = "prev" },
                    { "]", group = "next" },
                    { "g", group = "goto" },
                    { "z", group = "fold" },
                    {
                        "<leader>b",
                        group = "buffer",
                        expand = function()
                            return require("which-key.extras").expand.buf()
                        end,
                    },
                    {
                        "<leader>w",
                        group = "windows",
                        proxy = "<c-w>",
                        expand = function()
                            return require("which-key.extras").expand.win()
                        end,
                    },
                },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Keymaps (which-key)",
            },
            {
                "<c-w><space>",
                function()
                    require("which-key").show({ keys = "<c-w>", loop = true })
                end,
                desc = "Window Hydra Mode (which-key)",
            },
        },
        config = true,
        main = "which-key",
    },

    -- dashboard
    {
        "goolord/alpha-nvim",
        version = false,
        enabled = not_vscode,
        event = "VimEnter",
        config = function(_, _)
            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            local dashboard = require("alpha.themes.dashboard")
            dashboard.section.buttons.val = {
                dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
                dashboard.button("i", " " .. " New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
                dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
                dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
                dashboard.button("m", "󱁤 " .. " Mason", ":Mason<CR>"),
                dashboard.button("q", " " .. " Quit", ":qa<CR>"),
            }

            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"

            require("alpha").setup(dashboard.config)

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },

    -- dependencies
    {
        "nvim-tree/nvim-web-devicons",
        version = false,
        enabled = not_vscode,
        lazy = true,
    },
    {
        "MunifTanjim/nui.nvim",
        version = false,
        enabled = not_vscode,
        lazy = true,
    },
}
