return {
  "rachartier/tiny-inline-diagnostic.nvim",
  --event = "VeryLazy",
  lazy = true,
  main = "tiny-inline-diagnostic",
  keys = {
    {
      vim.g.keys.diagnostic.float,
      function()
        -- show diagnostics under the cursor
        vim.diagnostic.open_float()
      end,
      mode = "n",
      desc = "Float Diagnostics",
    },
    {
      vim.g.keys.diagnostic.list,
      function()
        -- send diagnostics to the location list
        vim.diagnostic.setloclist({ open = true })
      end,
      mode = "n",
      desc = "List Diagnostics",
    },
  },
  opts = {
    transparent_bg = true,
    transparent_cursorline = true,
    preset = "modern",
    hi = {
      error = "DiagnosticError",
      warn = "DiagnosticWarn",
      info = "DiagnosticInfo",
      hint = "DiagnosticHint",
      arrow = "NonText",
      background = "CursorLine",
      mixing_color = "None",
    },
    multilines = {
      enabled = true,
    },
    enable_on_insert = true,
  },
}
