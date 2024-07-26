build:
  source scripts/build.zsh

publish:
  source scripts/publish.zsh

install:
  source scripts/link-globals.zsh

test script:
  nvim -l $(realpath {{script}})