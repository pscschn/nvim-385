local M = {}

local data = vim.fn.stdpath("data")
print(data)
M.dir = {
    data = data,
    temp = data .. "/tmp",
    dap = data .. "/dap",
    lsp = data .. "/lsp",
    mason = data .. "/mason/packages"
}

return M
