local M = {
  lsp = { name = "rust-analyzer" },
  dap = { name = "codelldb" },
}

M.lsp.root = vim.g.dirs.mason .. "/codelldb/"
M.lsp.bin = M.lsp.root .. "codelldb"
M.lsp.liblldb = M.lsp.root .. "extension/lib/liblldb.so"

M.lsp.install = function()
  require("util.plugin").mason.safe_install(M.lsp.name)
end

M.lsp.config = function()
  require("config.lsp").attach()
  require("util.plugin").manager.load_plugin({
    "rustaceanvim",
  })
end

M.dap.install = function()
  require("util.plugin").mason.safe_install(M.dap.name)
end

M.dap.config = function()
  local cfg = require("rustaceanvim.config")
  vim.g.rustaceanvim = function()
    return {
      dap = {
        adapter = cfg.get_codelldb_adapter(M.lsp.bin, M.lsp.liblldb),
      },
    }
  end
end

M.enable = function()
  M.lsp.install()
  M.lsp.config()

  M.dap.install()
  M.dap.config()
end

return M
