local M = {
  lsp = { name = "typescript-language-server" },
  dap = { name = "js-debug-adapter" },
}

M.lsp.root = vim.g.dirs.mason .. "/" .. M.lsp.name

M.dap.bin = vim.g.dirs.mason .. "/js-debug-adapter/js-debug/src/dapDebugServer.js"

local function lsp_bun_install()
  local result = nil

  local cmd = vim.system({ "bun", "install", "-g", M.lsp.name })

  while result == nil or result.code == nil do
    result = cmd:wait(1000)
  end

  if result.code == 0 then
    return
  end

  vim.api.nvim_echo({
    { "[Installer Error (" .. M.lsp.name .. ")]: ", "ErrorMsg" },
    { result.stderr, "None" },
  }, true, {})
end

---@class TsLspCfg
---@field useBun? boolean use bun or npm through Mason by default

-- --- @param cfg TsLspCfg
M.lsp.install = function() --cfg)
  --if cfg == nil then
  --cfg = { useBun = false }
  --end

  --if cfg.useBun then
  --return lsp_bun_install()
  --end

  require("util.mason").safe_install(M.lsp.name)
end

-- --- @param cfg TsLspCfg
M.lsp.config = function() --cfg)
  --if cfg == nil then
  --cfg = { useBun = false }
  --end

  local cmd = nil
  --if cfg.useBun then
  --cmd = { "npx", M.lsp.name, "--", "--stdio" }
  --else
  cmd = { "npm", "--prefix", M.lsp.root, "exec", M.lsp.name, "--", "--stdio" }
  --end

  vim.lsp.config("ts_ls", {
    cmd = cmd,
    filetypes = { "typescript", "javascript" },
    root_markers = { "package.json" },
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.config.capabilities),
  })
  require("util.keymaps").lsp.attach()

  vim.lsp.enable({ "ts_ls" })
end

M.dap.install = function()
  require("util.mason").safe_install(M.dap.name)
end

M.dap.configurations = {}
M.dap.configurations.at_cursor = {
  obj = nil,
  builder = function()
    return {
      type = "pwa-node",
      request = "launch",
      name = "Debug current test",
      runtimeExecutable = "npx",
      args = function()
        local cfg = {}
        local line = require("util.lsp").functions.at_cursor()

        if line == nil then
          return cfg
        end

        local test_name = line:match("[\"'](.-)[\"']")

        if test_name == nil then
          vim.print("No test name found")
          return cfg
        end

        local filepath = vim.fn.expand("%")

        local dir = vim.fn.fnamemodify(filepath, ":h")
        local filename = vim.fn.fnamemodify(filepath, ":t")
        cfg = {
          "jest",
          "-t",
          test_name,
          "--testPathPattern",
          filename,
          "--roots",
          "./" .. dir,
        }
        return cfg
      end,
      cwd = vim.g.dirs.cwd,
      console = "integratedTerminal",
    }
  end,
}

--@param cfg TSDapCfg
M.dap.configurations.launch_file = {
  obj = nil,
  builder = function(cfg)
    return {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
      cfg.runtimeExecutable,
      cfg.runtimeArgs,
      cfg.args,
      envFile = cfg.envFile,
    }
  end,
}

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

  if not cfg.args then
    cfg.args = {}
  end

  if not cfg.runtimeExecutable then
    cfg.runtimeExecutable = "node"
  end

  if not cfg.runtimeArgs then
    cfg.runtimeArgs = {}
  end

  dap.adapters["pwa-node"] = {
    type = "server",
    host = "::1",
    port = "${port}",
    executable = {
      command = cfg.runtimeExecutable,
      args = {
        M.dap.bin,
        "${port}",
      },
    },
  }

  M.dap.configurations.launch_file.obj = M.dap.configurations.launch_file.builder(cfg)
  M.dap.configurations.at_cursor.obj = M.dap.configurations.at_cursor.builder()

  for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
      M.dap.configurations.launch_file.obj,
      M.dap.configurations.at_cursor.obj,
    }
  end

  vim.keymap.set("n", vim.g.keys.tests.run_at_cursor, function()
    require("dap").run(M.dap.configurations.at_cursor.obj)
  end, { desc = "Debug jest test at cursor" })
end

return M