local settings = require("config.settings")

local M = {}
M.lsp = {}

local name = "lua-language-server"

M.lsp.install = function()
  local server = require("mason-registry").get_package(name)
  if not server:is_installed() then
    vim.notify("Installing" .. name)
    server:install()
  end
end

M.lsp.config = function()
  local root = settings.dir.mason .. "/" .. name .. "/"
  local lspconfig = require("lspconfig")
  lspconfig.lua_ls.setup({
    cmd = { root .. name },
    filetypes = { "lua" },
    root_dir = lspconfig.util.root_pattern(".git", "*.rockspec", "init.lua"),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false, -- Stop sending telemetry data
        },
      },
    },
  })
end

return M
