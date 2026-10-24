vim.opt.clipboard:append("unnamedplus")

vim.o.relativenumber = true

vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"

vim.opt.termguicolors = true

vim.o.signcolumn = "yes"

vim.diagnostic.config({
  virtual_text = false,
})

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.lsp.inlay_hint.enable()

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", {})
