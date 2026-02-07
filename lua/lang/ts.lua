local M = {
  lsp = { name = "typescript-language-server" },
  dap = { name = "js-debug-adapter" },
}

M.lsp.root = vim.g.dirs.mason .. "/" .. M.lsp.name .. "/"

M.dap.bin = vim.g.dirs.mason .. "/js-debug-adapter/js-debug/src/dapDebugServer.js"

M.lsp.install = function()
  require("util.mason").safe_install(M.lsp.name)
end

M.lsp.config = function()
  vim.lsp.config("ts_ls", {
    cmd = { "npm", "--prefix", M.lsp.root, "exec", M.lsp.name, "--", "--stdio" },
    filetypes = { "typescript", "javascript" },
    root_markers = { "package.json" },
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.config.capabilities),
  })

  require("util.keymaps").lsp.attach()
end

M.dap.install = function()
  require("util.mason").safe_install(M.dap.name)
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

  dap.adapters["pwa-node"] = {
    type = "server",
    host = "::1",
    port = "${port}",
    executable = {
      command = runtimeExecutable,
      args = {
        M.dap.bin,
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
