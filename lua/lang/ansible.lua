local M = {}
M.lsp = {}
M.lsp.server = "ansible-language-server"

function M.install()
  local package = require("mason-registry").get_package(M.lsp.server)
  if not package:is_installed() then
    package:install()
  end
end

function M.config()

  local root = require("config.settings").dir.mason .. "/" .. M.lsp.server

  local config = require("lspconfig")
  config.ansiblels.setup({
    cmd = { "npm", "--prefix", root, "exec", M.lsp.server, "--", "--stdio" },
    filetypes = { "yaml", "yml" },
    root_dir = config.util.root_pattern("inventory*"),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {
      ansible = {
        ansible = { path = "ansible" },
        executionEnvironment = { enabled = false },
        python = { interpreterPath = "python3" },
        completion = {
          provideRedirectModules = true,
          provideModuleOptionAliases = true,
        },
      },
    },
  })
end