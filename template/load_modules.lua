local module = require('module')
local subModules = module.loadsubmodules(module.pwd())

local loadedPlugins = {}

for i, subModule in ipairs(subModules) do
  print("SubModule " .. i)
  for j, plugin in ipairs(subModule) do
    print("  Plugin " .. j .. ": " .. tostring(plugin))
      table.insert(loadedPlugins, plugin)
  end
end

for i, plugin in ipairs(loadedPlugins) do
  local index = plugin.index
  local data = plugin.data
  local config = data.config
  local install = data.install
  print("Module", i, ":", plugin ,'with index ' .. index .. '/r')
  print('install: ', install, '/r')
  config.setup()
  print('/r')
end
