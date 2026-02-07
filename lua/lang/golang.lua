local M = {
  lsp = { name = "gopls" },
  dap = { name = "delve", bin = nil },
}

M.lsp.bin = vim.g.dirs.mason .. "/" .. M.lsp.name .. "/" .. M.lsp.name
--- @type string dap binary
M.dap.bin = vim.g.dirs.mason .. "/" .. M.dap.name .. "/dlv"

M.lsp.install = function()
  require("util.mason").safe_install(M.lsp.name)
end

M.lsp.config = function()
  local config = vim.lsp.config
  local settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      hints = {
        rangeVariableTypes = true,
        parameterNames = true,
        constantValues = true,
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        functionTypeParameters = true,
      },
    },
  }

  config.gopls.setup({
    cmd = { M.lsp.bin },
    filetypes = { "go" },
    root_markers = { "go.mod" },
    capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities),
    settings = settings,
    on_attach = function(_, _)
      require("lazy").load({
        plugins = {
          "neotest-golang",
          "nvim-lsp-endhints",
        },
      })
    end,
  })

  require("util.keymaps").lsp.attach()
end

M.dap.install = function()
  require("util.mason").safe_install(M.dap.name)
end

M.dap.config = function()
  require("lazy").load({
    plugins = {
      "nvim-dap-go",
      "nvim-dap-virtual-text",
    },
  })
end

return M
