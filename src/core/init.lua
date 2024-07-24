local utils = require('nvim-385.utils')
local module = require('nvim-385.module')

require("options")
require("keymap")
require("lazy-config")
local _, config_loading_success = require("configs")
if not config_loading_success then
    print("unable to load configs")
  end