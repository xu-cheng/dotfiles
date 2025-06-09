if vim.g.vscode then
    return
end

local utils = require("utils")

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    group = utils.augroup("UserLspConfig"),
    callback = function(event)
        local buffer = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client.server_capabilities.documentSymbolProvider then
            local navic = require("nvim-navic")
            navic.attach(client, buffer)
        end

        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
        end

        if client.server_capabilities.codeLensProvider then
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = buffer,
                callback = vim.lsp.codelens.refresh,
            })
        end

        local function map(m, lhs, rhs, desc, opts)
            local opts = opts or {}
            if opts.has then
                if not client.server_capabilities[opts.has .. "Provider"] then
                    return
                end
                opts.has = nil
            end
            opts.buffer = buffer
            opts.desc = desc
            vim.keymap.set(m, lhs, rhs, opts)
        end

        map("n", "<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
        map({ "n", "x" }, "<leader>ca", require("actions-preview").code_actions, "Code Action", { has = "codeAction" })
        map({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run, "Run Codelens", { has = "codeLens" })
        map("n", "<leader>cC", vim.lsp.codelens.refresh, "Rerfesh & Display Codelens", { has = "codeLens" })
        map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
        map(
            { "n", "x" },
            "<leader>cf",
            "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
            "Format",
            { has = "documentFormatting" }
        )
        map("n", "<leader>cr", function()
            return ":IncRename " .. vim.fn.expand("<cword>")
        end, "Rename", { expr = true, has = "rename" })

        map("n", "gd", function()
            require("telescope.builtin").lsp_definitions({ reuse_win = true })
        end, "Goto Definition", { has = "definition" })
        map("n", "gr", "<cmd>Telescope lsp_references<cr>", "References", { nowait = true })
        map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("n", "gI", function()
            require("telescope.builtin").lsp_implementations({ reuse_win = true })
        end, "Goto Implementation")
        map("n", "gT", function()
            require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
        end, "Goto Type Definition")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "gK", vim.lsp.buf.signature_help, "Signature Help", { has = "signatureHelp" })
        map("i", "<c-k>", vim.lsp.buf.signature_help, "Signature Help", { has = "signatureHelp" })
    end,
})

vim.lsp.enable("basedpyright")
vim.lsp.enable("bashls")
vim.lsp.enable("cssls")
vim.lsp.enable("efm")
vim.lsp.enable("eslint")
vim.lsp.enable("html")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ruff")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("solargraph")
vim.lsp.enable("taplo")
vim.lsp.enable("yamlls")
