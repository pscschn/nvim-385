build:
  source scripts/project/build.zsh

publish:
  source scripts/project/publish.zsh

install:
  source scripts/project/link-globals.zsh

test script:
  nvim -l $(realpath {{script}})