local nvim_lsp = require("lspconfig")

-- efm-langserver language modules--

-- Filetypes supported --
local efm_filetypes = {
    "elixir", "typescript", "typescriptreact", "javascript", "yaml", "json", "html", "scss", "css",
    "markdown", "lua", "graphql", "python"
}

local prettier_format_command = {formatCommand = "prettierd ${INPUT}", formatStdin = true}
local eslint_lint_command = {
    lintCommand = "eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintIgnoreExitCode = true
}

local M = {}
M.setup = function(on_attach)
    nvim_lsp.efm.setup({
        init_options = {documentFormatting = true, codeAction = true},
        on_attach = function(client, bufnr)
            if vim.bo.filetype == "elixir" then
                client.resolved_capabilities.document_formatting = false
                vim.api.nvim_command(
                    "au BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync({}, 1500)")
            else
                vim.api.nvim_command(
                    "au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync({}, 1500)")

            end

            on_attach(client, bufnr)
        end,
        filetypes = efm_filetypes,
        settings = {
            rootMarkers = {".git/"},
            lintDebounce = "0.3s",
            languages = {
                elixir = {
                    {
                        lintCommand = "MIX_ENV=test mix credo suggest --format=flycheck --read-from-stdin ${INPUT}",
                        lintStdin = true,
                        lintIgnoreExitCode = true,
                        lintFormats = {'%f:%l:%c: %t: %m', '%f:%l: %t: %m'},
                        rootMarkers = {"mix.lock", "mix.exs"}
                    }
                },
                lua = {
                    {
                        formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=100 --break-after-table-lb",
                        formatStdin = true
                    }
                },
                python = {
                    {
                        lintCommand = "flake8 --config (find_up .flake8) --stdin-display-name ${INPUT} -",
                        lintStdin = true,
                        lintIgnoreExitCode = true
                    }, {formatCommand = "black --quiet -", formatStdin = true},
                    {formatCommand = "isort --quiet -", formatStdin = true}
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
                graphql = {prettier_format_command},
                markdown = {prettier_format_command}
            }
        }
    })
end

return M
