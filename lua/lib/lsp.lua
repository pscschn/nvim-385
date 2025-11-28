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

local function make_document_symbol_params()
  return {
    textDocument = {
      uri = vim.uri_from_bufnr(0),
    },
  }
end

M.get_function_symbols = function()
  local function_kinds = {
    [vim.lsp.protocol.SymbolKind.Function] = true,
    [vim.lsp.protocol.SymbolKind.Method] = true,
  }
  local out = { err = nil, result = {} }

  local params = make_document_symbol_params()
  local bufnr = vim.api.nvim_get_current_buf()
  local timeout_ms = 5000
  local result = vim.lsp.buf_request_sync(bufnr, "textDocument/documentSymbol", params, timeout_ms)
  if not result then
    return {}
  end

  local function handle(symbol)
    local range = symbol.range or (symbol.location and symbol.location.range)
    if range then
      if function_kinds[symbol.kind] then
        local _end = symbol.range["end"].line + 1
        out.result[range.start.line + 1] = { name = symbol.name, _end = _end }
      end
    end
    if symbol.children then
      for _, c in ipairs(symbol.children) do
        handle(c)
      end
    end
  end

  for _, server_response in pairs(result) do
    if server_response.result then
      for _, symbol in ipairs(server_response.result) do
        handle(symbol)
      end
    end
  end

  table.sort(out.result, function(a, b)
    return a > b
  end)

  return out
end

M.get_nearest_function = function()
  local util = require("lib.util")
  local line = vim.fn.line(".")
  local symbols = M.get_function_symbols()
  local nearest = util.find_range_key(symbols.result, line)
  if nearest == nil then
    return {}
  end
  return symbols.result[nearest].name
end

return M