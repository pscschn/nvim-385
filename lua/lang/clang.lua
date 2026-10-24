local M = {
  lsp = {
    name = "clangd",
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "hpp" },
    root_markers = { "*cmake*", "Makefile", "CMakeLists.txt" },
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.config.capabilities),
    settings = {
      clangd = {
        InlayHints = {
          Designators = true,
          Enabled = true,
          ParameterNames = true,
          DeducedTypes = true,
        },
        fallbackFlags = { "-std=c++20" },
      },
    },
  },
  dap = {
    name = "codelldb",
    bin = vim.g.dirs.masonbin .. "/codelldb",
  },
}

M.lsp.install = function()
  require("util.plugin").mason.safe_install(M.lsp.name)
end

M.lsp.config = function(args)
  local cmd = vim.list_extend({ "clangd" }, args)

  vim.lsp.config("clangd", {
    cmd = cmd,
    filetypes = M.lsp.filetypes,
    root_markers = M.lsp.root_markers,
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.config.capabilities),
    settings = M.lsp.settings,
  })

  require("config.lsp").attach()

  vim.lsp.enable({ "clangd" })
end

M.dap.install = function()
  require("util.plugin").mason.safe_install(M.dap.name)

  require("util.plugin").manager.load_plugin({
    "nvim-dap-virtual-text",
  })
end

---@class ClangdDapCfg
---@field bin? string path to executable
---@field env? table environment variables
---@field makeArgs? function provide additional args on launch
---@field args? [string] launch arguments

--- @param cfg ClangdDapCfg
M.dap.launch = function(cfg)
  local cwd = vim.g.dirs.cwd
  if cfg.bin then
    return cwd .. "/" .. cfg.bin
  end

  return vim.fn.input("Path to executable: ", cwd .. "/", "file")
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
    return { args = {}, env = {}, bin = nil, makeArgs = nil }
  end
  return cfg
end

--- @param cfg ClangdDapCfg
M.dap.config = function(cfg)
  local dap = require("dap")
  cfg = M.dap.cfg_or_new(cfg)

  dap.adapters.codelldb = {
    name = "codelldb server",
    type = "server",
    port = "${port}",
    executable = {
      command = M.dap.bin,
      args = { "--port", "${port}" },
    },
  }

  local function makeConfig()
    return {
      name = "Launch C executable",
      type = "codelldb",
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
    }
  end

  dap.configurations.cpp = { makeConfig() }
  dap.configurations.c = { makeConfig() }
end

M.enable = function()
  M.lsp.install()
  M.lsp.config()

  M.dap.install()
  M.dap.config()
end

return M
