---@class ProjectSettingsModule
---@field load fun(): ProjectSettings
---@field normalize fun(module:ProjectSettings): ProjectSettings
--- Project settings loader.
---
--- Responsible for loading project-local Lua configuration files
--- and ensuring they conform to the {@link ProjectSettings} interface.
---
--- The loaded settings module is expected to return a table.
--- Missing lifecycle functions (`init`, `config`) are automatically
--- filled with no-op implementations.

--- @class ProjectModule
--- @field settings ProjectSettingsModule|{}
local M = { settings = {} }

---@class ProjectSettings
---@field init fun()            -- Called early to set up globals, options, or state
---@field config fun()          -- Called after init to apply configuration

--- Project-specific Neovim settings module.
---
--- This module is dynamically loaded by the project settings loader.
--- It must return a table implementing the {@link ProjectSettings} interface.
---
--- Example:
--- ```lua
--- return {
---   init = function()
---     -- early setup
---   end,
---
---   config = function()
---     -- apply configuration
---   end,
--- }
--- ```

--- @type ProjectSettings
local DefaultSettings = {
  init = function() end,
  config = function() end,
}

--- Normalizes the module to ensure the expected fields exist
---@param module ProjectSettings
M.settings.normalize = function(module)
  module.init = type(module.init) == "function" and module.init or function() end
  module.config = type(module.config) == "function" and module.config or function() end
  return module
end

--- Parses a "settings.lua" file inside the folder ".nvim"
--- @return ProjectSettings ProjectSettings Project settings
M.settings.load = function()
  local config_path = vim.g.dirs.project_settings

  -- Check file exists
  local file = io.open(config_path, "r")
  if not file then
    return DefaultSettings
  end
  file:close()

  -- Load the file as a Lua chunk
  local chunk, err = loadfile(config_path)
  if not chunk then
    vim.notify("Failed to load settings module: " .. err, vim.log.levels.ERROR)
    return DefaultSettings
  end

  -- Execute chunk and expect a table back
  local ok, module = pcall(chunk)
  if not ok then
    vim.notify("Error running settings module: " .. module, vim.log.levels.ERROR)
    return DefaultSettings
  end

  if type(module) ~= "table" then
    vim.notify("Settings file must return a table", vim.log.levels.ERROR)
    return DefaultSettings
  end

  return M.settings.normalize(module)
end

return M
