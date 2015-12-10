
: "${GOPATH:="$WORKDIR"}"
: "${GOBIN:="$WORKDIR"}"
PATH=${PATH}:/usr/local/go/bin:${GOBIN}
export GOPATH GOBIN PATH

