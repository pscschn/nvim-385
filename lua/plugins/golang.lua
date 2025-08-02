local treesitter_install = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "go" },
    sync_install = true,
    auto_install = true,
  })
end

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
      local neotest_golang_opts = {} -- Specify custom configuration
      treesitter_install()
      require("neotest").setup({
        adapters = {
          require("neotest-golang")(neotest_golang_opts), -- Registration
        },
      })
    end,
  },
  "leoluz/nvim-dap-go",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
  },
  lazy = true,
  opts = {
    dap_configurations = {
      {
        -- Must be "go" or it will be ignored by the plugin
        type = "go",
        name = "Attach remote",
        mode = "remote",
        request = "attach",
      },
    },
    delve = {
      path = require("config.settings").dir.mason .. "/" .. require("lang.golang").dap.server .. "/dlv",
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
    treesitter_install()
    require("dap-go").setup(opts)
  end,
}
