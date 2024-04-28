local builtin = require('telescope.builtin')

vim.keymap.set(
"n",
"<leader>fl",
'<cmd>lua require("telescope.builtin").live_grep({ glob_pattern = "!{spec,test}"})<CR>',
{ desc = "Live Grep Code" }
)
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })

vim.keymap.set("n", "<leader>fg", builtin.grep_string, { desc = "Search for selected string" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Symbols" })
vim.keymap.set("n", "<leader>fi", "<cmd>AdvancedGitSearch<CR>", { desc = "AdvancedGitSearch" })
vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Search Git Commits" })
vim.keymap.set("n", "<leader>gb", builtin.git_bcommits, { desc = "Search Git Commits for Buffer" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })		
vim.keymap.set("n", "<leader>mp", builtin.man_pages, { desc = "List man page entries" })		
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
		layout_config = { width = 0.7 },
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

require("telescope").load_extension("advanced_git_search")
