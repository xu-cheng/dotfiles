-- disable editorconfig for ruby scripts without ext_name
local ext_name = vim.fn.expand("%:e")
if ext_name == "" then
    vim.b.editorconfig = false
end

vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
