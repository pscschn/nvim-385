local mason = vim.g.dirs.mason

local M = {
  lsp = {
    name = "ansible-language-server",
    bin = mason .. "/ansible-language-server/node_modules/.bin/ansible-language-server",
    cmd_args = { "--stdio" },
    filetypes = { "yaml", "yml" },
    root_markers = { "inventory*", ".git" },
  },
  lint = {
    name = "ansible-lint",
    bin = mason .. "/ansible-lint/venv/bin/ansible-lint",
  },
  settings = {
    ansible = {
      ansible = { path = "ansible" },
      executionEnvironment = { enabled = false },
      python = { interpreterPath = "python3" },
      completion = {
        provideRedirectModules = true,
        provideModuleOptionAliases = true,
      },
      validation = {
        enabled = true,
        lint = {
          enabled = true,
          path = mason .. "/ansible-lint/venv/bin/ansible-lint",
        },
      },
    },
  },
}

M.lsp.install = function()
  local util = require("util.plugin").mason

  util.safe_install(M.lsp.name)
  util.safe_install(M.lint.name)
end

M.lsp.config = function()
  vim.lsp.config("ansiblels", {
    cmd = { M.lsp.bin, unpack(M.lsp.cmd_args()) },
    filetypes = M.lsp.filetypes,
    root_markers = M.lsp.root_markers,
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.config.capabilities),
    settings = M.settings,
  })

  vim.lsp.enable({ "ansiblels" })
end

M.enable = function()
  M.lsp.install()
  M.lsp.config()
end

return M
