vim.o.completeopt = "menuone,noselect"

-- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local cmp = require('cmp')

cmp.setup {
    snippet = {
        expand = function(args)
            -- You must install `vim-vsnip` if you use the following as-is.
            vim.fn['vsnip#anonymous'](args.body)
        end
    },

    -- You must set mapping if you want.
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true})
    },

    -- You should specify your *installed* sources.
    sources = {{name = 'buffer'}, {name = 'nvim_lsp'}, {name = 'path'}, {name = 'vsnip'}}
}

-- local t = function(str)
-- return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

-- local check_back_space = function()
-- local col = vim.fn.col('.') - 1
-- if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
-- return true
-- else
-- return false
-- end
-- end

-- local foz = function

---- Use (s-)tab to:
----- move to prev/next item in completion menuone
----- jump to prev/next snippet's placeholder
-- _G.tab_complete = function()
-- if vim.fn.pumvisible() == 1 then
-- return t "<C-n>"
-- elseif vim.fn.call("vsnip#available", {1}) == 1 then
-- return t "<Plug>(vsnip-expand-or-jump)"
-- elseif check_back_space() then
-- return t "<Tab>"
-- else
-- return vim.fn['compe#complete']()
-- end
-- end
-- _G.s_tab_complete = function()
-- if vim.fn.pumvisible() == 1 then
-- return t "<C-p>"
-- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
-- return t "<Plug>(vsnip-jump-prev)"
-- else
---- If <S-Tab> is not working in your terminal, change it to <C-h>
-- return t "<C-h>"
-- end
-- end
