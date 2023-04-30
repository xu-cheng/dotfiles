local Utils = {}

function Utils.augroup (name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

function Utils.fg (name)
    local hl = vim.api.nvim_get_hl(0, { name = name })
    local fg = hl and hl.fg
    return fg and string.format("#%06x", fg)
end

return Utils
