local dap_adapter = "netcoredbg"
local lsp_server = "roslyn"

local M = { lsp = {}, dap = { bin = nil } }

---@type string dap binary
M.dap.bin = require("config.settings").dir.mason .. "/netcoredbg/netcoredbg"

M.lsp.install = function()
  local server = require("mason-registry").get_package(lsp_server)

  if not server:is_installed() then
    vim.notify("Installing " .. lsp_server)
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
  require("lazy").load({
    plugins = {
      "roslyn.nvim",
      "nvim-lsp-endhints",
    },
  })

  return M
end

---@type table
local dap = M.dap

dap.install = function()
  local package = require("mason-registry").get_package(dap_adapter)
  if not package:is_installed() then
    vim.notify("Installing " .. dap_adapter)
    package:install()
  end

  return M
end

dap.config = function()
  require("dap").adapters[dap_adapter] = {
    type = "executable",
    command = dap.bin,
    args = { "--interpreter=vscode" },
  }
end

dap._config = function()
  require("lazy").load({
    plugins = {
      "nvim-dap-cs",
    },
  })
end

return M
