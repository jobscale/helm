#!/usr/bin/env bash
set -u

setArch() {
  Uname=$(uname)
  UNAME=${Uname,,}
  ARCH=$(uname -m)
  [[ "$ARCH" == x86_64 ]] && ARCH=amd64
}
setArch

HELM_VERSION=$(git ls-remote --refs --tags https://github.com/helm/helm.git | sort -t '/' -k 3 -V | grep -v 'rc' | tail -1 | awk -F/ '{print $3}')
HELM_FNAME="helm-${HELM_VERSION}-${UNAME}-${ARCH}.tar.gz"
HELM_EXEC="${UNAME}-${ARCH}/helm"

install() {
  [[ ! -d "$HOME/.bin" ]] && mkdir "$HOME/.bin"
  curl -fsSLo- "https://get.helm.sh/${HELM_FNAME}" | tar xz -C $HOME/.bin
}

[[ ! -x "$HOME/.bin/${HELM_EXEC}" ]] && install

"$HOME/.bin/${HELM_EXEC}" $@
