local module = require('module')
local subModules = module.loadsubmodules(module.pwd())

local loadedPlugins = {}

for _, subModule in ipairs(subModules) do
  for _, plugin in ipairs(subModule) do
      table.insert(loadedPlugins, plugin)
  end
end

table.sort(loadedPlugins, function(a, b)
  return a.index < b.index
end)

return loadedPlugins