local settings = require("config.settings")
local M = {}
M.dockerfile = {}
M.dockerfile.lsp = {}
M.dockerfile.lsp.server = "dockerfile-language-server"

M.compose = {}
M.compose.lsp = {}
M.compose.lsp.server = "docker-compose-language-service"

M.dockerfile.lsp.install = function()
  local server = require("mason-registry").get_package(M.dockerfile.lsp.server)
  if not server:is_installed() then
    server:install()
  end
  return M
end

M.compose.lsp.install = function()
  local server = require("mason-registry").get_package(M.compose.lsp.server)
  if not server:is_installed() then
    server:install()
  end
  return M
end

M.dockerfile.lsp.config = function()
  require("lspconfig").dockerls.setup({
    --on_attach = function(client, bufnr)end,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })
end


M.compose.lsp.config = function()
  local name = M.compose.lsp.server
  local root = settings.dir.mason .. "/" .. name .. "/"
  local lspconfig = require("lspconfig")

  lspconfig.docker_compose_language_service.setup({
    cmd = { "npm", "--prefix", root, "exec", "@microsoft/compose-language-service", "--", "--stdio" },
    filetypes = { 'yaml' },
    root_dir = lspconfig.util.root_pattern('*'),
    --lspconfig.util.root_pattern('docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml'),
    single_file_support = true,
    --on_attach = function(client, bufnr)end,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })
end

return M