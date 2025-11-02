local M = { keys = {} }

M.keys.on_attach = {
  { "<leader>lr", require("telescope.builtin").lsp_references, mode = "n", desc = "References" },
  { "<leader>li", require("telescope.builtin").lsp_implementations, mode = "n", desc = "Implementations" },
  { "<leader>ld", require("telescope.builtin").lsp_definitions, mode = "n", desc = "Definitions" },
  { "<leader>ls", require("telescope.builtin").lsp_document_symbols, mode = "n", desc = "Symbols" },
  { "<leader>lR", vim.lsp.buf.rename, mode = "n", desc = "Rename Symbol" },
  { "<leader>la", vim.lsp.buf.code_action, mode = "n", desc = "Code Actions" },
}

return M
