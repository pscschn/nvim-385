local settings = require("config.settings")
local M = {}
M.lsp = {}
M.lsp.server = "gopls"
M.dap = {}
M.dap.server = "delve"

M.lsp.install = function()
  local package = require("mason-registry").get_package(M.lsp.server)
  if not package:is_installed() then
    package:install()
  end
end

M.lsp.config = function()
  local config = require("lspconfig")

  local bin = settings.dir.mason .. "/" .. M.lsp.server .. "/" .. M.lsp.server
  config.gopls.setup({
    cmd = { bin },
    filetypes = { "go" },
    root_dir = config.util.root_pattern("go.mod"),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        hints = {
          rangeVariableTypes = true,
          parameterNames = true,
          constantValues = true,
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          functionTypeParameters = true,
        },
      },
    },
    on_attach = function(_, _)
      require("lazy").load({
        plugins = {
          "neotest-golang",
          "nvim-lsp-endhints",
        },
      })
    end,
  })
end

M.dap.install = function()
  local package = require("mason-registry").get_package(M.dap.server)
  if not package:is_installed() then
    package:install()
  end
end

M.dap.config = function()
  require("lazy").load({
    plugins = {
      "nvim-dap-go",
      "nvim-dap-virtual-text",
    },
  })
  --local bin = settings.dir.mason .. "/" .. M.dap.server .. "/dlv"

  --local dap = require("dap")
  --dap.adapters.delve = {
  --type = "server",
  --port = "${port}",
  --executable = {
  --command = bin,
  --args = {"dap", "-l", "127.0.0.1:${port}"}
  --}
  --}
end

return M
