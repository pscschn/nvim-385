local M = {}
M.keys = {}
M.keys.on_attach = {
    {"<leader>lr", "<cmd>Telescope lsp_references<CR>", mode = "n", desc = "References"},
    {"<leader>li", "<cmd>Telescope lsp_implementations<CR>", mode = "n", desc = "Implementations"},
    {"<leader>ld", "<cmd>Telescope lsp_definitions<CR>", mode = "n", desc = "Definitions"},
    {"<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", mode = "n", desc = "Symbols"},
    {"<leader>rr", vim.lsp.buf.rename, mode = "n", desc = "Rename Symbol"}
}

return M
