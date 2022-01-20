local nvim_lsp = require("lspconfig")

local M = {}
M.setup = function(on_attach, capabilities)
    nvim_lsp.pyright.setup {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
        end,
        capabilities = capabilities,
        python = {analysis = {typeCheckingMode = "strict"}}
    }

end

return M
