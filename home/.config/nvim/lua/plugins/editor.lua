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
        },
        cmd = { "Telescope" },
        opts = {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
            },
        },
        main = "telescope",
        config = true,
    },
}
