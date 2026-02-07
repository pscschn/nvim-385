local M = { lsp = { name = "vue-language-server" } }

M.lsp.root = vim.g.dirs.mason .. "/" .. M.lsp.name .. "/"

M.lsp.install = function()
  require("util.mason").safe_install(M.lsp.name)
end

M.lsp.config = function()
  local settings = {
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
  }
  vim.lsp.config("volar", {
    cmd = { "npm", "--prefix", M.lsp.root, "exec", M.lsp.lsp_server, "--", "--stdio" },
    filetypes = { "vue", "javascript", "typescript", "typescriptreact" },
    root_markers = { "package.json", "vite.config.js" },
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.config.capabilities),
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
    settings = settings,
  })

  require("util.keymaps").lsp.attach()
end

return M
