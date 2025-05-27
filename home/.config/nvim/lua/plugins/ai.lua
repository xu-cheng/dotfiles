local not_vscode = not vim.g.vscode

return {
    {
        "yetone/avante.nvim",
        enabled = not_vscode,
        version = false,
        build = "make",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            "MeanderingProgrammer/render-markdown.nvim",
        },
        config = true,
        main = "avante",
    },
}
