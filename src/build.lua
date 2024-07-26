local utils = require('nvim-385.utils')
local module = require('nvim-385.module')
local plugins = dofile(module.pwd() .. '/modules/load.lua')

local core_path = utils.getAbsolutePath(module.pwd(), "core")
local core_init = utils.findFile(core_path, "init.lua")

if core_init == nil then
  print("Error: core init file not found")
  return
end

local generate_content = function(file)
  local contents = "return { \n"

  for _, value in pairs(plugins) do
      contents = contents .. "dofile('" .. value.module .. "/" .. file .. "')," .. "\n"
    end

  contents = contents .. "}"
  return contents
end

local build_path = utils.getAbsolutePath(module.pwd(), "../.build")
local lua_path = build_path .. '/lua'
utils.mkdir_p(lua_path)
utils.writeToFile(lua_path, 'plugins.lua', generate_content( 'install.lua'))
utils.writeToFile(lua_path, 'configs.lua', generate_content( 'config.lua'))
utils.writeToFile(lua_path, 'keymaps.lua', generate_content( 'keymaps.lua'))

utils.copyFile(core_path .. '/' .. 'plugin-manager.lua', lua_path .. '/' .. 'plugin-manager.lua')
utils.copyFile(core_path .. '/' .. 'global-keymap.lua', lua_path .. '/' .. 'global-keymap.lua')
utils.copyFile(core_path .. '/' .. 'options.lua', lua_path .. '/' .. 'options.lua')

utils.copyFile(core_path .. '/' .. 'init.lua', build_path .. '/' .. 'init.lua')