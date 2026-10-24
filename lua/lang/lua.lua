local M = { lsp = { name = "lua-language-server" }, enable = nil }

M.lsp.root = vim.g.dirs.mason .. "/" .. M.lsp.name .. "/"
M.lsp.bin = M.lsp.root .. M.lsp.name

M.enable = function()
  M.lsp.install()
  M.lsp.config()
end

M.lsp.install = function()
  require("util.plugin").mason.safe_install(M.lsp.name)
end

M.lsp.config = function()
  local settings = {
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
        enable = false,
      },
      hint = { enable = true },
    },
  }

  vim.lsp.config("lua_ls", {
    cmd = { M.lsp.bin },
    filetypes = { "lua" },
    root_markers = { ".git", "*.rockspec", "init.lua" },
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.config.capabilities),
    settings = settings,
  })

  require("config.lsp").attach()

  vim.lsp.enable({ "lua_ls" })
end

return M
