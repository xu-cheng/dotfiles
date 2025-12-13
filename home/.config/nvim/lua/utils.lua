local Utils = {}

function Utils.augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

function Utils.project_root()
    local efm_root = nil

    -- 1. Try to get root from Active LSP
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    for _, client in pairs(clients) do
        if client.config.root_dir then
            if client.config.name == "efm" then
                efm_root = client.config.root_dir
            else
                return client.config.root_dir
            end
        end
    end

    -- 2. Fallback to finding .git directory
    local git_root = vim.fs.find(".git", {
        path = vim.api.nvim_buf_get_name(0),
        upward = true,
        type = "directory",
    })[1]

    if git_root then
        return vim.fn.fnamemodify(git_root, ":h")
    end

    -- 3. If no standard LSP and no .git patterns, use EFM root if available
    if efm_root then
        return efm_root
    end

    -- 4. Last resort: Current Working Directory
    return vim.loop.cwd()
end

return Utils
