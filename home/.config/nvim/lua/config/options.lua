local opt = vim.opt

-- General
opt.clipboard = {"unnamed", "unnamedplus"} -- sync with system clipboard

opt.mouse = "a" -- automatically enable mouse usage
opt.mousehide = true -- hide the mouse cursor while typing

opt.undofile = true -- enable persistent undo (see also `:h undodir`)
opt.undolevels = 10000 -- maximum number of changes that can be undone
opt.undoreload = 10000 -- maximum number lines to save for undo on a buffer reload

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Editing
opt.incsearch = true -- show search results while typing
opt.inccommand = "nosplit" -- preview incremental substitute
opt.infercase = true -- infer letter cases for a richer built-in keyword completion
opt.ignorecase = true -- ignore case when searching (use `\C` to force not doing that)
opt.smartcase = true -- don't ignore case when searching if pattern has upper case
opt.smartindent = true -- make indenting smart
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 2 -- size of an indent
opt.tabstop = 2 -- number of spaces tabs count for
opt.softtabstop = 2 -- let backspace delete indent
opt.virtualedit = "block" -- allow going past the end of line in visual block mode

if not vim.g.vscode then
    -- General
    vim.cmd("filetype plugin indent on") -- automatically detect file types

    opt.autowrite = true -- enable auto write
    opt.backup = true -- enable backup
    opt.backupdir:remove(".") -- don't create filename~ backup file in the same directory
    opt.confirm = true -- confirm to save changes before exiting modified buffer
    opt.completeopt = "menu,menuone,noselect" -- customize completions
    opt.wildmode = "list:longest,full" -- command <Tab> completion, list matches, then longest common part, then all.
    opt.shortmess:append("cCIW") -- reduce command line messages
    opt.splitkeep = "screen" -- reduce scroll during window split

    -- Editing
    opt.encoding = "utf-8" -- default file encoding
    opt.fileformats = "unix,dos" -- default file line ending
    opt.linebreak = true -- wrap long lines at 'breakat' (if 'wrap' is set)
    opt.breakindent = true -- indent wrapped lines to match line start
    opt.wrap = false -- by default, only display long lines as just one line

    opt.spell = true -- spell check on
    opt.spelllang = {"en_us"} -- spell checking language
    local spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
    if not vim.loop.fs_stat(spellfile .. ".spl") then
        vim.cmd.mkspell { spellfile, mods = { silent = true } }
    end

    -- Appearance
    vim.cmd.colorscheme "catppuccin"

    opt.termguicolors = true -- true color support
    opt.number = true -- show line numbers
    opt.signcolumn = "yes" -- Always show sign column (otherwise it will shift text)
    opt.cursorline = true -- highlight current line
    opt.list = true
    opt.listchars = "tab:› ,trail:•,extends:…,precedes:…,nbsp:␣" -- highlight problematic whitespace
    opt.pumblend = 10 -- make builtin completion menus slightly transparent
    opt.pumheight = 10 -- make popup menu smaller
    opt.winblend = 10 -- make floating windows slightly transparent
    opt.scrolljump = 5 -- lines to scroll when cursor leaves screen
    opt.scrolloff = 3 -- minimum lines to keep above and below cursor
    opt.timeout = true
    opt.timeoutlen = 300 -- used by which-key

    opt.conceallevel = 2

    -- Window/Tab Management
    opt.splitbelow = true -- horizontal splits will be below
    opt.splitright = true -- vertical splits will be to the right
    opt.winminheight = 0 -- windows can be 0 line high
    opt.winminwidth = 3 -- minimum window width
    opt.tabpagemax = 15 -- only show 15 tabs
    opt.switchbuf = "usetab,newtab" -- switching to the existing tab or creating new one
end
