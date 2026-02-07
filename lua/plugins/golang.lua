return {
  {
    "fredrikaverpil/neotest-golang",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local neotest_golang_opts = {}
      require("util.treesitter").install({ "go" })
      require("neotest").setup({
        adapters = {
          require("neotest-golang")(neotest_golang_opts),
        },
      })
    end,
  },
  {
    "leoluz/nvim-dap-go",
    lazy = true,
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
    },
    opts = {
      dap_configurations = {
        {
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
      },
      delve = {
        path = require("lang.golang").dap.bin,
        initialize_timeout_sec = 20,
        port = "${port}",
        args = {},
        build_flags = {},
        detached = vim.fn.has("win32") == 0,
        cwd = nil,
      },
      tests = {
        verbose = false,
      },
    },
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },
}
