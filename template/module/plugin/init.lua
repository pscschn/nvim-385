local index = tonumber((vim.fn.readfile(vim.fn.glob('*index.lua'))[1]))

local module_content = {
    config = require('config'),
    install = require('install')
}

return {
    module = module_content,
    index = index
}
