--- init.lua
---
--- - Load base options and globals
--- - Init project settings to enable overrides
--- - Load plugins
--- - Call project config to enable language setup

require("config.options")

local settings = require("util.projects").settings.load()

settings.init()

require("config.lazy")

settings.config()