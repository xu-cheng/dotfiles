local not_vscode = not vim.g.vscode

return {
    {
        "williamboman/mason.nvim",
        enabled = not_vscode,
        build = ":MasonUpdate",
        cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonLog" },
        opts = {
            ui = {
                icons = {
                    package_installed = "",
                    package_pending = "󰪠",
                    package_uninstalled = "",
                },
            },
        },
        main = "mason",
        config = true,
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        version = false,
        enabled = not_vscode,
        opts = {
            auto_update = true,
            run_on_start = true,
            debounce_hours = 168,
        },
        main = "mason-tool-installer",
        config = true,
    },
}
