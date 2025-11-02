local dockerfile_server = "dockerfile-language-server"
local compose_server = "docker-compose-language-service"

local settings = require("config.settings")

local Dockerfile = { lsp = {}, dap = {} }
local Compose = { lsp = {}, dap = {} }

local M = { lsp = {}, dockerfile = Dockerfile, compose = Compose }

M.lsp.install = function()
  M.dockerfile.lsp.install()
  M.compose.lsp.install()
end

M.lsp.config = function()
  M.dockerfile.lsp.config()
  M.compose.lsp.config()
end

M.dockerfile.lsp.install = function()
  local server = require("mason-registry").get_package(dockerfile_server)
  if not server:is_installed() then
    vim.notify("Installing " .. dockerfile_server)
    server:install()
  end
  return M
end

M.compose.lsp.install = function()
  local server = require("mason-registry").get_package(compose_server)
  if not server:is_installed() then
    vim.notify("Installing " .. compose_server)
    server:install()
  end
  return M
end

M.dockerfile.lsp.config = function()
  vim.lsp.config("dockerls", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })
end

M.compose.lsp.config = function()
  local name = compose_server
  local root = settings.dir.mason .. "/" .. name .. "/"

  vim.lsp.config("docker_compose_language_service", {
    cmd = { "npm", "--prefix", root, "exec", "@microsoft/compose-language-service", "--", "--stdio" },
    filetypes = { "yaml" },
    root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
    single_file_support = true,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })
end

return M
