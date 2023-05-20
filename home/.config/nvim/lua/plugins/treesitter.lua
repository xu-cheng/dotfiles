local not_vscode = not vim.g.vscode

return {
    -- nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<C-space>", desc = "Increment selection" },
            { "<bs>", desc = "Decrement selection", mode = "x" },
        },
        dependencies = {
            "HiPhish/nvim-ts-rainbow2",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-context",
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                init = function()
                    -- PERF: no need to load the plugin, we only need its queries for mini.ai
                    require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
                end
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
            context_commentstring = { enable = true, enable_autocmd = false },
            rainbow = { enable = not_vscode },
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
    },
    -- rainbow
    {
        "HiPhish/nvim-ts-rainbow2",
        lazy = true,
    },
    -- treesitter-context
    {
        "nvim-treesitter/nvim-treesitter-context",
        version = false,
        lazy = true,
        opts = {
            enable = not_vscode,
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
    }
}
