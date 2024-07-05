local module_dir = vim.fn.expand('%:p:h')

vim.cmd('cd ' .. module_dir)

local indexfile = vim.fn.glob( '*index.lua')
-- Extract the number from the filename using string patterns
local index = string.match(vim.fn.fnamemodify(indexfile, ":t"),  "%d+")

local install_success, plugin_install = pcall(require, 'install')
local config_success, plugin_config = pcall(require, 'config')

local module_content = {}

if install_success and config_success then
    module_content.install = plugin_install
    module_content.config = plugin_config

    return {
        module = module_content,
        index = index
    }
else
    print('Failed to load plugin')
    return error('Failed to load plugin')
end