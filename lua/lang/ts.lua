local settings = require("config.settings")

local M = {}
M.lsp = {}
M.lsp.server = "typescript-language-server"
M.dap = {}
M.dap.server = "js-debug-adapter"

M.lsp.install = function()
  local name = M.lsp.server
  local server = require("mason-registry").get_package(name)
  if not server:is_installed() then
    vim.notify("Installing" .. name)
    server:install()
  end
end

M.lsp.config = function()
  local name = M.lsp.server
  local root = settings.dir.mason .. "/" .. name .. "/"
  local lspconfig = require("lspconfig")

  lspconfig.ts_ls.setup({
    cmd = { "npm", "--prefix", root, "exec", name, "--", "--stdio" },
    --on_attach = utils.lsp.on_attach,
    filetypes = { "typescript", "javascript" },
    root_dir = lspconfig.util.root_pattern("package.json"),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })
end

M.dap.install = function()
  local package = require("mason-registry").get_package(M.dap.adapter)
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
