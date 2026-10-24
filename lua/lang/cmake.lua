local M = {
  lsp = { name = "cmake-language-server" },
}

M.lsp.bin = vim.g.dirs.mason .. "/" .. M.lsp.name .. "/venv/bin/" .. M.lsp.name

M.lsp.install = function()
  require("util.plugin").mason.safe_install(M.lsp.name)
end

M.lsp.config = function()
  vim.lsp.config("cmake", {
    cmd = { M.lsp.bin },
    filetypes = { "cmake" },
    root_markers = { "CMakePresets.json", "CTestConfig.cmake", "CMakeLists.txt" },
    single_file_support = true,
    init_options = {
      buildDirectory = "build",
    },
  })

  vim.lsp.enable({ "cmake" })
end

M.enable = function()
  M.lsp.install()
  M.lsp.config()
end

return M
