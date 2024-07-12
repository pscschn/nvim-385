local utils = require('nvim-385.utils')
local plugins = require('load_modules')
local module = require('nvim-385.module')

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