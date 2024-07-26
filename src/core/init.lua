local utils = require('nvim-385.utils')
local module = require('nvim-385.module')

require("options")
require("global-keymap")
require("plugin-manager")

local config, config_loading_success = require("configs")
if not config_loading_success then
    print("Error: Failed to load configs")
    return
end

for _, module in ipairs(config) do
  if type(module.setup) == "function" then
    module.setup()
  else
    print("No setup function found in module")
  end
end