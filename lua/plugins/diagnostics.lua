return {
  {
    "chrisgrieser/nvim-lsp-endhints",
    lazy = true,
    opts = {
      icons = {
        type = vim.g.signs.diagnostic.type,
        parameter = vim.g.signs.diagnostic.parameter,
        offspec = vim.g.signs.diagnostic.offspec,
        unknown = vim.g.signs.diagnostic.unknown,
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
      vim.keymap.set("n", vim.g.keys.lsp.toggle_outline, "<cmd>Outline<CR>", { desc = "Toggle Outline" })

      require("outline").setup({})
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
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
  },
}
