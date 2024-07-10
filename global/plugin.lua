local utils = require('utils')

local Plugin = {
  index = nil,
  name = nil,
  module = nil,
  install = nil,
  config = nil,
  keymap = nil,
  new = new
}


function new () 
  return utils.shallowCopy(PluginType)
end


local Config = {
  setup = function() end
}

return Plugin