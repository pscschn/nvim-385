local module_dir = vim.fn.expand('%:p:h')
vim.cmd('cd ' .. module_dir)


local function loadPlugins(parentDir)
    local modules = {}
    print(module_dir)
    -- Iterate through subdirectories
    for dir in io.popen('ls -d ' .. module_dir .. ' */ | grep /$ | sed \'s/\\/$//\''):lines() do 
        
        local module_init = dir .. '.init'
        
        -- Attempt to require the module 
        local success, module = pcall(require, module_init)
        if success then
            table.insert(modules, module)
        else 
            print('Error loading module: ', module_init)
        end
    end

    return modules

end
-- Load modules from subdirectories relative to the determined parent directory
local loadedModules = loadPlugins(module_dir)

-- Print loaded modules for verification
for i, module in ipairs(loadedModules) do
    print("Module", i, ":", module)
end

-- Return the array of loaded modules 
return loadedModules