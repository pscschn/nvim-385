local data = vim.fn.stdpath("data")
local home = vim.fs.normalize("~")
vim.g.dirs = {
  cwd = vim.fn.getcwd(),
  data = data,
  temp = data .. "/tmp",
  dap = data .. "/dap",
  lsp = data .. "/lsp",
  mason = data .. "/mason/packages",
  masonbin = data .. "/mason/bin",
  lazy = data .. "/lazy/lazy.nvim",
  project_settings = "./.nvim/settings.lua",
  home = home,
  bun = {
    global_modules = home .. "/.bun/install/global/node_modules",
  },
}
