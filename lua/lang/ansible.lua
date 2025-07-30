local M = {}
M.lsp = {}
M.lsp.server = "ansible-language-server"
M.lsp.linter = "ansible-lint"

function M.lsp.install()
    local registry = require("mason-registry")

    local lsp_pkg = registry.get_package(M.lsp.server)
    if not lsp_pkg:is_installed() then
        lsp_pkg:install()
    end

    local lint_pkg = registry.get_package(M.lsp.linter)
    if not lint_pkg:is_installed() then
        lint_pkg:install()
    end
end

function M.lsp.config()
    local root = require("config.settings").dir.mason .. "/"
    local lspconfig = require("lspconfig")
    local lsp_bin = root .. M.lsp.server .. "/node_modules/.bin/" .. M.lsp.server
    local lint_bin = root .. M.lsp.linter .. "/venv/bin/" .. M.lsp.linter

    lspconfig.ansiblels.setup(
        {
            cmd = {lsp_bin, "--stdio"},
            filetypes = {"yaml", "yml"},
            root_dir = lspconfig.util.root_pattern("inventory*", ".git"),
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            settings = {
                ansible = {
                    ansible = {path = "ansible"},
                    executionEnvironment = {enabled = false},
                    python = {interpreterPath = "python3"},
                    completion = {
                        provideRedirectModules = true,
                        provideModuleOptionAliases = true
                    },
                    validation = {
                        enabled = true,
                        lint = {
                            enabled = true,
                            path = lint_bin
                        }
                    }
                }
            }
        }
    )
end

return M
