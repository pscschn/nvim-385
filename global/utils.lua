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

function M.shallowCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        copy[k] = v
    end
    return copy
end

function M.getCaller()
    -- Get info about the caller (level 2 in the stack)
    local info = debug.getinfo(2, "S")
    return info.short_src
end

return M
