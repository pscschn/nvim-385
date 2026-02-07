return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      {
        vim.g.keys.dap.toggle_breakpoint,
        function()
          require("dap").toggle_breakpoint()
        end,
        mode = "n",
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>d?" .. vim.g.keys.dap.toggle_breakpoint,
        function()
          require("dap").toggle_breakpoint()
        end,
        mode = "n",
        desc = "Toggle Breakpoint",
      },
      { "<leader>d?" .. vim.g.keys.dap.continue, "<cmd>DapContinue<CR>", mode = "n", desc = "Run" },
      {
        vim.g.keys.dap.continue,
        "<cmd>DapContinue<CR>",
        mode = "n",
        desc = "Run",
      },
      {
        vim.g.keys.dap.step_into,
        "<cmd>DapStepInto<CR>",
        mode = "n",
        desc = "Step Into",
      },
      { "<leader>d?" .. vim.g.keys.dap.step_into, "<cmd>DapStepInto<CR>", mode = "n", desc = "Step Into" },
      {
        vim.g.keys.dap.step_over,
        "<cmd>DapStepOver<CR>",
        mode = "n",
        desc = "Step Over",
      },
      { "<leader>d?" .. vim.g.keys.dap.step_over, "<cmd>DapStepOver<CR>", mode = "n", desc = "Step Over" },
      {
        vim.g.keys.dap.step_out,
        "<cmd>DapStepOut<CR>",
        mode = "n",
        desc = "Step Out",
      },
      { "<leader>d?" .. vim.g.keys.dap.step_out, "<cmd>DapStepOut<CR>", mode = "n", desc = "Step Out" },
      {
        vim.g.keys.dap.restart,
        function()
          require("dap").restart()
        end,
        mode = "n",
        desc = "Restart DAP",
      },
      {
        "<leader>d?" .. vim.g.keys.dap.restart,
        function()
          require("dap").restart()
        end,
        mode = "n",
        desc = "Restart DAP",
      },
      {
        vim.g.keys.dap.terminate,
        function()
          require("dap").terminate()
        end,
        mode = "n",
        desc = "Terminate",
      },
      {
        "<leader>d?" .. vim.g.keys.dap.terminate,
        function()
          require("dap").terminate()
        end,
        mode = "n",
        desc = "Terminate",
      },
    },
    config = function(_, opts)
      -- https://github.com/mfussenegger/nvim-dap/discussions/355
      -- augroup to be able to trigger the autocommand explicitly for the first time
      vim.api.nvim_create_augroup("dap_colors", {})

      -- autocmd to enforce colors settings on any color scheme change
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = "dap_colors",
        pattern = "*",
        desc = "Set DAP marker colors and prevent color theme from resetting them",
        callback = function()
          -- Reuse current SignColumn background (except for DapStoppedLine)
          local sign_column_hl = vim.api.nvim_get_hl(0, { name = "SignColumn" })
          -- if bg or ctermbg aren't found, use bg = 'bg' (which means current Normal) and ctermbg = 'Black'
          -- convert to 6 digit hex value starting with #
          local sign_column_bg = (sign_column_hl.bg ~= nil) and ("#%06x"):format(sign_column_hl.bg) or "bg"
          local sign_column_ctermbg = (sign_column_hl.ctermbg ~= nil) and sign_column_hl.ctermbg or "Black"

          vim.api.nvim_set_hl(0, "DapStopped", { fg = "#2e8b2e", bg = sign_column_bg, ctermbg = sign_column_ctermbg })
          vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#39424b", ctermbg = "Green" })
          vim.api.nvim_set_hl(
            0,
            "DapBreakpoint",
            { fg = "#d16969", bg = sign_column_bg, ctermbg = sign_column_ctermbg }
          )
          vim.api.nvim_set_hl(
            0,
            "DapBreakpointRejected",
            { fg = "#888ca6", bg = sign_column_bg, ctermbg = sign_column_ctermbg }
          )
          vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#569cd6", bg = sign_column_bg, ctermbg = sign_column_ctermbg })
        end,
      })

      vim.api.nvim_exec_autocmds("ColorScheme", { group = "dap_colors" })

      vim.fn.sign_define("DapBreakpoint", {
        text = vim.g.signs.dap.DapBreakpoint,
        texthl = "DapBreakpoint",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint",
      })
      vim.fn.sign_define("DapBreakpointCondition", {
        text = vim.g.signs.dap.DapBreakpointCondition,
        texthl = "DapBreakpoint",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint",
      })
      vim.fn.sign_define("DapBreakpointRejected", {
        text = vim.g.signs.dap.DapBreakpointRejected,
        texthl = "DapBreakpoint",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint",
      })
      vim.fn.sign_define(
        "DapLogPoint",
        { text = vim.g.signs.dap.DapLogPoint, texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
      )
      vim.fn.sign_define(
        "DapStopped",
        { text = vim.g.signs.dap.DapStopped, texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
      )
    end,
  },
  {
    "igorlfs/nvim-dap-view",
    opts = {
      winbar = {
        show = true,
        sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
        controls = {
          enabled = true,
          position = "right",
          buttons = {
            "play",
            "step_into",
            "step_over",
            "step_out",
            "step_back",
            "run_last",
            "terminate",
            "disconnect",
          },
        },
      },
    },
    keys = {
      {
        vim.g.keys.dap.toggle_ui,
        mode = "n",
        desc = "Toggle Debug",
        function()
          require("dap-view").toggle()
        end,
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        commented = true,
      })
    end,
  },
}
