local nvim_lsp = require("lspconfig")
local util = require('lspconfig/util')

local path = util.path

local function get_python_command_path(workspace, command)
    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then return path.join(vim.env.VIRTUAL_ENV, 'bin', command) end

    -- Find and use virtualenv in workspace directory.
    for _, pattern in ipairs({'*', '.*'}) do
        local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
        if match ~= '' then return path.join(path.dirname(match), 'bin', command) end
    end

    -- Fallback to system Python.
    return command
end

local function path_to_config(workspace, config_file)
    value = path.join(workspace, config_file)
    print(vim.inspect(value))
    return value
end

local M = {}
M.setup = function(on_attach, _)
    nvim_lsp.pylsp.setup {
        before_init = function(_, config)
            config.settings.plugins = {
                flake8 = {
                    executable = get_python_command_path(config.root_dir, "flake8"),
                    config = path_to_config(config.root_dir, ".flake8")
                }
            }
        end,
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
        end,
        settings = {configurationSources = {"flake8", "mypy"}}
    }

end

return M
