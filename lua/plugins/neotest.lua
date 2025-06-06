local window = require("lib.window")
local summary = "Neotest Summary"
local output = "Neotest Output Panel"

local toggle_layout = function()
  local neotest = require("neotest")
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
end

return {
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    --"nvim-treesitter/nvim-treesitter"
  },
  config = function(_, opts)
    require("which-key").add({ "<leader>t", group = "Test" })

    vim.keymap.set("n", "<leader>tt", function()
      toggle_layout()
    end, { desc = "Toggle Layout" })
  end,
}
