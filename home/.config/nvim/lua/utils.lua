local Utils = {}

function Utils.augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

return Utils
