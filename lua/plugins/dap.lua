return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        mode = "n",
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>d?<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        mode = "n",
        desc = "Toggle Breakpoint",
      },
      { "<leader>d?<F5>", "<cmd>DapContinue<CR>", mode = "n", desc = "Run" },
      { "<F5>", "<cmd>DapContinue<CR>", mode = "n", desc = "Run" },
      { "<F11>", "<cmd>DapStepInto<CR>", mode = "n", desc = "Step Into" },
      { "<leader>d?<F11>", "<cmd>DapStepInto<CR>", mode = "n", desc = "Step Into" },
      { "<F10>", "<cmd>DapStepOver<CR>", mode = "n", desc = "Step Over" },
      { "<leader>d?<F10>", "<cmd>DapStepOver<CR>", mode = "n", desc = "Step Over" },
      { "<F12>", "<cmd>DapStepOut<CR>", mode = "n", desc = "Step Out" },
      { "<leader>d?<F12>", "<cmd>DapStepOut<CR>", mode = "n", desc = "Step Out" },
      {
        "<F4>",
        function()
          require("dap").restart()
        end,
        mode = "n",
        desc = "Restart DAP",
      },
      {
        "<leader>d?<F4>",
        function()
          require("dap").restart()
        end,
        mode = "n",
        desc = "Restart DAP",
      },
      {
        "<F3>",
        function()
          require("dap").terminate()
        end,
        mode = "n",
        desc = "Terminate",
      },
      {
        "<leader>d?<F3>",
        function()
          require("dap").terminate()
        end,
        mode = "n",
        desc = "Terminate",
      },
    },
    config = function() end,
  },
  {
    "igorlfs/nvim-dap-view",
    ---@module 'dap-view'
    ---@type dapview.Config
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
            }
        },
      },
    },
  keys = {
    {
      "<leader>dt",
      mode = "n",
      desc = "Toggle ui",
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