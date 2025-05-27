local not_vscode = not vim.g.vscode

return {
    -- search/replacement
    {
        "MagicDuck/grug-far.nvim",
        enabled = not_vscode,
        cmd = "GrugFar",
        keys = {
            {
                "<leader>sr",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
        },
        main = "grug-far",
        config = true,
    },

    -- buffer management
    {
        "echasnovski/mini.bufremove",
        version = false,
        enabled = not_vscode,
        event = "VeryLazy",
        keys = {
            {
                "<leader>bd",
                function()
                    require("mini.bufremove").delete(0, false)
                end,
                desc = "Delete Buffer",
            },
            {
                "<leader>bD",
                function()
                    require("mini.bufremove").delete(0, true)
                end,
                desc = "Delete Buffer (Force)",
            },
        },
        main = "mini.bufremove",
        config = true,
    },

    -- git
    {
        "lewis6991/gitsigns.nvim",
        enabled = not_vscode,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")
                map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
                map("n", "<leader>gb", function()
                    gs.blame_line({ full = true })
                end, "Blame Line")
                map("n", "<leader>gD", gs.diffthis, "Diff This")

                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        },
        main = "gitsigns",
        config = true,
    },
    {
        "tpope/vim-fugitive",
        version = false,
        enabled = not_vscode,
        dependencies = {
            "tpope/vim-rhubarb",
        },
        event = { "BufReadPre", "BufNewFile" },
        init = function()
            local function map(l, r, desc)
                vim.keymap.set("n", l, r, { silent = true, desc = desc })
            end

            map("<leader>gd", ":Git diff<CR>", "Preview diff")
            map("<leader>gl", ":Git log<CR>", "Git log")
            map("<leader>gB", ":Git blame<CR>", "Git blame")
            map("<leader>gc", ":Git commit<CR>", "Git commit")
            map("<leader>gP", ":Git push<CR>", "Git push")
        end,
    },
    {
        "tpope/vim-rhubarb",
        version = false,
        enabled = not_vscode,
        event = "VeryLazy",
    },

    -- reference
    {
        "RRethy/vim-illuminate",
        version = false,
        enabled = not_vscode,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            delay = 200,
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
    },

    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        version = false,
        enabled = not_vscode,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            {
                "nvim-telescope/telescope-ui-select.nvim",
            },
        },
        cmd = { "Telescope" },
        keys = {
            {
                "<leader>,",
                "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
                desc = "Switch Buffer",
            },
            { "<leader>/", "<cmd>Telescope live_grep<cr>",       desc = "Grep" },
            { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            { "<c-p>",     "<cmd>Telescope find_files<cr>",      desc = "Find Files" },
            -- find
            {
                "<leader>fb",
                "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
                desc = "Buffers",
            },
            { "<leader>fr",  "<cmd>Telescope oldfiles<cr>",                  desc = "Recent" },
            -- git
            { "<leader>fgf", "<cmd>Telescope git_files<cr>",                 desc = "Find Files (git-files)" },
            { "<leader>fgc", "<cmd>Telescope git_commits<CR>",               desc = "Commits" },
            { "<leader>fgs", "<cmd>Telescope git_status<CR>",                desc = "Status" },
            -- search
            { '<leader>s"',  "<cmd>Telescope registers<cr>",                 desc = "Registers" },
            { "<leader>sa",  "<cmd>Telescope autocommands<cr>",              desc = "Auto Commands" },
            { "<leader>sb",  "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
            { "<leader>sc",  "<cmd>Telescope command_history<cr>",           desc = "Command History" },
            { "<leader>sC",  "<cmd>Telescope commands<cr>",                  desc = "Commands" },
            { "<leader>sd",  "<cmd>Telescope diagnostics bufnr=0<cr>",       desc = "Document Diagnostics" },
            { "<leader>sD",  "<cmd>Telescope diagnostics<cr>",               desc = "Workspace Diagnostics" },
            { "<leader>sh",  "<cmd>Telescope help_tags<cr>",                 desc = "Help Pages" },
            { "<leader>sH",  "<cmd>Telescope highlights<cr>",                desc = "Search Highlight Groups" },
            { "<leader>sj",  "<cmd>Telescope jumplist<cr>",                  desc = "Jumplist" },
            { "<leader>sk",  "<cmd>Telescope keymaps<cr>",                   desc = "Key Maps" },
            { "<leader>sl",  "<cmd>Telescope loclist<cr>",                   desc = "Location List" },
            { "<leader>sM",  "<cmd>Telescope man_pages<cr>",                 desc = "Man Pages" },
            { "<leader>sm",  "<cmd>Telescope marks<cr>",                     desc = "Jump to Mark" },
            { "<leader>so",  "<cmd>Telescope vim_options<cr>",               desc = "Options" },
            { "<leader>sR",  "<cmd>Telescope resume<cr>",                    desc = "Resume" },
            { "<leader>sq",  "<cmd>Telescope quickfix<cr>",                  desc = "Quickfix List" },
            {
                "<leader>ss",
                require("telescope.builtin").lsp_document_symbols,
                desc = "Goto Symbol",
            },
            {
                "<leader>sS",
                require("telescope.builtin").lsp_dynamic_workspace_symbols,
                desc = "Goto Symbol (Workspace)",
            },
        },
        opts = function()
            local actions = require("telescope.actions")

            local function find_command()
                if vim.fn.executable("fd") == 1 then
                    return { "fd", "--type", "f", "--hidden", "--follow", "-E", ".git", "--color", "never" }
                else
                    return { "find", ".", "-type", "f", "-not", "-path", "*/.git/*" }
                end
            end

            return {
                defaults = {
                    prompt_prefix = " ",
                    selection_caret = " ",
                    -- open files in the first window that is an actual file.
                    -- use the current window if no other window is available.
                    get_selection_window = function()
                        local wins = vim.api.nvim_list_wins()
                        table.insert(wins, 1, vim.api.nvim_get_current_win())
                        for _, win in ipairs(wins) do
                            local buf = vim.api.nvim_win_get_buf(win)
                            if vim.bo[buf].buftype == "" then
                                return win
                            end
                        end
                        return 0
                    end,
                    mappings = {
                        i = {
                            ["<C-Down>"] = actions.cycle_history_next,
                            ["<C-Up>"] = actions.cycle_history_prev,
                            ["<C-f>"] = actions.preview_scrolling_down,
                            ["<C-b>"] = actions.preview_scrolling_up,
                        },
                        n = {
                            ["q"] = actions.close,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        find_command = find_command,
                        hidden = true,
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            }
        end,
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            telescope.load_extension("ui-select")
            telescope.load_extension("fzf")
        end,
    },

    -- code action
    {
        "aznhe21/actions-preview.nvim",
        enabled = not_vscode,
        event = "LspAttach",
        main = "actions-preview",
        config = true,
    },

    -- trouble/quickfix
    {
        "folke/trouble.nvim",
        enabled = not_vscode,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        cmd = { "TroubleToggle", "Trouble" },
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols (Trouble)" },
            {
                "<leader>cS",
                "<cmd>Trouble lsp toggle<cr>",
                desc = "LSP references/definitions/... (Trouble)",
            },
            { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",  desc = "Quickfix List (Trouble)" },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").prev({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
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
                        local ok, err = pcall(vim.cmd.cnext)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Next trouble/quickfix item",
            },
        },
        opts = {
            use_diagnostic_signs = true,
            modes = {
                lsp = {
                    win = { position = "right" },
                },
            },
        },
        main = "trouble",
        config = true,
    },
    {
        "stevearc/quicker.nvim",
        enabled = not_vscode,
        event = "FileType qf",
        opts = {},
        main = "quicker",
        config = true,
    },
}
