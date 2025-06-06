return {
  "nvim-treesitter/nvim-treesitter",
  -- need treesitter only for csharp test plugins, not using it otherwise,
  -- therefore settings this is lazy
  lazy = true,
  build = ":TSUpdate",
}
