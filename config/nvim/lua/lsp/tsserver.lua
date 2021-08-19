local lspconfig = require("lspconfig")
local ts_utils = require("nvim-lsp-ts-utils")

local u = require("utils")

-- copied from sumneko; try to think of a better solution
local trigger_characters = {
    "\t",
    "\n",
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    ".",
    ":",
    "(",
    "'",
    '"',
    "[",
    ",",
    "#",
    "*",
    "@",
    "|",
    "=",
    "-",
    "{",
    " ",
}

local ts_utils_settings = {
    -- debug = true,
    import_all_scan_buffers = 100,
    eslint_bin = "eslint_d",
    eslint_enable_diagnostics = true,
    eslint_show_rule_id = true,
    enable_formatting = true,
    formatter = "eslint_d",
    update_imports_on_move = true,
}

local M = {}
M.setup = function(on_attach)
    lspconfig.tsserver.setup({
        on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            client.server_capabilities.completionProvider.triggerCharacters = trigger_characters

            on_attach(client, bufnr)

            ts_utils.setup(ts_utils_settings)
            ts_utils.setup_client(client)

            u.buf_map("n", "gs", ":TSLspOrganize<CR>", nil, bufnr)
            u.buf_map("n", "gI", ":TSLspRenameFile<CR>", nil, bufnr)
            u.buf_map("n", "go", ":TSLspImportAll<CR>", nil, bufnr)
            u.buf_map("n", "qq", ":TSLspFixCurrent<CR>", nil, bufnr)
        end,
        flags = {
            debounce_text_changes = 150,
        },
    })
end

return M
