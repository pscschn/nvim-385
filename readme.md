## Prerequisites

1. Install just
```zsh
dnf install just
```

Quick fix to enable global usage of shared scripts

```bash
P=$(pwd)

sudo ln -s $P/global/nvim-385 /usr/local/share/lua/5.1/nvim-385

```