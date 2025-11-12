local dap_adapter = "codelldb"
local server = "rust-analyzer"

local M = { lsp = {}, dap = {} }

M.lsp.install = function()
  local package = require("mason-registry").get_package(server)
  if not package:is_installed() then
    vim.notify("Installing " .. server)
    package:install()
  end
end

M.lsp.config = function()
  require("lazy").load({
    plugins = {
      "rustaceanvim",
    },
  })
end

M.dap.install = function()
  local package = require("mason-registry").get_package(dap_adapter)
  if not package:is_installed() then
    package:install()
  end
  return M
end

M.dap.config = function()
  local root = require("config.settings").dir.mason .. "/codelldb/"
  local codelldb_path = root .. "codelldb"
  local liblldb_path = root .. "extension/lib/liblldb.so"
  local cfg = require("rustaceanvim.config")
  vim.g.rustaceanvim = function()
    return {
      dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    }
  end
end

return M
