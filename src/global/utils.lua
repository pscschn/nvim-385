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

function M.copyFile(src, dest)
  -- Open the source file in read-binary mode
  local inputFile = io.open(src, "rb")
  if not inputFile then
      return false, "Source file not found."
  end

  -- Read the entire content of the file
  local content = inputFile:read("*all")
  inputFile:close() -- Close the source file

  local outputFile = io.open(dest, "wb") -- Open the destination file in write-binary mode
  if not outputFile then
      return false, "Failed to open destination file."
  end

  outputFile:write(content) -- Write the content to the destination file
  outputFile:close() -- Close the destination file

  return true -- Return true indicating success
end

function M.mkdir_p(path)
    local stat = vim.loop.fs_stat(path)
    if stat and stat.type == 'directory' then
      return true -- Directory already exists
    end
  
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then
      return false -- Reached the root and the directory does not exist
    end
  
    -- Recursively create parent directory
    M.mkdir_p(parent)
  
    -- Create the directory
    local success = vim.loop.fs_mkdir(path, 493) -- 493 is octal for 0755
    if not success then
      return false, "Failed to create directory: " .. path
    end
  
    return true
  end

function M.writeToFile(directory, filename, contents)
    -- Ensure the directory ends with a slash
    if not directory:match("/$") then
      directory = directory .. "/"
    end
    
    if not M.directory_exists(directory) then
        print('Error: directory does not exist ' .. directory)
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

M.getAbsolutePath = function(base, relative)
    -- Normalize the paths by removing any trailing slashes
    base = base:gsub("/$", "")
    relative = relative:gsub("^/", "")
  
    -- Split the paths into components
    local baseComponents = {}
    for component in base:gmatch("[^/]+") do
      table.insert(baseComponents, component)
    end
  
    local relativeComponents = {}
    for component in relative:gmatch("[^/]+") do
      table.insert(relativeComponents, component)
    end
  
    -- Process the relative path components
    for _, component in ipairs(relativeComponents) do
      if component == ".." then
        -- Go up one level in the directory
        if #baseComponents > 0 then
          table.remove(baseComponents)
        end
      elseif component ~= "." then
        -- Add the component to the base path
        table.insert(baseComponents, component)
      end
    end
  
    -- Join the components to form the absolute path
    return "/" .. table.concat(baseComponents, "/")
  end



function M.directory_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == 'directory'
end


function M.getAllFilesInDirectory(dir)
  local handle = io.popen("ls " .. dir) -- Execute the ls command
  if not handle then
      return nil, "Failed to open directory."
  end

  local result = {}
  for file in handle:lines() do
      table.insert(result, file) -- Collect each file name
  end

  handle:close() -- Close the handle
  return result
end


return M
