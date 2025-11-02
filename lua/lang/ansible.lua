local server = "ansible-language-server"
local linter = "ansible-lint"

local M = { lsp = {} }

function M.lsp.install()
  local registry = require("mason-registry")

  local lsp_pkg = registry.get_package(server)
  if not lsp_pkg:is_installed() then
    vim.notify("Installing " .. server)
    lsp_pkg:install()
  end

  local lint_pkg = registry.get_package(linter)
  if not lint_pkg:is_installed() then
    vim.notify("Installing " .. linter)
    lint_pkg:install()
  end
end

function M.lsp.config()
  local root = require("config.settings").dir.mason .. "/"

  local lsp_bin = root .. server .. "/node_modules/.bin/" .. server
  local lint_bin = root .. linter .. "/venv/bin/" .. linter

  vim.lsp.config("ansiblels", {
    cmd = { lsp_bin, "--stdio" },
    filetypes = { "yaml", "yml" },
    root_markers = { "inventory*", ".git" },
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
        validation = {
          enabled = true,
          lint = {
            enabled = true,
            path = lint_bin,
          },
        },
      },
    },
  })
end

return M
