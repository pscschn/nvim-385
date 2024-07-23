build:
  source scripts/build.zsh

link-globals:
  source scripts/link-globals.zsh

lua script:
  nvim -l $(realpath {{script}})