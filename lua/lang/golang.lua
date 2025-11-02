local settings = require("config.settings")

local lsp_server = "gopls"
local dap_server = "delve"

local M = { lsp = {}, dap = { bin = nil } }

--- @type string dap binary
M.dap.bin = settings.dir.mason .. "/" .. dap_server .. "/dlv"

M.lsp.install = function()
  local package = require("mason-registry").get_package(lsp_server)
  if not package:is_installed() then
    vim.notify("Installing" .. lsp_server)
    package:install()
  end
end

M.lsp.config = function()
  local config = vim.lsp.config

  local lsp_bin = settings.dir.mason .. "/" .. lsp_server .. "/" .. lsp_server
  config.gopls.setup({
    cmd = { lsp_bin },
    filetypes = { "go" },
    root_markers = { "go.mod" },
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

  require("lib.lsp").set_keymaps()
end

M.dap.install = function()
  local package = require("mason-registry").get_package(dap_server)
  if not package:is_installed() then
    vim.notify("Installing" .. dap_server)
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
end

return M
