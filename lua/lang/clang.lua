local cmake_server = "cmake-language-server"
local clangd_server = "clangd"
local dap_server = "codelldb"
local cwd = vim.fn.getcwd()

local Cmake = { lsp = {}, dap = {} }
local Clangd = { lsp = {}, dap = {} }
local M = { lsp = {}, dap = {}, cmake = Cmake, clangd = Clangd }

Cmake.lsp.install = function()
  local server = require("mason-registry").get_package(cmake_server)

  if not server:is_installed() then
    server:install()
  end
  return Cmake
end

Cmake.lsp.config = function()
  local root = require("config.settings").dir.mason .. "/"
  local bin = root .. cmake_server .. "/venv/bin/" .. cmake_server

  vim.lsp.config("cmake", {
    cmd = { bin },
    filetypes = { "cmake" },
    root_markers = { "CMakePresets.json", "CTestConfig.cmake", "CMakeLists.txt" },
    single_file_support = true,
    init_options = {
      buildDirectory = "build",
    },
  })
  return Cmake
end

Clangd.lsp.install = function()
  local server = require("mason-registry").get_package(clangd_server)

  if not server:is_installed() then
    vim.notify("Installing " .. clangd_server)
    server:install()
  end
end

Clangd.lsp.config = function(args)
  vim.lsp.config("clangd", {
    cmd = { "clangd" },
    args = args,
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "hpp" },
    root_markers = { "*cmake*", "Makefile", "CMakeLists.txt" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {},
  })

  require("lib.lsp").set_keymaps()
end

M.lsp.install = function()
  M.clangd.lsp.install()
  M.cmake.lsp.install()
end

M.lsp.config = function()
  M.clangd.lsp.config()
  M.cmake.lsp.config()
end

M.dap.install = function()
  local package = require("mason-registry").get_package(dap_server)
  if not package:is_installed() then
    vim.notify("Installing " .. dap_server)
    package:install()
  end

  require("lazy").load({
    plugins = {
      "nvim-dap-virtual-text",
    },
  })
end

---@class ClangdDapCfg
---@field bin? string path to executable
---@field env? table environment variables
---@field args? [string] launch arguments

--- @param cfg ClangdDapCfg
M.dap.config = function(cfg)
  if not cfg then
    cfg = {}
  end

  local bin = require("config.settings").dir.masonbin .. "/codelldb"
  local dap = require("dap")
  dap.adapters.codelldb = {
    name = "codelldb server",
    type = "server",
    port = "${port}",
    executable = {
      command = bin,
      args = { "--port", "${port}" },
    },
  }

  local args = cfg.args
  if not cfg.args then
    args = {}
  end
  local env = cfg.env
  if not cfg.env then
    args = {}
  end

  dap.configurations.c = {
    {
      name = "Launch C executable",
      type = "codelldb",
      request = "launch",
      program = function()
        if cfg.bin then
          return cwd .. "/" .. cfg.bin
        end

        return vim.fn.input("Path to executable: ", cwd .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args,
      runInTerminal = false,
      env,
    },
  }
end

return M
