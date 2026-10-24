## Nvim-385

My personal nvim config - lightweight setup + per project customization options.

### Quick Start

[container/run.sh](./container/run.sh) runs a podman container with this config.

```shell
bash <(curl -s https://raw.githubusercontent.com/pscschn/nvim-385/refs/heads/master/container/run.sh)
```

### Customizations & Project Settings

Per project settings are read from `<cwd>/.nvim/settings.lua`.
This file should return a table which may contain the functions:
- `init`: Called early to set up globals, options, or state
- `config`: Called after init to apply configuration

They provide the frame for project customizations; each function is optional.

#### Customize Global Defaults

Can be customized this way:
Default keymaps, signs, dirs, some plugin specific options.

``` lua
init = function ()
  local plugins = vim.g.plugins
  plugins.dotnet.explorer = true
  vim.g.plugins = plugins
end,
```

See all default values [here](./lua/config/globals)

#### Customize Language Support and Plugins

Default language configuration is provided in [./lua/lang](./lua/lang).
See [this readme](./lua/lang/readme.md) on how to enable each.

```lua
config = function ()
  require("lang.csharp").enable()
end
```

#### Enable Code Outline

Code outline toggle becomes available and visible in the which-key menu:

```lua
config = function ()
  require("lang.csharp").enable()
  vim.g.plugins.outline.load()
end
```

#### Debug Unit Tests At Cursor

Read the name of the nearest function and immediatly start debugging under your cursor:

Note:
- This is not supported by all of my language configs
- The launched (test) bin needs to accept args this way

```lua

config = function ()
  local c = require("lang.clang")
  c.dap.install()
  c.dap.config({
    --env = require("util.dotenv").read_file(cwd .. "/.env"),
    bin = "/.build/test/test",
    makeArgs = function()
      return { require("util.lsp").functions.at_cursor() }
    end,
  })
end

```