local M = {
  lsp = { name = "roslyn" },
  dap = { bin = nil, name = "netcoredbg" },
}

---@type string dap binary
M.dap.bin = vim.g.dirs.mason .. "/netcoredbg/netcoredbg"

M.lsp.install = function()
  require("util.mason").safe_install(M.lsp.name)
end

M.lsp.config = function()
  require("lazy").load({
    plugins = {
      "roslyn.nvim",
      --"nvim-lsp-endhints",
      "explorer.dotnet.nvim",
    },
  })
end

M.dap.install = function()
  require("util.mason").safe_install(M.dap.name)
end

--- @param cfg ClangdDapCfg
M.dap.launch = function(cfg)
  local cwd = vim.g.dirs.cwd
  if cfg.bin then
    return cwd .. "/" .. cfg.bin
  end

  return vim.fn.input("Path to dll: ", cwd .. "/bin/Debug/", "file")
end

--- Dynamically create dap args
--- @param cfg ClangdDapCfg
M.dap.args = function(cfg)
  local args = cfg.args
  if cfg.makeArgs ~= nil then
    args = cfg.makeArgs()
  end
  return args
end

M.dap.cfg_or_new = function(cfg)
  if not cfg then
    return { args = {}, env = {}, bin = nil }
  end
  return cfg
end

--- @param cfg ClangdDapCfg
M.dap.config = function(cfg)
  local dap = require("dap")
  cfg = M.dap.cfg_or_new(cfg)
  vim.print(M.dap.bin)
  dap.adapters[M.dap.name] = {
    type = "executable",
    command = M.dap.bin,
    args = { "--interpreter=vscode" },
  }

  dap.configurations.cs = {
    {
      type = "netcoredbg",
      name = "Launch - netcoredbg",
      request = "launch",
      program = function()
        return M.dap.launch(cfg)
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = function()
        return M.dap.args(cfg)
      end,
      runInTerminal = false,
      env = cfg.env,
    },
  }
end

return M
