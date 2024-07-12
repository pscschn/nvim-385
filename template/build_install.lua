local utils = require('utils')
local plugins = require('load_modules')
local contents = "return { \n"

for _, value in pairs(plugins) do
    contents = contents .. "dofile('" .. value.module .. "/install.lua')," .. "\n"
  end

contents = contents .. "}"

print(contents)

--utils.writeToFile()