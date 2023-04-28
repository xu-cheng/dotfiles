-- setup *_host_prog
require("host_prog")

-- set mapleader/maplocalleader
vim.g.mapleader = ","
vim.g.maplocalleader = "-"

-- setup plugins
-- From https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
    install = {
        missing = true,
        colorscheme = { "catppuccin" },
    },
    checker = {
        enabled = true,
        frequency = 86400, -- check once every day
        notify = false,
    },
    change_detection = {
        enabled = true,
        notify = false,
    }
})

-- load config
require("config/options")
require("config/autocmds")
require("config/keymaps")
