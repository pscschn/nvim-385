--- @class MasonUtils
--- Helper for handling mason packages
--- @field safe_install function
--- @field registry any
local M = {}

M.registry = require("mason-registry")

--- Installs mason packages and catches installation errors
---@param pkg_name string the mason package to install
M.safe_install = function(pkg_name)
  local registry = M.registry
  local p = registry.get_package(pkg_name)

  if p:is_installed() then
    return
  end
  local handle = p:install()

  --handle:on("stdout", function(data)
  -- print("[Mason STDOUT] " .. data)
  --end)

  handle:on("stderr", function(data)
    vim.schedule(function()
      vim.api.nvim_echo({
        { "[Mason Installer Error (" .. pkg_name .. ")]: ", "ErrorMsg" },
        { data, "None" },
      }, true, {})
    end)
  end)

  handle:on("install:failed", function()
    vim.schedule(function()
      vim.notify("Mason failed to install " .. pkg_name, vim.log.levels.ERROR)
    end)
  end)
end

return M
