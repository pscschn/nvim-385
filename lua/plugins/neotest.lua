return {
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
  },
  config = function(_, _)
    require("which-key").add({ vim.g.keys.groups.test, group = "Test" })

    vim.keymap.set("n", vim.g.keys.tests.toggle_ui, function()
      -- position the panels all at the bottom
      local neotest = require("neotest")
      local window = require("util.window")

      local summary = "Neotest Summary"
      local output = "Neotest Output Panel"

      neotest.summary.toggle()
      neotest.output_panel.toggle()

      local map = window.tabpage_map_win_names()
      -- don't try to adjust windows when toggled off
      if map[summary] == nil then
        return
      end

      vim.api.nvim_win_call(map[summary], function()
        vim.cmd("wincmd H")
      end)

      vim.api.nvim_win_call(map[output], function()
        vim.cmd("wincmd L")
      end)

      vim.cmd("wincmd K")
      vim.cmd("resize +8")
    end, { desc = "Toggle Layout" })
  end,
}
