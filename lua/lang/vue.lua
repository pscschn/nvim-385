local settings = require("config.settings")

local M = {}
M.lsp = {}
M.lsp.server = "vue-language-server"

M.lsp.install = function()
    local name = M.lsp.server
    local server = require("mason-registry").get_package(name)
    if not server:is_installed() then
        vim.notify("Installing" .. name)
        server:install()
    end
end

M.lsp.config = function()
    local name = M.lsp.server
    local root = settings.dir.mason .. "/" .. name .. "/"
    local lspconfig = require("lspconfig")

    lspconfig.volar.setup(
        {
            cmd = {"npm", "--prefix", root, "exec", name, "--", "--stdio"},
            --on_attach = utils.lsp.on_attach,
            filetypes = {"vue", "javascript", "typescript", "typescriptreact"},
            root_dir = lspconfig.util.root_pattern("package.json", "vite.config.js"),
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            init_options = {
                vue = {
                    hybridMode = false
                }
            },
            settings = {
                typescript = {
                    inlayHints = {
                        enumMemberValues = {
                            enabled = true
                        },
                        functionLikeReturnTypes = {
                            enabled = true
                        },
                        propertyDeclarationTypes = {
                            enabled = true
                        },
                        parameterTypes = {
                            enabled = true,
                            suppressWhenArgumentMatchesName = true
                        },
                        variableTypes = {
                            enabled = true
                        }
                    }
                }
            }
        }
    )
end

return M
