local M = {
  lsp = { name = "ansible-language-server" },
  lint = { name = "ansible-lint" },
}

M.lsp.bin = vim.g.dirs.mason .. "/" .. M.lsp.name .. "/node_modules/.bin/" .. M.lsp.name
M.lint.bin = vim.g.dirs.mason .. "/" .. M.lint.name .. "/venv/bin/" .. M.lint.name

M.lsp.install = function()
  local util = require("util.mason")

  util.safe_install(M.lsp.name)
  util.safe_install(M.lint.name)
end

M.lsp.config = function()
  local settings = {
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
          path = M.lint.bin,
        },
      },
    },
  }

  vim.lsp.config("ansiblels", {
    cmd = { M.lsp.bin, "--stdio" },
    filetypes = { "yaml", "yml" },
    root_markers = { "inventory*", ".git" },
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.config.capabilities),
    settings = settings,
  })

  vim.lsp.enable({ "ansiblels" })
end

return M
