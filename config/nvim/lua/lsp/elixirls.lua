local nvim_lsp = require("lspconfig")

local path_to_elixirls = vim.fn.expand("~/.elixir/elixir-ls/rel/language_server.sh")

local M = {}
M.setup = function(on_attach)

  -- These have a different style than above because I was fiddling
  -- around and never converted them. Instead of converting them
  -- now, I'm leaving them as they are for this article because this is
  -- what I actually use, and hey, it works ¯\_(ツ)_/¯.
  vim.cmd [[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]
  vim.cmd [[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]

  vim.cmd [[imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
  vim.cmd [[smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
  vim.cmd [[imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]
  vim.cmd [[smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]

  --vim.cmd [[inoremap <silent><expr> <C-Space> compe#complete()]]
  --vim.cmd [[inoremap <silent><expr> <CR> compe#confirm('<CR>')]]
  --vim.cmd [[inoremap <silent><expr> <C-e> compe#close('<C-e>')]]
  --vim.cmd [[inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })]]
  --vim.cmd [[inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })]]

  nvim_lsp.elixirls.setup({
    cmd = { path_to_elixirls },
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false

      on_attach(client, bufnr)
    end;
    settings = {
      elixirLS = {
        dialyzerEnabled = true,
        suggestSpecs = true,
        enableTestLenses = true
      }
    }
  })

end

return M
