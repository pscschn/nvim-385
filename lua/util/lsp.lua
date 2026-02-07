--- @class LspUtils
local M = { functions = {} }

--- @class FunctionRanges
--- A table describing the start and end positions of functions in the current buffer.
--- Each key in the `result` table is the starting line number of a function,
--- and the value is a table containing the function's ending line and its name.
---
--- Example structure:
--- {
---   result = {
---     [<start_line>] = {
---       _end = <end_line>,   -- integer: line number where the function ends
---       name = <func_name>   -- string: fully-qualified function name
---     },
---     ...
---   }
--- }
--- @field result table<number, { _end: number, name: string }>
--- Maps the starting line number of a function to its details:
--- * `_end` (number): the ending line of the function
--- * `name` (string): the function name (can be local, module-scoped, or global)

local function make_document_symbol_params()
  return {
    textDocument = {
      uri = vim.uri_from_bufnr(0),
    },
  }
end

--- Finds all function symbols in the current buffer by using treesitter
--- @return FunctionRanges|{} FunctionRanges table of function start and end positions
M.functions.list = function()
  local out = { err = nil, result = {} }
  local function_kinds = {
    [vim.lsp.protocol.SymbolKind.Function] = true,
    [vim.lsp.protocol.SymbolKind.Method] = true,
  }
  local params = make_document_symbol_params()
  local bufnr = vim.api.nvim_get_current_buf()
  local timeout_ms = 5000

  local result = vim.lsp.buf_request_sync(bufnr, "textDocument/documentSymbol", params, timeout_ms)
  if not result then
    return {}
  end

  local function handle(symbol)
    local range = symbol.range or (symbol.location and symbol.location.range)

    if not range then
      return
    end

    if function_kinds[symbol.kind] then
      local _end = symbol.range["end"].line + 1
      out.result[range.start.line + 1] = { name = symbol.name, _end = _end }
    end

    if not symbol.children then
      return
    end

    for _, c in ipairs(symbol.children) do
      handle(c)
    end
  end

  for _, server_response in pairs(result) do
    if not server_response.result then
      return {}
    end

    for _, symbol in ipairs(server_response.result) do
      handle(symbol)
    end
  end

  table.sort(out.result, function(a, b)
    return a > b
  end)

  return out
end

--- comment
---@param tbl FunctionRanges start and end positions of the functions
---@param target string|integer any line number
---@return string|nil string start line of the matched function
M.functions.scan_for_line = function(tbl, target)
  -- extract and sort numeric keys
  local keys = {}
  for k in pairs(tbl) do
    if type(k) == "number" then
      table.insert(keys, k)
    end
  end
  table.sort(keys)

  local n = #keys
  if n == 0 then
    return nil
  end

  local lo, hi = 1, n

  while lo <= hi do
    local mid = math.floor((lo + hi) / 2)
    local start = keys[mid]
    local finish = tbl[start].ending or tbl[start]._end

    if target >= start and target <= finish then
      return start
    end

    if target < start then
      hi = mid - 1
    else
      lo = mid + 1
    end
  end

  return nil
end

--- Returns the function name that surrounds the cursor
--- in the current buffer
---@return string|nil string function symbol name
M.functions.at_cursor = function()
  local line = vim.fn.line(".")
  local symbols = M.functions.list()

  if symbols == nil then
    return nil
  end

  local nearest = M.functions.scan_for_line(symbols.result, line)

  if nearest == nil then
    return nil
  end

  return symbols.result[nearest].name
end

return M
