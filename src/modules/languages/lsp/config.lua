local Config = {}

function Config.setup()
    local status_ok, mason = pcall(require, 'mason')

    if not status_ok then
        print('Error: failed to load mason')
        return
    end

    mason.setup({
      ui = {
          icons = {
              package_installed = "✔",
              package_pending = "➜",
              package_uninstalled = "✘"
          }
      }
  })
  require("mason-lspconfig").setup()

    vim.keymap.set("n", "<leader>L", {desc = 'LSP'})
    vim.keymap.set("n", "<leader>Lo", ":Mason<CR>", {desc = 'Mason Manager'})

end

return Config