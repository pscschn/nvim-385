require 'lazy-config'
require 'options' 
require 'keymaps'

vim.opt.number = true
vim.g.mapleader = " " 
vim.g.maplocalleader = "\\"

require("lazy").setup({
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.6',

		dependencies = { 'nvim-lua/plenary.nvim' }
	}, 
	{
		"aaronhallaert/advanced-git-search.nvim",
		cmd = { "AdvancedGitSearch" },}

	})

