local settings = require("config.settings")

local dap_server = "js-debug-adapter"
local lsp_server = "typescript-language-server"

local M = { lsp = {}, dap = {} }

M.lsp.install = function()
  local name = lsp_server
  local server = require("mason-registry").get_package(name)
  if not server:is_installed() then
    vim.notify("Installing" .. name)
    server:install()
  end
end

M.lsp.config = function()
  local name = lsp_server
  local root = settings.dir.mason .. "/" .. name .. "/"

  vim.lsp.config("ts_ls", {
    cmd = { "npm", "--prefix", root, "exec", name, "--", "--stdio" },
    filetypes = { "typescript", "javascript" },
    root_markers = { "package.json" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })

  require("lib.lsp").set_keymaps()
end

M.dap.install = function()
  local package = require("mason-registry").get_package(dap_server)
  if not package:is_installed() then
    package:install()
  end
end

---@class TSDapCfg
---@field envFile? string
---@field runtimeExecutable? string
---@field runtimeArgs? table arguments to pass to runtimeExecutable
---@field args? table arguments to pass to the program

--- @param cfg? TSDapCfg
M.dap.config = function(cfg)
  local dap = require("dap")

  if cfg == nil then
    cfg = {}
  end

  local args = {}
  local runtimeArgs = {}
  local runtimeExecutable = "node"

  if not cfg.args then
    args = cfg.args
  end

  if cfg.runtimeExecutable ~= nil then
    runtimeExecutable = cfg.runtimeExecutable
  end

  if cfg.runtimeArgs ~= nil then
    runtimeArgs = cfg.runtimeArgs
  end

  local js_debug_path = require("config.settings").dir.mason .. "/js-debug-adapter"

  dap.adapters["pwa-node"] = {
    type = "server",
    host = "::1",
    port = "${port}",
    executable = {
      command = runtimeExecutable,
      args = {
        js_debug_path .. "/js-debug/src/dapDebugServer.js",
        "${port}",
      },
    },
  }

  for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
        runtimeExecutable,
        runtimeArgs,
        args,
        envFile = cfg.envFile,
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
  end
end

return M
