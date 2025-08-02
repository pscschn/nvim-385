local M = {}

M.sources = {
  { name = "nvim_lsp", max_item_count = 15 },
  { name = "path", max_item_count = 5 },
  { name = "buffer", max_item_count = 5 },
}
---@param source string cmp source to add
M.add_source = function(source)
  table.insert(M.sources, { name = source, max_item_count = 15 })
end

M.reload = function()
  require("lazy.core.loader").reload("nvim-cmp")
end

return M
