require 'options' 
require 'keymaps'
require 'lazy-config'

for _, module in ipairs(require('configs')) do
    if type(module.setup) == "function" then
        module.setup()
    else
        print("No setup function found in module")
    end
end