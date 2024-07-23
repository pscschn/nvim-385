# Template

Here is the template structure for organizing the plugin modules. All modules are created in the "modules" folder. Currently, the structure consists of a category module containing various submodules, each in turn representing a specific plugin.

```text
modules/
├── category-module/
│   └── submodule-pluginX/
│       └── plugin-config-fileX.lua
└── another-category-module/
    └── submodule-pluginY/
        └── plugin-config-fileY.lua
```

For example, a 'Navigation' category might include all plugins that modify navigation in nvim. Within this category, there might be a submodule called 'file-browsing' which is an abstraction for the 'telescope' plugin. You can easily replace 'file-browsing' with another plugin or module at any time.

Currently I expect this depth of module recursion to cover all use cases of depicting categorization.