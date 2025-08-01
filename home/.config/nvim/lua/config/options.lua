local opt = vim.opt

-- General
opt.clipboard = { "unnamed", "unnamedplus" } -- sync with system clipboard
if vim.fn.has("wsl") == 1 and not vim.env.TMUX then
    -- https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

opt.mouse = "a"        -- automatically enable mouse usage

opt.undofile = true    -- enable persistent undo (see also `:h undodir`)
opt.undolevels = 10000 -- maximum number of changes that can be undone
opt.undoreload = 10000 -- maximum number lines to save for undo on a buffer reload

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Editing
opt.incsearch = true       -- show search results while typing
opt.inccommand = "nosplit" -- preview incremental substitute
opt.infercase = true       -- infer letter cases for a richer built-in keyword completion
opt.ignorecase = true      -- ignore case when searching (use `\C` to force not doing that)
opt.smartcase = true       -- don't ignore case when searching if pattern has upper case
opt.smartindent = true     -- make indenting smart
opt.expandtab = true       -- use spaces instead of tabs
opt.shiftround = true      -- round indent
opt.shiftwidth = 4         -- size of an indent
opt.tabstop = 4            -- number of spaces tabs count for
opt.softtabstop = 4        -- let backspace delete indent
opt.virtualedit = "block"  -- allow going past the end of line in visual block mode

if vim.g.vscode then
    local vscode = require("vscode")
    vim.notify = vscode.notify
else
    -- General
    vim.cmd("filetype plugin indent on")      -- automatically detect file types

    opt.autowrite = true                      -- enable auto write
    opt.backup = true                         -- enable backup
    opt.backupdir:remove(".")                 -- don't create filename~ backup file in the same directory
    opt.updatetime = 200                      -- save swap file and trigger CursorHold
    opt.confirm = true                        -- confirm to save changes before exiting modified buffer
    opt.completeopt = "menu,menuone,noselect" -- customize completions
    opt.wildmode = "list:longest,full"        -- command <Tab> completion, list matches, then longest common part, then all.
    opt.shortmess:append("cCIW")              -- reduce command line messages
    opt.jumpoptions = "view"
    opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

    -- Editing
    opt.encoding = "utf-8"                        -- default file encoding
    opt.fileformats = "unix,dos"                  -- default file line ending
    opt.linebreak = true                          -- wrap long lines at 'breakat' (if 'wrap' is set)
    opt.breakindent = true                        -- indent wrapped lines to match line start
    opt.wrap = true                               -- by default, always wrap

    opt.spell = true                              -- spell check on
    opt.spelllang = { "en_us", "en_gb", "en_ca" } -- spell checking language
    local spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
    if not vim.uv.fs_stat(spellfile .. ".spl") then
        vim.cmd.mkspell({ spellfile, mods = { silent = true } })
    end

    -- Appearance

    opt.termguicolors = true -- true color support
    opt.smoothscroll = true
    opt.number = true        -- show line numbers
    opt.ruler = false        -- disable the default ruler
    opt.showmode = false     -- don't show mode since we have a statusline
    opt.signcolumn = "yes"   -- always show sign column (otherwise it will shift text)
    opt.cursorline = true    -- highlight current line
    opt.list = true          -- show some invisible characters
    -- highlight problematic whitespace
    opt.listchars = {
        tab = "  ›",
        trail = "•",
        extends = "…",
        precedes = "…",
        nbsp = "␣",
    }
    opt.pumblend = 10     -- make builtin completion menus slightly transparent
    opt.pumheight = 10    -- make popup menu smaller
    opt.winblend = 0      -- we don't want transparent floating windows
    opt.scrolljump = 5    -- lines to scroll when cursor leaves screen
    opt.scrolloff = 4     -- lines of context
    opt.sidescrolloff = 8 -- columns of context
    opt.timeout = true
    opt.timeoutlen = 300  -- used by which-key
    opt.laststatus = 3    -- global statusline

    opt.conceallevel = 2

    opt.fillchars = {
        foldopen = "",
        foldclose = "",
        fold = " ",
        foldsep = " ",
        diff = "╱",
        eob = " ",
    }
    opt.foldlevel = 99
    opt.foldtext = ""

    -- Window/Tab Management
    opt.splitbelow = true           -- horizontal splits will be below
    opt.splitkeep = "screen"        -- reduce scroll during window split
    opt.splitright = true           -- vertical splits will be to the right
    opt.winminheight = 0            -- windows can be 0 line high
    opt.winminwidth = 3             -- minimum window width
    opt.switchbuf = "usetab,newtab" -- switching to the existing tab or creating new one

    -- Diagnostic
    local icons = require("config/icons")
    for name, icon in pairs(icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    end
    vim.diagnostic.config({
        severity_sort = true,
        signs = false,
        underline = true,
        update_in_insert = false,
        virtual_text = false, -- we use tiny-inline-diagnostic instead
    })
end
