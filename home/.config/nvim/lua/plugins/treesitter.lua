local not_vscode = not vim.g.vscode

return {
    -- nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        cmd = { "TSInstall", "TSUpdate", "TSBufEnable", "TSBufDisable", "TSBufToggle", "TSModuleInfo" },
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<C-space>", desc = "Increment selection" },
            { "<bs>",      desc = "Decrement selection", mode = "x" },
        },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                init = function()
                    -- PERF: no need to load the plugin, we only need its queries for mini.ai
                    require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
                end,
            },
        },
        opts = {
            highlight = {
                enable = not_vscode,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            ensure_installed = {
                "bash",
                "bibtex",
                "c",
                "cmake",
                "comment",
                "cpp",
                "css",
                "diff",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "html",
                "javascript",
                "json",
                "jsonc",
                "latex",
                "lua",
                "luadoc",
                "luap",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "ruby",
                "rust",
                "sql",
                "terraform",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            },
            auto_install = true,
        },
        main = "nvim-treesitter.configs",
        config = true,
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
        lazy = true,
    },
}
