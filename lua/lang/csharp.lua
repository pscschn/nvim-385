local M = {}
M.lsp = {}
M.dap = {}
M.dap.adapter = "netcoredbg"

M.lsp.install = function()
  local server = require("mason-registry").get_package("roslyn")

  if not server:is_installed() then
    require("mason").setup({
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    })
    server:install()
  end
  return M
end

M.lsp.config = function()
  require("lazy").load({ plugins = {
    "roslyn.nvim",
  } })
  return M
end

M.dap.install = function()
  local package = require("mason-registry").get_package(M.dap.adapter)
  if not package:is_installed() then
    package:install()
  end
  return M
end

M.dap.config = function()
  local bin = require("config.settings").dir.mason .. "/netcoredbg/netcoredbg"
  local dap = require("dap")

  dap.adapters.netcoredbg = {
    type = "executable",
    command = bin,
    args = { "--interpreter=vscode" },
  }
end

M.dap._config = function()
  require("lazy").load({ plugins = {
    "nvim-dap-cs",
  } })
end

return M