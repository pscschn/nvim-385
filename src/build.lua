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
utils.mkdir_p(build_path)
utils.writeToFile(build_path, 'plugins.lua', generate_content( 'install.lua'))
utils.writeToFile(build_path, 'configs.lua', generate_content( 'config.lua'))
utils.writeToFile(build_path, 'keymaps.lua', generate_content( 'keymaps.lua'))

local files, err = utils.getAllFilesInDirectory(core_path)
if files then
    for _, file in ipairs(files) do
      print(file)
      utils.copyFile(core_path .. '/'..file, build_path .. '/'..file)
    end
else
    print("Error:", err)
end