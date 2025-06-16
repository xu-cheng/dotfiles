return {
    ---@type fun(client: vim.lsp.Client, buf: integer)
    on_attach = function(client, buf)
        local file = vim.api.nvim_buf_get_name(buf)
        if vim.fs.basename(file) == ".env" then
            client.settings = vim.tbl_deep_extend("force", client.settings, {
                bashIde = {
                    shellcheckArguments = "-e SC2034",
                },
            })
        end
    end,
}
