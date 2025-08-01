vim.api.nvim_create_user_command("TSInstallAll", function()
    local parsers = require("nvim-treesitter.parsers")
    local install = require("nvim-treesitter.install")
    local langs = {}
    for lang, _ in pairs(parsers) do
        table.insert(langs, lang)
    end
    install.install(langs)
end, {
    desc = "Install all tree-sitter parsers",
})
