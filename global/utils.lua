local M = {}

function M.pwd()
    local source = debug.getinfo(2, "S").source
    if source:sub(1, 1) == "@" then
        source = source:sub(2)
    end
    local full_path = vim.fn.fnamemodify(source, ":p")
    local dir_path = vim.fn.fnamemodify(full_path, ":h")
    return dir_path
end

return M
