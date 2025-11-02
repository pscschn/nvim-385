vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard:append("unnamedplus")

vim.o.relativenumber = true

vim.opt.termguicolors = true

vim.o.signcolumn = "yes"

vim.diagnostic.config({
  virtual_text = false,
})

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.lsp.inlay_hint.enable(true)
--vim.o.winbar = " "
--
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
    vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#d16969", bg = sign_column_bg, ctermbg = sign_column_ctermbg })
    vim.api.nvim_set_hl(
      0,
      "DapBreakpointRejected",
      { fg = "#888ca6", bg = sign_column_bg, ctermbg = sign_column_ctermbg }
    )
    vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#569cd6", bg = sign_column_bg, ctermbg = sign_column_ctermbg })
  end,
})

-- executing the settings explicitly for the first time
vim.api.nvim_exec_autocmds("ColorScheme", { group = "dap_colors" })

vim.fn.sign_define(
  "DapBreakpoint",
  { text = "󰄯", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "󰯲", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapBreakpointRejected",
  { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapLogPoint",
  { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
)
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })