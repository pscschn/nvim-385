local function loadPlugins(parentDir)
    local modules = {}

    -- Iterate through subdirectories

    for _, subdirectory in ipairs(vim.fn.readdir(parentDir)) do
        local modulePath = parentDir .. '/' .. subdirectory .. 'init'

        -- Attempt to require the module 

        local success, module = pcall(require, modulePath)
        if success then
            table.insert(modules, module)
        else 
            print('Error loading module: ', modulePath)
        end
    end

    return modules

end

-- Determine the parent directory dynamically based on script location
local scriptPath = vim.fn.expand('<sfile>')
local parentDir = vim.fn.fnamemodify(scriptPath, ':h')  -- Get the directory part of the script path

-- Load modules from subdirectories relative to the determined parent directory
local loadedModules = loadPlugins(parentDir)

-- Print loaded modules for verification
for i, module in ipairs(loadedModules) do
    print("Module", i, ":", module)
end

-- Return the array of loaded modules 
return loadedModules