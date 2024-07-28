build:
  source scripts/project/build.zsh

publish:
  source scripts/project/publish.zsh

setup: 
  source scripts/project/link-globals.zsh

install:
  source scripts/install-all.zsh

test script:
  nvim -l $(realpath {{script}})