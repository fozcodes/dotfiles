local nvim_lsp = require("lspconfig")

-- efm-langserver language modules--
-- mixformat | testing only --
-- local mixformat = {
-- formatCommand = 'mix format -',
-- formatStdin = true
-- }

-- efm-langserver languages settings --
-- local efm_languages = {
-- elixir = { mixformat }
-- }

-- Filetypes supported --
local efm_filetypes = {
    "elixir", "typescript", "typescriptreact", "javascript", "yaml", "json", "html", "scss", "css", "markdown", "lua"
}

local prettier_format_command = {formatCommand = "prettierd ${INPUT}", formatStdin = true}
local eslint_lint_command = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintIgnoreExitCode = true
}

local M = {}
M.setup = function(on_attach)
    nvim_lsp.efm.setup({
        init_options = {documentFormatting = true},
        on_attach = function(client, bufnr)
            vim.api.nvim_command("au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")

            on_attach(client, bufnr)
        end,
        filetypes = efm_filetypes,
        settings = {
            rootMarkers = {".git/"},
            lintDebounce = "0.3s",
            languages = {
                elixir = {
                    {formatCommand = "mix format - ${INPUT}", formatStdin = true}, {
                        lintCommand = "MIX_ENV=test mix credo suggest --format=flycheck --read-from-stdin ${INPUT}",
                        lintStdin = true,
                        lintIgnoreExitCode = true,
                        lintFormats = {'%f:%l:%c: %t: %m', '%f:%l: %t: %m'},
                        rootMarkers = {"mix.lock", "mix.exs"}
                    }
                },
                lua = {
                    {
                        formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=120 --break-after-table-lb",
                        formatStdin = true
                    }
                },
                typescript = {prettier_format_command, eslint_lint_command},
                javascript = {prettier_format_command, eslint_lint_command},
                typescriptreact = {prettier_format_command, eslint_lint_command},
                javascriptreact = {prettier_format_command, eslint_lint_command},
                json = {prettier_format_command},
                yaml = {prettier_format_command},
                html = {prettier_format_command},
                scss = {prettier_format_command},
                css = {prettier_format_command},
                markdown = {prettier_format_command}
            }
        }
    })
end

return M
