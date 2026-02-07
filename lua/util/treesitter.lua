local M = {}

M.install = function(pkg)
  require("lazy").load({
    plugins = {
      "nvim-treesitter",
    },
  })
  require("nvim-treesitter.install").install(pkg)
end

return M
