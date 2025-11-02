return {
  {
    "chrisgrieser/nvim-lsp-endhints",
    lazy = true,
    opts = {
      icons = {
        type = "󰰦 ",
        parameter = "󰰚 ",
        offspec = " ", -- hint kind not defined in official LSP spec
        unknown = " ", -- hint kind is nil
      },
      label = {
        truncateAtChars = 20,
        padding = 1,
        marginLeft = 0,
        sameKindSeparator = ", ",
      },
      extmark = {
        priority = 50,
      },
      autoEnableHints = true,
    },
    config = function(_, opts)
      local endhints = require("lsp-endhints")
      endhints.setup(opts)
      endhints.enable()
    end,
  },
  {
    "hedyhli/outline.nvim",
    config = function()
      vim.keymap.set("n", "<leader>lo", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

      require("outline").setup({})
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    main = "tiny-inline-diagnostic",
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
  },
}
