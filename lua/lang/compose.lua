local M = {
  lsp = { name = "docker-compose-language-service" },
}

M.lsp.root = vim.g.dirs.mason .. "/" .. M.lsp.name .. "/"

M.lsp.install = function()
  require("util.mason").safe_install(M.lsp.name)
end

M.lsp.config = function()
  vim.lsp.config("docker_compose_language_service", {
    cmd = { "npm", "--prefix", M.lsp.root, "exec", "@microsoft/compose-language-service", "--", "--stdio" },
    filetypes = { "yaml" },
    root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
    single_file_support = true,
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.config.capabilities),
  })

  vim.lsp.enable({ "docker_compose_language_service" })
end

return M
