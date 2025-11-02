local settings = require("config.settings")

local dap_server = "js-debug-adapter"
local lsp_server = "typescript-language-server"

local M = { lsp = {}, dap = {} }

M.lsp.install = function()
  local name = lsp_server
  local server = require("mason-registry").get_package(name)
  if not server:is_installed() then
    vim.notify("Installing" .. name)
    server:install()
  end
end

M.lsp.config = function()
  local name = lsp_server
  local root = settings.dir.mason .. "/" .. name .. "/"
  local lspconfig = vim.lsp.config

  lspconfig.ts_ls.setup({
    cmd = { "npm", "--prefix", root, "exec", name, "--", "--stdio" },
    filetypes = { "typescript", "javascript" },
    root_markers = { "package.json" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })
end

M.dap.install = function()
  local package = require("mason-registry").get_package(dap_server)
  if not package:is_installed() then
    package:install()
  end
end

M.dap.config = function()
  local dap = require("dap")
  dap.adapters["pwa-node"] = {
    type = "server",
    port = "${port}",
    executable = {
      command = "js-debug-adapter",
      args = { "${port}" },
    },
  }
end

return M
