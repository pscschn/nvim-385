--- @class LspKeymaps
--- @field on_attach table
--- @field attach function
---
--- @class Keymaps
--- @field lsp LspKeymaps
local M = { lsp = {} }

M.lsp.on_attach = {
  {
    lhs = vim.g.keys.lsp.find_refs,
    rhs = require("telescope.builtin").lsp_references,
    mode = "n",
    opts = { desc = "References" },
  },
  {
    lhs = vim.g.keys.lsp.find_impl,
    rhs = require("telescope.builtin").lsp_implementations,
    mode = "n",
    opts = { desc = "Implementations" },
  },
  {
    lhs = vim.g.keys.lsp.find_def,
    rhs = require("telescope.builtin").lsp_definitions,
    mode = "n",
    opts = { desc = "Definitions" },
  },
  {
    lhs = vim.g.keys.lsp.find_symbol,
    rhs = require("telescope.builtin").lsp_document_symbols,
    mode = "n",
    opts = { desc = "Symbols" },
  },

  { lhs = vim.g.keys.lsp.rename, rhs = vim.lsp.buf.rename, mode = "n", opts = { desc = "Rename Symbol" } },
  {
    lhs = vim.g.keys.lsp.code_action,
    rhs = vim.lsp.buf.code_action,
    mode = "n",
    opts = { desc = "Code Actions" },
  },
}

M.lsp.attach = function()
  local keys = M.lsp.on_attach
  for _, mapping in ipairs(keys) do
    local opts = mapping.opts

    if opts == nil then
      opts = {}
    end

    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, opts)
  end
end

return M
