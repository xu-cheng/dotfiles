local vscode = vim.g.vscode
local map = vim.keymap.set

-- disable ex-mode
map("n", "Q", "<nop>")

-- ctrl-c as esc
map({ "n", "i" }, "<C-c>", "<Esc>", {
    remap = true,
    desc = "Ctrl-c as Esc",
})

-- ctrl-s to quick save
map("n", "<C-s>", ":silent update<CR>", { silent = true, desc = "Quick save" })
map("i", "<C-s>", "<C-o>:silent update<CR>", { silent = true, desc = "Quick save" })
map("x", "<C-s>", "<C-c>:silent update<CR>gv", { silent = true, desc = "Quick save" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- move lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- easier horizontal scrolling
map("", "zl", "zL", { remap = true, desc = "Half screen to the left" })
map("", "zh", "zH", { remap = true, desc = "Half screen to the right" })

-- visual shifting (does not exit Visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- yank from the cursor to the end of the line, to be consistent with C and D.
map("n", "Y", "y$", { desc = "Yank from the cursor to the end of the line" })

-- delete without overwriting last yank.
local delete_ops = { "d", "x" }
for _, k in ipairs(delete_ops) do
    map({ "n", "x" }, "<localleader>" .. k, '"_' .. k, {
        desc = "Delete without overwriting last yank",
    })
    map({ "n", "x" }, "<localleader>" .. string.upper(k), '"_' .. string.upper(k), {
        desc = "Delete without overwriting last yank",
    })
end

-- switch to paste mode, paste text, and unset paste mode
map("", "gP", ":set paste<CR>gp<CR>:set nopaste<CR>", {
    desc = "Switch to paste mode, paste text, and unset paste mode",
})

-- visually select changed text
-- https://vim.fandom.com/wiki/Selecting_your_pasted_text
map("n", "gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"', {
    expr = true,
    desc = "Visually select changed text",
})

-- search inside visually highlighted text.
map("x", "g/", "<esc>/\\%V", {
    silent = false,
    desc = "Search inside visual selection",
})

-- clear normal/visual mode highlighting
map({ "n", "x" }, "<space>", ":<c-u>noh<CR>:echo<CR>", {
    silent = true,
    desc = "Clear normal/visual mode highlighting",
})

-- clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

if vscode then
    local vscode_neovim = require("vscode")

    map({ "n", "x" }, "<leader>ca", function()
        vscode_neovim.action("editor.action.codeAction")
    end)
    map("n", "<leader>cd", function()
        vscode_neovim.action("editor.action.marker.next")
    end)
    map("n", "<leader>cf", function()
        vscode_neovim.call("editor.action.formatDocument")
    end)
    map("x", "<leader>cf", function()
        vscode_neovim.call("editor.action.formatSelection")
    end)
    map("n", "<leader>cr", function()
        vscode_neovim.call("editor.action.rename")
    end)

    map("n", "gd", function()
        vscode_neovim.action("editor.action.revealDefinition")
    end)
    map("n", "gr", function()
        vscode_neovim.action("editor.action.referenceSearch.trigger")
    end)
    map("n", "gD", function()
        vscode_neovim.action("editor.action.revealDeclaration")
    end)
    map("n", "gI", function()
        vscode_neovim.action("editor.action.goToImplementation")
    end)
    map("n", "gT", function()
        vscode_neovim.action("editor.action.goToTypeDefinition")
    end)
    map("n", "K", function()
        vscode_neovim.action("editor.action.showHover")
    end)
    map("n", "gK", function()
        vscode_neovim.action("editor.action.triggerParameterHints")
    end)
    map("i", "<c-k>", function()
        vscode_neovim.action("editor.action.triggerParameterHints")
    end)
    map("n", "gx", function()
        vscode_neovim.action("editor.action.openLink")
    end)

    map("n", "zM", function()
        vscode_neovim.call("editor.foldAll")
    end)
    map("n", "zR", function()
        vscode_neovim.call("editor.unfoldAll")
    end)
    map("n", "zc", function()
        vscode_neovim.call("editor.fold")
    end)
    map("n", "zC", function()
        vscode_neovim.call("editor.foldRecursively")
    end)
    map("n", "zo", function()
        vscode_neovim.call("editor.unfold")
    end)
    map("n", "zO", function()
        vscode_neovim.call("editor.unfoldRecursively")
    end)
    map("n", "za", function()
        vscode_neovim.call("editor.toggleFold")
    end)
else
    -- buffers
    map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
    map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
    map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
    map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
    map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
    map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

    -- navigating in command mode
    -- http://stackoverflow.com/a/6923282
    map("c", "<C-a>", "<Home>")
    map("c", "<C-e>", "<End>")
    map("c", "<C-p>", "<Up>")
    map("c", "<C-n>", "<Down>")
    map("c", "<C-b>", "<Left>")
    map("c", "<C-f>", "<Right>")
    map("c", "<M-b>", "<S-Left>")
    map("c", "<M-f>", "<S-Right>")

    -- command line abbreviation which only expands in the beginning of the command line
    -- ref: https://stackoverflow.com/a/30837427
    local function cmd_abbrev(abbrev, expansion)
        local expansion = "<c-r>=(getcmdtype()==#':' && getcmdpos()==1 ? '"
            .. expansion
            .. "' : '"
            .. abbrev
            .. "')<cr>"
        vim.cmd({ cmd = "cnoreabbrev", args = { abbrev, expansion } })
    end

    -- shortcuts to change working directory to that of the current file
    cmd_abbrev("cwd", "lcd %:p:h")
    cmd_abbrev("cd.", "lcd %:p:h")

    -- for when you forget to sudo.. really write the file.
    cmd_abbrev("w!!", "w !sudo tee % >/dev/null")

    -- some helpers to edit mode
    -- http://vimcasts.org/e/14
    map("", "<leader>ew", ":e <C-R>=fnameescape(expand('%:h')).'/'<cr>", {
        remap = true,
        desc = "Open file in new window",
    })
    map("", "<leader>es", ":sp <C-R>=fnameescape(expand('%:h')).'/'<cr>", {
        remap = true,
        desc = "Open file in new split",
    })
    map("", "<leader>ev", ":vsp <C-R>=fnameescape(expand('%:h')).'/'<cr>", {
        remap = true,
        desc = "Open file in new vertical split",
    })
    map("", "<leader>et", ":tabe <C-R>=fnameescape(expand('%:h')).'/'<cr>", {
        remap = true,
        desc = "Open file in new tab",
    })

    -- tab management
    map("n", "<leader><tab>t", "<cmd>tabnew<cr>", { desc = "New Tab" })
    map("n", "<leader><tab>w", "<cmd>tabclose<cr>", { desc = "Close tab" })
    map("n", "<leader><tab>j", "<cmd>tabmove -1<cr>", { desc = "Move tab left" })
    map("n", "<leader><tab>k", "<cmd>tabmove +1<cr>", { desc = "Move tab right" })
    map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
    map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

    -- windows management
    map("n", "<C-w>|", "<cmd>vsplit<cr>", { desc = "Split window vertically" })
    map("n", "<C-w>-", "<cmd>split<cr>", { desc = "Split window horizontally" })

    -- move to window using the <ctrl> hjkl keys
    map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
    map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
    map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
    map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

    -- terminal keymaps
    -- https://github.com/akinsho/toggleterm.nvim#terminal-window-mappings
    map("t", "<esc>", [[<C-\><C-n>]], { desc = "Enter normal mode" })
    map("t", "jk", [[<C-\><C-n>]], { desc = "Enter normal mode" })
    map("t", "<C-h>", [[<cmd>wincmd h<cr>]], { desc = "Go to left window" })
    map("t", "<C-j>", [[<cmd>wincmd j<cr>]], { desc = "Go to left window" })
    map("t", "<C-k>", [[<cmd>wincmd k<cr>]], { desc = "Go to left window" })
    map("t", "<C-l>", [[<cmd>wincmd l<cr>]], { desc = "Go to left window" })
    map("t", "<C-w>", [[<C-\><C-n><C-w>]], { desc = "+window" })
end
