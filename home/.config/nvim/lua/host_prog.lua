local is_mac = vim.fn.has("mac") == 1
local function executable(prog)
    return vim.fn.executable(prog) == 1
end

-- get homebrew prefix
local brew_prefix
if is_mac then
    if executable("/opt/homebrew/bin/brew") then
        brew_prefix = "/opt/homebrew"
    else
        brew_prefix = "/usr/local"
    end
end

-- set python interpreter
if not vim.g.python3_host_prog then
    local pyenv_path = vim.fn.stdpath("data") .. "/pynvim"
    local pyenv_bin = pyenv_path .. "/bin/python"
    if not executable(pyenv_bin) then
        local python_bin
        if brew_prefix and executable(brew_prefix .. "/opt/python/bin/python3") then
            python_bin = brew_prefix .. "/opt/python/bin/python3"
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
        local brew_ruby_host = vim.fn.glob(brew_prefix .. "/lib/ruby/gems/*/bin/neovim-ruby-host", true, true)
        if brew_ruby_host[1] and executable(brew_ruby_host[1]) then
            vim.g.ruby_host_prog = brew_ruby_host[1]
        end
    elseif brew_prefix and executable(brew_prefix .. "/bin/neovim-ruby-host") then
        vim.g.ruby_host_prog = brew_prefix .. "/bin/neovim-ruby-host"
    elseif executable("/usr/bin/neovim-ruby-host") then
        vim.g.ruby_host_prog = "/usr/bin/neovim-ruby-host"
    end
end
