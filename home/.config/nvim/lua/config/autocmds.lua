local augroup = require("utils").augroup

-- check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    desc = "Check if we need to reload the file when it changed",
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- start builtin terminal in insert mode
vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Start builtin terminal in insert mode",
    group = augroup("terminal_insert"),
    command = "startinsert",
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
    desc = "Resize splits if window got resized",
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- automatically quit if quickfix window is the last
-- https://vim.fandom.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last
vim.api.nvim_create_autocmd("BufEnter", {
    desc = "automatically quit if quickfix window is the last",
    group = augroup("quit_on_last_quickfix"),
    callback = function()
        if vim.bo.buftype == "quickfix" and vim.fn.winbufnr(2) == -1 then
            vim.cmd("quit!")
        end
    end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Go to last loc when opening a buffer",
    group = augroup("last_loc"),
    callback = function(event)
        -- set cursor to the first line when editing a git commit message
        if vim.bo.filetype == "gitcommit" and vim.fs.basename(event.file) == "COMMIT_EDITMSG" then
            pcall(vim.api.nvim_win_set_cursor, 0, { 1, 0 })
        else
            local mark = vim.api.nvim_buf_get_mark(0, '"')
            local lcount = vim.api.nvim_buf_line_count(0)
            if mark[1] > 0 and mark[1] <= lcount then
                pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
        end
    end,
})

-- auto detect filetype if unset
vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Auto detect filetype if unset",
    group = augroup("auto_filetype_detection"),
    callback = function()
        if not vim.bo.filetype then
            vim.cmd("filetype detect")
        end
    end,
})

-- auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Auto create dir when saving a file",
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.file:match("^%w%w+://") then
            return
        end
        local file = vim.uv.fs_realpath(event.file) or event.file
        local dir = vim.fs.dirname(file)
        if not vim.uv.fs_stat(dir) then
            vim.fn.mkdir(dir, "p")
        end
    end,
})

-- automatically give executable permission to new scripts starting with a shebang (#!)
vim.api.nvim_create_autocmd({ "BufWritePre", "BufWritePost" }, {
    desc = "Auto give executable permission to new scripts with shebang",
    group = augroup("auto_executable"),
    callback = function(event)
        if event.file:match("^%w%w+://") then
            return
        end
        local file = vim.uv.fs_realpath(event.file) or event.file
        if event.event == "BufWritePre" then
            vim.b.is_new = not vim.uv.fs_stat(file)
        else -- event.event == "BufWritePost"
            if vim.b.is_new then
                local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
                if first_line:match("^#!/") and vim.fn.executable("chmod") == 1 then
                    vim.fn.system({ "chmod", "a+x", file })
                end
            end
        end
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    desc = "Close some filetypes with <q>",
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "checkhealth",
        "fugitiveblame",
        "git",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", {
            buffer = event.buf,
            silent = true,
        })
    end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
    desc = "Remove manpage from buffer list",
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
    end,
})

-- treesitter
vim.api.nvim_create_autocmd("FileType", {
    desc = "Enable treesitter",
    group = augroup("treesitter-setup"),
    callback = function(event)
        local buf = event.buf
        local filetype = event.match

        local language = vim.treesitter.language.get_lang(filetype) or filetype
        if not vim.treesitter.language.add(language) then
            return
        end

        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        if not vim.g.vscode then
            vim.treesitter.start(buf, language)
        end
    end,
})
vim.api.nvim_create_autocmd("User", {
    desc = "Add additional treesitter parsers",
    group = augroup("treesitter-additional-parsers"),
    pattern = { "TSUpdate" },
    callback = function()
        local parsers = require("nvim-treesitter.parsers")
        parsers.ghostty = {
            install_info = {
                url = "https://github.com/bezhermoso/tree-sitter-ghostty",
                queries = "queries/ghostty",
            },
        }
        parsers.gritql = {
            install_info = {
                url = "https://github.com/biomejs/tree-sitter-gritql",
                queries = "queries",
            },
        }
    end,
})
