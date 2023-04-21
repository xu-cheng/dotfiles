local map = vim.keymap.set

-- disable ex-mode
map("n", "Q", "<nop>")

-- ctrl-c as esc
map({"n", "i"}, "<C-c>", "<Esc>", {
    remap = true,
    desc = "Ctrl-c as Esc"
})

-- ctrl-s to quick save
map("n", "<C-s>", ":update<CR>", {
    desc = "Quick save"
})
map("i", "<C-s>", "<C-o>:update<CR>", {
    desc = "Quick save"
})
map("x", "<C-s>", "<C-c>:update<CR>gv", {
    desc = "Quick save"
})

-- wrapped lines goes down/up to next row, rather than next line in file.
map("", "j", "gj")
map("", "k", "gk")

-- easier horizontal scrolling
map("", "zl", "zL", {
    remap = true
})
map("", "zh", "zH", {
    remap = true
})

-- visual shifting (does not exit Visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- yank from the cursor to the end of the line, to be consistent with C and D.
map("n", "Y", "y$", {
    desc = "Yank from the cursor to the end of the line"
})

-- delete without overwriting last yank.
local delete_ops = {"d", "s", "x"}
for _, k in ipairs(delete_ops) do
    map({"n", "x"}, "<leader>" .. k, '"_' .. k, {
        desc = "Delete without overwriting last yank"
    })
    map({"n", "x"}, "<leader>" .. string.upper(k), '"_' .. string.upper(k), {
        desc = "Delete without overwriting last yank"
    })
end

-- switch to paste mode, paste text, and unset paste mode
map("", "gP", ":set paste<CR>gp<CR>:set nopaste<CR>", {
    desc = "Switch to paste mode, paste text, and unset paste mode"
})

-- visually select changed text
-- https://vim.fandom.com/wiki/Selecting_your_pasted_text
map("n", "gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"', {
    expr = true,
    desc = "Visually select changed text"
})

-- search inside visually highlighted text.
map("x", "g/", "<esc>/\\%V", {
    silent = false,
    desc = "Search inside visual selection"
})

-- clear normal/visual mode highlighting
map({"n", "x"}, "<space>", ":<c-u>noh<CR>:echo<CR>", {
    desc = "Clear normal/visual mode highlighting"
})

-- find merge conflict markers
map("", "<leader>fc", "/\\v^[<|=>]{7}( .*|$)<CR>", {
    remap = true,
    desc = "Find merge conflict markers"
})

-- add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

if not vim.g.vscode then
    -- open location list/quickfix list
    map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
    map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

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

    -- command line keymap which only expands in the first column of the command line
    -- ref: https://stackoverflow.com/a/30837427
    local function cmd_abbrev(abbrev, expansion)
        local expansion = "getcmdtype()==#':' && getcmdpos()==1 ? '" .. expansion .. "' : '" .. abbrev .. "'"
        local cmd = "cnoreabbrev " .. abbrev .. " <c-r>=(" .. expansion .. ")<cr>"
        vim.cmd(cmd)
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
        desc = "Open file in new window"
    })
    map("", "<leader>es", ":sp <C-R>=fnameescape(expand('%:h')).'/'<cr>", {
        remap = true,
        desc = "Open file in new split"
    })
    map("", "<leader>ev", ":vsp <C-R>=fnameescape(expand('%:h')).'/'<cr>", {
        remap = true,
        desc = "Open file in new vertical split"
    })
    map("", "<leader>et", ":tabe <C-R>=fnameescape(expand('%:h')).'/'<cr>", {
        remap = true,
        desc = "Open file in new tab"
    })

    -- tab management
    -- nnoremap tt :tabnew<Space>
    -- nnoremap tw :tabclose<CR>
    -- nnoremap tm :tabmove<Space>
    -- nnoremap tn :tabnext<Space>
    -- nnoremap th :tabfirst<CR>
    -- nnoremap tj :tabnext<CR>
    -- nnoremap tk :tabprev<CR>
    -- nnoremap tl :tablast<CR>

    -- windows management
    map("n", "<C-w>|", ":vsplit<CR>", {
        desc = "Split window vertically"
    })
    map("n", "<C-w>-", ":split<CR>", {
        desc = "Split window horizontally"
    })

end
