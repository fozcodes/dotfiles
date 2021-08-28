--local nvim_lsp = require("lspconfig")

-- Elixir

-- Python
-- nvim_lsp.pyright.setup{
-- settings = {
-- python = {
-- disableOrganizeImports = false,
-- venvPath = "$VIRTUAL_ENV"
-- }
-- }
-- }

-- nvim_lsp.pylsp.setup {}
---

-- Vue LS
-- nvim_lsp.vuels.setup {
-- on_attach = function(client)
-- client.resolved_capabilities.document_formatting = true
-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
-- end,
-- settings = {
-- vetur = {
-- completion = {autoImport = false, tagCasing = "kebab", useScaffoldSnippets = false},
-- format = {
-- defaultFormatter = {js = "prettier", ts = "prettier", html = "prettier"},
-- scriptInitialIndent = false,
-- styleInitialIndent = false,
-- useTabs = false
-- },
-- useWorkspaceDependencies = true,
-- validation = {script = true, style = true, template = true}
-- }
-- }
-- }

-- TS SETUP
-- enable null-ls integration (optional)
-- require("null-ls").config {}
-- require("lspconfig")["null-ls"].setup {}

-- nvim_lsp.tsserver.setup {
-- on_attach = function(client, bufnr)
---- disable tsserver formatting if you plan on formatting via null-ls
-- client.resolved_capabilities.document_formatting = false
-- client.resolved_capabilities.document_range_formatting = false

-- local ts_utils = require("nvim-lsp-ts-utils")

---- defaults
-- ts_utils.setup {
-- debug = false,
-- disable_commands = false,
-- enable_import_on_completion = false,

---- import all
-- import_all_timeout = 2000, -- ms
-- import_all_priorities = {
-- buffers = 4, -- loaded buffer names
-- buffer_content = 3, -- loaded buffer content
-- local_files = 2, -- git files or files with relative path markers
-- same_file = 1 -- add to existing import statement
-- },
-- import_all_scan_buffers = 100,
-- import_all_select_source = false,

---- eslint
-- eslint_enable_code_actions = true,
-- eslint_enable_disable_comments = true,
-- eslint_bin = "eslint",
-- eslint_config_fallback = nil,
-- eslint_enable_diagnostics = false,
-- eslint_show_rule_id = true,

---- formatting
-- enable_formatting = true,
-- formatter = "prettier",
-- formatter_config_fallback = nil,

---- update imports on file move
-- update_imports_on_move = false,
-- require_confirmation_on_move = true,
-- watch_dir = nil
-- }

---- required to fix code action ranges
-- ts_utils.setup_client(client)

---- no default maps, so you may want to define some here
-- local opts = {silent = true}
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)

-- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
-- end,
-- filetypes = {"typescript", "typescriptreact", "typescript.tsx"}
-- }

-- nvim_lsp.diagnosticls.setup {
-- on_attach = function(client)
-- if vim.bo.filetype == 'vue' then
-- client.resolved_capabilities.document_formatting = false
-- else
-- client.resolved_capabilities.document_formatting = true
-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
-- end
-- end,
-- filetypes = {'javascript', 'javascriptreact', 'json', 'css', 'less', 'scss', 'markdown', 'pandoc', 'vue'},
-- init_options = {
-- linters = {
-- eslint = {
-- command = 'eslint_d',
-- rootPatterns = {'.eslintrc.js'},
-- debounce = 100,
-- args = {'--stdin', '--stdin-filename', '%filepath', '--format', 'json'},
-- sourceName = 'eslint_d',
-- parseJson = {
-- errorsRoot = '[0].messages',
-- line = 'line',
-- column = 'column',
-- endLine = 'endLine',
-- endColumn = 'endColumn',
-- message = '[eslint] ${message} [${ruleId}]',
-- security = 'severity'
-- },
-- securities = {[2] = 'error', [1] = 'warning'}
-- }
-- },
-- filetypes = {javascript = 'eslint', javascriptreact = 'eslint', typescript = 'eslint', typescriptreact = 'eslint', vue = 'eslint'},
-- formatters = {prettier = {command = 'npx', args = {'prettier', '--stdin-filepath', '%filepath'}}},
-- formatFiletypes = {
-- css = 'prettier',
-- javascript = 'prettier',
-- javascriptreact = 'prettier',
-- json = 'prettier',
-- scss = 'prettier',
-- less = 'prettier',
-- typescript = 'prettier',
-- typescriptreact = 'prettier',
-- json = 'prettier',
-- markdown = 'prettier'
-- }
-- }
-- }
