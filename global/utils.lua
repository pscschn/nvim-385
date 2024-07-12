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

function M.findFile(directory, pattern)
    local popen = io.popen
    local pfile = popen('ls "'..directory..'"')
    
    if pfile == nil then
        print('Error: No files inside to find directory: ' .. directory)
        return nil
    end

    local indexfile = nil
    local i = 0

    for filename in pfile:lines() do
        if string.match(filename, pattern) then
            i = i + 1
            indexfile = filename
        end
    end

    pfile:close()

    if not i == 1 then
        print('Error: multiple files matching defined pattern inside directory: ' .. directory )
        return nil
    end

    return indexfile
end


function M.writeToFile(directory, filename, contents)
    -- Ensure the directory ends with a slash
    if not directory:match("/$") then
      directory = directory .. "/"
    end

    -- Construct the full file path
    local filePath = directory .. filename

    -- Open the file in write mode
    local file, err = io.open(filePath, "w")
    if not file then
      return false, "Failed to open file: " .. err
    end

    -- Write the contents to the file
    file:write(contents)

    -- Close the file
    file:close()

    return true
  end

return M
