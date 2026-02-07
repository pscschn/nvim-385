# Language Configs

## Clang Example

`<cwd>/.nvim/settings.lua`

```lua

-- settings.lua

local M = {}

M.config = function ()
  local cwd = vim.fn.getcwd()
  local c = require("lang.clang")

  c.lsp.install()
  c.lsp.config({ "--compile-commands-dir=" .. cwd .. "/build" })

  c.dap.install()
  c.dap.config({
    env = require("util.dotenv").read_file(cwd .. "/.env"),
    bin = "/build/tests/test",
    makeArgs = function()
      return { require("util.lsp").functions.at_cursor() }
    end,
  })
end

return M
}
```

## Lua_ls Example

`<cwd>/.nvim/settings.lua`

```lua

-- settings.lua

return {
  config = function()
    local lua = require("lang.lua")
    lua.lsp.install()
    lua.lsp.config()
  end
}
```


## C# Example

`<cwd>/.nvim/settings.lua`

This configuration uses `neotest-vstest` for test exploration.
It depends on a `tree-sitter` parser, which should installed automatically when using below project settings.
Use `:checkhealth nvim-treesitter` to ensure that everything is in order.

```lua
-- settings.lua

return {
	init = function ()
		local plugins = vim.g.plugins

		plugins.dotnet.explorer = true
    -- optional: used by neotest-vstest
    plugins.dotnet.sdk_path = "/usr/share/dotnet/sdk/9.0.112/"

		vim.g.plugins = plugins
	end,

	config = function ()
		local sharp = require("lang.csharp")
		sharp.lsp.install()
		sharp.lsp.config()

		sharp.dap.install()
		sharp.dap.config()
	end
}

```


## Ansible Example

The project settings below use `mason` to install `ansible-language-server` which requires `npm`.

```lua
-- settings.lua

return {
  config = function()
    local ansible = require("lang.ansible")
    ansible.install()
    ansible.config()
  end
}
```