local M = { keys = {} }

M.keys.on_attach = {
  { lhs = "<leader>lr", rhs = require("telescope.builtin").lsp_references, mode = "n", opts = { desc = "References" } },
  {
    lhs = "<leader>li",
    rhs = require("telescope.builtin").lsp_implementations,
    mode = "n",
    opts = { desc = "Implementations" },
  },
  {
    lhs = "<leader>ld",
    rhs = require("telescope.builtin").lsp_definitions,
    mode = "n",
    opts = { desc = "Definitions" },
  },
  {
    lhs = "<leader>ls",
    rhs = require("telescope.builtin").lsp_document_symbols,
    mode = "n",
    opts = { desc = "Symbols" },
  },
  { lhs = "<leader>lR", rhs = vim.lsp.buf.rename, mode = "n", opts = { desc = "Rename Symbol" } },
  { lhs = "<leader>la", rhs = vim.lsp.buf.code_action, mode = "n", opts = { desc = "Code Actions" } },
}

M.set_keymaps = function()
  local keys = M.keys.on_attach
  for _, mapping in ipairs(keys) do
    local opts = mapping.opts

    if opts == nil then
      opts = {}
    end

    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, opts)
  end
end

return M
