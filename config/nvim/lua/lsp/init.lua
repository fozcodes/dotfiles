local u = require("utils")
local null_ls = require("lsp.null-ls")
local tsserver = require("lsp.tsserver")

local api = vim.api
local lsp = vim.lsp

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    virtual_text = false,
})

local popup_opts = { border = "single", focusable = false }

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, popup_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, popup_opts)

local go_to_diagnostic = function(pos)
    return pos and api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
end

local next_diagnostic = function()
    go_to_diagnostic(lsp.diagnostic.get_next_pos() or lsp.diagnostic.get_prev_pos())
end

local prev_diagnostic = function()
    go_to_diagnostic(lsp.diagnostic.get_prev_pos() or lsp.diagnostic.get_next_pos())
end

_G.global.lsp = {
    popup_opts = popup_opts,
    next_diagnostic = next_diagnostic,
    prev_diagnostic = prev_diagnostic,
}

local border = {
    {"🭽", "FloatBorder"},
    {"▔", "FloatBorder"},
    {"🭾", "FloatBorder"},
    {"▕", "FloatBorder"},
    {"🭿", "FloatBorder"},
    {"▁", "FloatBorder"},
    {"🭼", "FloatBorder"},
    {"▏", "FloatBorder"},
}

local on_attach = function(client, bufnr)
    -- commands
    u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
    u.lua_command("LspHover", "vim.lsp.buf.hover()")
    u.lua_command("LspRename", "vim.lsp.buf.rename()")
    u.lua_command("LspDiagPrev", "global.lsp.prev_diagnostic()")
    u.lua_command("LspDiagNext", "global.lsp.next_diagnostic()")
    u.lua_command("LspDiagLine", "vim.lsp.diagnostic.show_line_diagnostics(global.lsp.popup_opts)")
    u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")

    u.buf_augroup("LspAutocommands", "CursorHold", "LspDiagLine")

    local opts = { noremap=true, silent=true }
    -- bindings
    u.buf_map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts, bufnr)
    u.buf_map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts, bufnr)
    u.buf_map("n", "gi", ":LspRename<CR>", nil, bufnr)
    u.buf_map("n", "K", ":LspHover<CR>", nil, bufnr)
    u.buf_map("n", "[a", ":LspDiagPrev<CR>", nil, bufnr)
    u.buf_map("n", "]a", ":LspDiagNext<CR>", nil, bufnr)
    u.buf_map("i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", nil, bufnr)

    vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border})
    vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})

    vim.lsp.handlers["textDocument/publishDiagnostics"] =
      function(_, _, params, client_id, _)
        local config = { -- your config
          underline = true,
          virtual_text = {
            prefix = "■ ",
            spacing = 4,
          },
          signs = true,
          update_in_insert = false,
        }
        local uri = params.uri
        local bufnr = vim.uri_to_bufnr(uri)

        if not bufnr then
          return
        end

        local diagnostics = params.diagnostics

        for i, v in ipairs(diagnostics) do
          diagnostics[i].message = string.format("%s: %s", v.source, v.message)
        end

        vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

        if not vim.api.nvim_buf_is_loaded(bufnr) then
          return
        end

        vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
      end

    if client.resolved_capabilities.document_formatting then
        u.buf_augroup("LspFormatOnSave", "BufWritePre", "lua vim.lsp.buf.formatting_sync()")
    end
end

tsserver.setup(on_attach)
