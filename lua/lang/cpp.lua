local M = {}
M.lsp = {}
M.lsp.server = "clangd"
M.dap = {}
M.dap.server = "codelldb"

M.lsp.install = function()
  local server = require("mason-registry").get_package(M.lsp.server)

  if not server:is_installed() then
    server:install()
  end
  return M
end

M.lsp.config = function()
  local config = require("lspconfig")
  --local root = settings.dir.mason .. "/" .. M.lsp.server

  config.clangd.setup({
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "hpp"},
    root_dir = config.util.root_pattern("*cmake*", "Makefile"),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {},
  })
  return M
end
return M