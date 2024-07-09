local module = require('module')

return module.loadsubmodules(module.pwd())
--local modules = module.lsmods(module.pwd())

--local plugins = {}

--plugins = module.submodules(module.pwd())

--for _, sub_module in ipairs(modules) do
--  local success, plugin = pcall(require, sub_module)
--  if success then
      --table.insert(plugins, plugin)
  --else
      --print('Error loading plugin: ', plugin)
  --end
--end

--return plugins