Quick fix to enable global usage of shared scripts

```bash
P=$(pwd)

sudo ln -s $P/global/module.lua /usr/local/share/lua/5.1/module.lua
sudo ln -s $P/global/plugin.lua /usr/local/share/lua/5.1/plugin.lua
sudo ln -s $P/global/utils.lua /usr/local/share/lua/5.1/utils.lua

```