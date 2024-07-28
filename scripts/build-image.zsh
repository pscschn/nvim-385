#!/usr/bin/zsh
#
# Test

curl -O https://ftp.osuosl.org/pub/rpm/releases/rpm-4.19.x/rpm-4.19.1.1.tar.bz2 | tar -xf


shared_lib="$(dirname $0)/.shared"
[ -e "$shared_lib" ] || curl -sSf https://raw.githubusercontent.com/vegardit/docker-shared/v1/download.sh?_=$(date +%s) | bash -s v1 "$shared_lib" || exit 1
source "$shared_lib/lib/build-image-init.sh"