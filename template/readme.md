# Template

## About

This is the template structure for organizing plugin modules. 
The purpose is about standardizing a structure to comprehend what is going on without knowing plugin specifics. 

## Structure

The structure consists of 'category' modules which contain various submodules.
Each submodule in turn represents a specific plugin.
On top layer category modules are bundled and aggregated 
to be required by the nvim config which is dynamically generated. 

- [modules](./modules/)
    Contains different plugin categories
- [build](.//build.lua)
    Dynamically aggregates plugins within the modules dir to build the actual nvim dotfiles 

Example: 

```text
modules/
├── category-module/
│   └── submodule-pluginX/
│       └── plugin-config-fileX.lua
└── another-category-module/
    └── submodule-pluginY/
        └── plugin-config-fileY.lua
```

'Navigation' category might include all plugins that modify something along 'navigation' in nvim. 
Within this category, there might be a submodule called 'file-browsing'. 
The submodule 'file-browsing' abstracts the actual plugin that will be installed by the plugin manager. 
The 'file-browsing' module might add the [telescope-filebrowser](https://github.com/nvim-telescope/telescope-file-browser.nvim), it might as well add [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua). 
Maybe even both. 

You can easily replace the contents of file browsing with any other plugin.
But plugins that change navigation will always be with modules/navigation/xy. 
It is standardized for comprehention without knowing specifics. 

Currently I expect this depth of module recursion to cover all use cases of depicting categorization.

