local not_vscode = not vim.g.vscode

return {
    {
        "yetone/avante.nvim",
        enabled = not_vscode,
        version = false,
        build = "make",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            { "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
            "nvim-tree/nvim-web-devicons",
            "MeanderingProgrammer/render-markdown.nvim",
        },
        config = true,
        main = "avante",
    },
}
