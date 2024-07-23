local utils = require('nvim-385.utils')
local module = require('nvim-385.module')
local plugins = dofile(module.pwd() .. '/modules/load.lua')

local generate_content = function(file)
  local contents = "return { \n"

  for _, value in pairs(plugins) do
      contents = contents .. "dofile('" .. value.module .. "/" .. file .. "')," .. "\n"
    end

  contents = contents .. "}"
  return contents
end

local path = utils.getAbsolutePath(module.pwd(), "../.build")
utils.mkdir_p(path)
utils.writeToFile(path, 'plugins.lua', generate_content( 'install.lua'))
utils.writeToFile(path, 'configs.lua', generate_content( 'config.lua'))
utils.writeToFile(path, 'keymaps.lua', generate_content( 'keymaps.lua'))

local core_path = utils.getAbsolutePath(module.pwd(), "core")

local init_content = 'vim.loader.enable()\n'
init_content = init_content .. 'dofile("' .. core_path .. '/keymap.lua")\n'
init_content = init_content .. 'dofile("' .. core_path .. '/options.lua")\n'
init_content = init_content .. 'require("plugins")\n'
init_content = init_content .. 'require("configs")\n'
init_content = init_content .. 'require("keymaps")\n'

utils.writeToFile(path, 'init.lua', init_content)