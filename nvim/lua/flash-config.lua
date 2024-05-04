local status_ok, flash = pcall(require, "flash")
if not status_ok then
  return
end


vim.keymap.set('n', '<leader>ls', flash.jump, {desc = 'Flash jump'})
vim.keymap.set('n', '<leader>lt', flash.treesitter, {desc = 'Flash treesitter'})
vim.keymap.set('n', '<leader>lr', flash.treesitter_search, {desc = 'Flash treesitter sarch'})
