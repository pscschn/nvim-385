local M = {}

--- maps open buffer names to their window id's
--- @return table<string, number> map <buffer name, window id>
M.tabpage_map_win_names = function()
  local winlist = vim.api.nvim_tabpage_list_wins(vim.fn.tabpagenr())
  local map = {}
  for _, id in ipairs(winlist) do
    local bufid = vim.api.nvim_win_get_buf(id)
    map[vim.fn.bufname(bufid)] = id
  end
  return map
end

--- executes a callback that takes name and id of
--- each buffer open in the current tab
--- @param func fun(id: number, bufname: string) callback
M.each_tabpage_win_name = function(func)
  local buflist = vim.fn.tabpagebuflist()
  for _, id in ipairs(buflist) do
    func(id, vim.fn.bufname(id))
  end
end

return M
