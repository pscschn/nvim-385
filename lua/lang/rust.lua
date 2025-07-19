local M = {}
M.lsp = {}
M.dap = {}
M.dap.adapter = "codelldb"

local server = "rust-analyzer"

M.lsp.install = function()
    local package = require("mason-registry").get_package(server)
    if not package:is_installed() then
        package:install()
    end
end

M.lsp.config = function()
    require("lazy").load(
        {
            plugins = {
                "rustaceanvim"
            }
        }
    )
end

M.dap.install = function()
    local package = require("mason-registry").get_package(M.dap.adapter)
    if not package:is_installed() then
        package:install()
    end
    return M
end

M.dap.config = function()
    local root = require("config.settings").dir.mason .. "/codelldb/"
    local codelldb_path = root .. "codelldb"
    local liblldb_path = root .. "extension/lib/liblldb.so"
    local cfg = require("rustaceanvim.config")
    vim.g.rustaceanvim = function()
        return {
            dap = {
                adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
            }
        }
    end
end

return M
