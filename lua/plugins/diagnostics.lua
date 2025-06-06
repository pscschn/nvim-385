return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  main = "tiny-inline-diagnostic",
  opts = {
    preset = "minimal",
    hi = {
      error = "DiagnosticError",
      warn = "DiagnosticWarn",
      info = "DiagnosticInfo",
      hint = "DiagnosticHint",
      arrow = "NonText",
      background = "CursorLine",
      --background = require("config.colors").mocha.base,
      mixing_color = "None",
    },
  },
}
