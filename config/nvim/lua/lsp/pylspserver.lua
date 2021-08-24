local nvim_lsp = require("lspconfig")

local M = {}
M.setup = function(on_attach)
    nvim_lsp.pylsp.setup{
        on_attach = function(client, bufnr)
            vim.api.nvim_command("au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")

            on_attach(client, bufnr)
        end;
        settings = {
          configurationSources = { "flake8" },
          formatCommand = { "black" }
        }
    }

end

return M
