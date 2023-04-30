return {
     -- measure startuptime
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },

    -- library used by other plugins
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },

    -- makes some plugins dot-repeatable like leap
    {
        "tpope/vim-repeat",
        version = false,
        event = "VeryLazy"
    },
}
