return {
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
}
