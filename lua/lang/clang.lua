local M = {}
M.cmake = {}
M.cmake.lsp = {}
M.cmake.lsp.server = "cmake-language-server"
M.lsp = {}
M.lsp.server = "clangd"
M.dap = {}
M.dap.server = "codelldb"

M.lsp.install = function()
    local server = require("mason-registry").get_package(M.lsp.server)

    if not server:is_installed() then
        server:install()
    end
    return M
end

M.lsp.config = function(args)
    local config = require("lspconfig")
    --local root = settings.dir.mason .. "/" .. M.lsp.server

    config.clangd.setup(
        {
            cmd = {"clangd"},
            args = args,
            filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "proto", "hpp"},
            root_dir = config.util.root_pattern("*cmake*", "Makefile"),
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            settings = {}
        }
    )
    return M
end

M.cmake.lsp.install = function()
    local server = require("mason-registry").get_package(M.cmake.lsp.server)

    if not server:is_installed() then
        server:install()
    end
    return M
end

M.cmake.lsp.config = function()
    local config = require("lspconfig")

    local root = require("config.settings").dir.mason .. "/"
    local bin = root .. M.cmake.lsp.server .. "/venv/bin/" .. M.cmake.lsp.server
    config.cmake.setup(
        {
            cmd = {bin},
            filetypes = {"cmake"},
            root_dir = config.util.root_pattern("CMakePresets.json", "CTestConfig.cmake", "CMakeLists.txt"),
            single_file_support = true,
            init_options = {
                buildDirectory = "build"
            }
        }
    )
    return M
end
return M
