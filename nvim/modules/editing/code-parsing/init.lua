local module_dir = vim.fn.expand('%:p:h')

vim.cmd('cd ' .. module_dir)

print(module_dir)
local indexfile = vim.fn.glob( '*index.lua')
print (indexfile)
-- Extract the number from the filename using string patterns
local index = string.match(vim.fn.fnamemodify(indexfile, ":t"),  "%d+")

local module_content = {
    install = require( 'install'),
    config = require('config')
    
}
module_content.config.setup()
return {
    module = module_content,
    index = index
}