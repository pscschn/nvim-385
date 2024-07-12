local utils = require('utils')

local Plugin = {}
Plugin.__index = Plugin

function Plugin:new(module_dir)
  local install_success, plugin_install = pcall(dofile, module_dir .. '/install.lua')
  local config_success, plugin_config = pcall(dofile, module_dir .. '/config.lua')
  local keymap_success, plugin_keymap = pcall(dofile, module_dir .. '/keymap.lua')

  local indexfile = utils.findFile(module_dir, "^%d+%.index%.lua$")

  if not indexfile then
    error("Index file not found in module directory: " .. module_dir)
  end

  -- Extract the number from the filename using string patterns
  local index = string.match(vim.fn.fnamemodify(indexfile, ":t"),  "%d+")
  
  local plugin = setmetatable({
    module = module_dir,
    index = index,
    name = 'test',
    install = install_success and plugin_install or nil,
    config = config_success and plugin_config or nil,
    keymap = keymap_success and plugin_keymap or nil,
  }, Plugin)

  return plugin
end


local Config = {
  setup = function() end
}

return Plugin