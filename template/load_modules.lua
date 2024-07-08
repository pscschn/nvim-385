local utils = require('utils')
local module_dir = utils.pwd()
vim.cmd('cd ' .. module_dir)

local function loadPlugins(parentDir)
    local modules = {}
    print(module_dir)
    -- Iterate through subdirectories
    for dir in io.popen('ls -d ' .. module_dir .. ' */ | grep /$ | sed \'s/\\/$//\''):lines() do 
        
        local module_init = dir  .. '/init'
        
        require(module_init)
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
