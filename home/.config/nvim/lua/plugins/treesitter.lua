local not_vscode = not vim.g.vscode

return {
    -- nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        keys = {
            { "<leader>ui", vim.show_pos, desc = "Inspect Pos", mode = "n" },
            {
                "<leader>uI",
                function()
                    vim.treesitter.inspect_tree()
                    vim.api.nvim_input("I")
                end,
                desc = "Inspect Tree",
                mode = "n",
            },
        },
    },

    -- context_commentstring used by mini.comment
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        version = false,
        lazy = true,
        opts = {
            enable_autocmd = false,
        },
        config = function(_, opts)
            vim.g.skip_ts_context_commentstring_module = true
            require("ts_context_commentstring").setup(opts)
        end,
    },
    -- rainbow
    {
        "HiPhish/rainbow-delimiters.nvim",
        enabled = not_vscode,
        version = false,
        submodules = false,
        event = { "BufReadPost", "BufNewFile" },
    },
    -- treesitter-context
    {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = not_vscode,
        branch = "master",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            mode = "topline",
        },
        main = "treesitter-context",
        config = true,
    },
    -- nvim-treesitter-textobjects used by mini.ai
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        version = false,
        branch = "main",
        lazy = true,
        init = function()
            -- PERF: no need to load the plugin, we only need its queries for mini.ai
            require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
    },
}
