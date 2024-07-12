local utils = require('utils')
local plugins = require('load_modules')
local module = require('module')
local contents = "return { \n"

for _, value in pairs(plugins) do
    contents = contents .. "dofile('" .. value.module .. "/install.lua')," .. "\n"
  end

contents = contents .. "}"

print(contents)

local path = utils.getAbsolutePath(module.pwd(), "../.build")
utils.mkdir_p(path)
utils.writeToFile(path, 'plugins.lua', contents)