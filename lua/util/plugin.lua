--- @class MasonUtils
--- Helper for handling mason packages
--- @field safe_install function
--- @field registry any
local mason = {}
local M = { manager = {}, treesitter = {}, mason = mason, npm = {} }

M.ensure_package_known = function(pkg)
  if type(pkg) ~= "string" or pkg == "" then
    pkg = vim.fn.input("Package name: ")
  end

  if pkg == "" then
    vim.notify("Provide a package name", vim.log.levels.ERROR)
    return nil
  end

  return pkg
end

M.manager.load_plugin = function(tbl)
  require("lazy").load({
    plugins = tbl,
  })
end

M.treesitter.install = function(pkg)
  pkg = M.ensure_package_known(pkg)
  if not pkg then
    return
  end

  M.manager.load_plugin({ "nvim-treesitter" })
  require("nvim-treesitter.install").install(pkg)
end

local function jobstart(args, pkg)
  vim.fn.jobstart(args, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("Installed global npm package: " .. pkg, vim.log.levels.INFO)
      else
        vim.notify("Failed to install " .. pkg .. " (exit code " .. code .. ")", vim.log.levels.ERROR)
      end
    end,
  })
end

M.test_bin = function(executable, message)
  if vim.fn.executable(executable) == 0 then
    vim.notify(
      message or (executable .. " is not installed or not in PATH"),
      vim.log.levels.WARN,
      { title = "Missing Dependency" }
    )
    return false
  end

  return true
end

M.npm.install = function(pkg)
  pkg = M.ensure_package_known(pkg)
  if not pkg then
    return
  end

  jobstart({ "npm", "install", "--global", pkg }, pkg)
end

(function()
  local ok, registry = pcall(require, "mason-registry")
  if ok then
    M.mason.registry = registry
  end
end)()

--- Installs mason packages and catches installation errors
---@param pkg string|nil the mason package to install
M.mason.safe_install = function(pkg)
  pkg = M.ensure_package_known(pkg)
  if not pkg then
    return
  end

  local registry = M.mason.registry
  if registry == nil then
    vim.notify("Mason is not installed", vim.log.levels.WARN)
    return
  end

  local ok, p = pcall(registry.get_package, pkg)

  if not ok then
    vim.notify("Package " .. pkg .. "is not available." .. "You might want to run :MasonInstall.", vim.log.levels.WARN)
    return
  end

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
        { "[Mason Installer Error (" .. pkg .. ")]: ", "ErrorMsg" },
        { data, "None" },
      }, true, {})
    end)
  end)

  handle:on("install:failed", function()
    vim.schedule(function()
      vim.notify("Mason failed to install " .. pkg, vim.log.levels.ERROR)
    end)
  end)
end

return M
