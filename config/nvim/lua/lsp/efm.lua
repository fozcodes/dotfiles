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
local efm_filetypes = {"elixir", "typescript", "typescriptreact", "javascript", "yaml", "json", "html", "scss", "css", "markdown", "lua"}

local M = {}
M.setup = function(on_attach)
    nvim_lsp.efm.setup {
        init_options = {documentFormatting = true},
        on_attach = function(client, bufnr)
            vim.api.nvim_command("au BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()")

            on_attach(client, bufnr)
        end,
        filetypes = efm_filetypes
    }
end

return M
