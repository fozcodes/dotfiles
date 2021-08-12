local nvim_lsp = require("lspconfig")

--nvim_lsp.pyright.setup{
  --settings = {
    --python = {
      --disableOrganizeImports = false,
      --venvPath = "$VIRTUAL_ENV"
    --}
  --}
--}

nvim_lsp.pylsp.setup{}


-- Vue LS
nvim_lsp.vuels.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
    end;
  settings = {
        vetur = {
            completion = {
                autoImport = false,
                tagCasing = "kebab",
                useScaffoldSnippets = false
            },
            format = {
                defaultFormatter = {
                    js = "prettier",
                    ts = "prettier",
                    html = "prettier"
                },
                scriptInitialIndent = false,
                styleInitialIndent = false,
                useTabs = false,
            },
            useWorkspaceDependencies = true,
            validation = {
                script = true,
                style = true,
                template = true
            }
        }
    }
  }

-- TS SETUP
_G.lsp_organize_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

-- formatting
--if client.resolved_capabilities.document_formatting then
  --vim.api.nvim_command [[augroup Format]]
  --vim.api.nvim_command [[autocmd! * <buffer>]]
  --vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
  --vim.api.nvim_command [[augroup END]]
--end

nvim_lsp.tsserver.setup {
  on_attach = function(_, bufnr)
        local ts_utils = require("nvim-lsp-ts-utils")

        -- defaults
        ts_utils.setup {
            disable_commands = false,
            enable_import_on_completion = false,
            import_on_completion_timeout = 5000,
            -- eslint
            eslint_bin = "./node_modules/.bin/eslint",
            eslint_args = {"-f", "json", "--stdin", "--stdin-filename", "$FILENAME"},
            eslint_enable_disable_comments = true,

            -- experimental settings!
            -- eslint diagnostics
            eslint_enable_diagnostics = true,
            eslint_diagnostics_debounce = 250,
            -- formatting
            enable_formatting = true,
            formatter = "./node_modules/.bin/prettier",
            formatter_args = {"--stdin-filepath", "$FILENAME"},
            format_on_save = true,
            no_save_after_format = false
        }

        vim.lsp.buf_request = ts_utils.buf_request

        -- no default maps, so you may want to define some here
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", {silent = true})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", {silent = true})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", {silent = true})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", {silent = true})
    end;
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
  }

nvim_lsp.diagnosticls.setup {
  on_attach = function(client)
    if vim.bo.filetype == 'vue' then
        client.resolved_capabilities.document_formatting = false
    else
        client.resolved_capabilities.document_formatting = true
            --vim.cmd [[augroup Format]]
            --vim.cmd [[autocmd! * <buffer>]]
            --vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()]]
            --vim.cmd [[augroup END]]
        vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
    end
  end;
  filetypes = { 'javascript', 'javascriptreact', 'json', 'css', 'less', 'scss', 'markdown', 'pandoc', 'vue' },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.eslintrc.js' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint_d',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
      vue = 'eslint',
    },
    formatters = {
      prettier = {
        command = 'npx',
        args = { 'prettier', '--stdin-filepath', '%filepath' }
      }
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'prettier',
      javascriptreact = 'prettier',
      json = 'prettier',
      scss = 'prettier',
      less = 'prettier',
      typescript = 'prettier',
      typescriptreact = 'prettier',
      json = 'prettier',
      markdown = 'prettier',
    }
  }
}
