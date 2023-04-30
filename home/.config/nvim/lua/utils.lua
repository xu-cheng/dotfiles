local Utils = {}

Utils.augroup = function(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

Utils.fg = function(name)
    local hl = vim.api.nvim_get_hl(0, { name = name })
    local fg = hl and hl.fg
    return fg and string.format("#%06x", fg)
end

return Utils
