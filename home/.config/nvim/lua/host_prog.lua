if vim.uv.fs_stat("/etc/NIXOS") then
    return
end

local is_mac = vim.fn.has("mac") == 1

local function executable(prog)
    return vim.fn.executable(prog) == 1
end

-- set python interpreter
if not vim.g.python3_host_prog then
    local pyenv_path = vim.fn.stdpath("data") .. "/pynvim"
    local pyenv_bin = pyenv_path .. "/bin/python"
    if not executable(pyenv_bin) then
        local python_bin
        if executable("/opt/homebrew/opt/python/bin/python3") then
            python_bin = "/opt/homebrew/opt/python/bin/python3"
        elseif executable("/usr/bin/python3") then
            python_bin = "/usr/bin/python3"
        else
            python_bin = "python3"
        end
        vim.fn.system({ python_bin, "-m", "venv", pyenv_path })
        vim.fn.system({ pyenv_bin, "-m", "pip", "install", "pynvim" })
    end
    vim.g.python3_host_prog = pyenv_bin
end

-- set ruby interpreter
if not vim.g.ruby_host_prog then
    if is_mac then
        local brew_ruby_host = vim.fn.glob("/opt/homebrew/lib/ruby/gems/*/bin/neovim-ruby-host", true, true)
        if brew_ruby_host[1] and executable(brew_ruby_host[1]) then
            vim.g.ruby_host_prog = brew_ruby_host[1]
        end
    elseif executable("/usr/bin/neovim-ruby-host") then
        vim.g.ruby_host_prog = "/usr/bin/neovim-ruby-host"
    end
end
