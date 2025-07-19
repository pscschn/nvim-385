local M = {}

-- get current tabpage vim.api.get_current_tabpage()
-- or vim.fn.tabpagenr()
-- get windows in tab:
--vim.api.nvim_tabpage_list_wins
-- or get the buflist directly from ccurrent tab: vim.fn.tabpagebuflist()
-- get the window buffers
--vim.api.nvim_win_get_buf({window})
--then get the bufname

M.tabpage_map_win_names = function()
    --local buflist = vim.fn.tabpagebuflist()
    local winlist = vim.api.nvim_tabpage_list_wins(vim.fn.tabpagenr())
    local map = {}
    for _, id in ipairs(winlist) do
        local bufid = vim.api.nvim_win_get_buf(id)
        map[vim.fn.bufname(bufid)] = id
    end
    return map
end

M.each_tabpage_win_name = function(func)
    local buflist = vim.fn.tabpagebuflist()
    for _, id in ipairs(buflist) do
        func(id, vim.fn.bufname(id))
    end
end

return M
