local settings = require("config.settings")
local lsp_server = "vue-language-server"

local M = { lsp = {} }

M.lsp.install = function()
  local server = require("mason-registry").get_package(lsp_server)
  if not server:is_installed() then
    vim.notify("Installing" .. lsp_server)
    server:install()
  end
end

M.lsp.config = function()
  local root = settings.dir.mason .. "/" .. lsp_server .. "/"
  local lspconfig = vim.lsp.config

  lspconfig.volar.setup({
    cmd = { "npm", "--prefix", root, "exec", lsp_server, "--", "--stdio" },
    filetypes = { "vue", "javascript", "typescript", "typescriptreact" },
    root_markers = { "package.json", "vite.config.js" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
    settings = {
      typescript = {
        inlayHints = {
          enumMemberValues = {
            enabled = true,
          },
          functionLikeReturnTypes = {
            enabled = true,
          },
          propertyDeclarationTypes = {
            enabled = true,
          },
          parameterTypes = {
            enabled = true,
            suppressWhenArgumentMatchesName = true,
          },
          variableTypes = {
            enabled = true,
          },
        },
      },
    },
  })
end

return M
