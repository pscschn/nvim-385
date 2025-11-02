local M = {}

local data = vim.fn.stdpath("data")

M.dir = {
  data = data,
  temp = data .. "/tmp",
  dap = data .. "/dap",
  lsp = data .. "/lsp",
  mason = data .. "/mason/packages",
  masonbin = data .. "/mason/bin",
}

return M
