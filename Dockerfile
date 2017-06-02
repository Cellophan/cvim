FROM debian as golang

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -qy wget git ca-certificates
RUN wget -O /tmp/go.tar.gz --quiet https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /tmp/go.tar.gz

ENV GOPATH=/tmp/go GOBIN=/usr/local/go/bin PATH=${PATH}:/usr/local/go/bin
RUN go get golang.org/x/tools/cmd/godoc
RUN go get golang.org/x/tools/cmd/goimports
RUN go get golang.org/x/tools/cmd/gorename
RUN go get github.com/nsf/gocode
RUN go get github.com/rogpeppe/godef
RUN go get github.com/golang/lint/golint
RUN go get github.com/kisielk/errcheck
RUN go get github.com/jstemmer/gotags


FROM cell/playground
ENV DOCKER_IMAGE="cell/cvim"
ENV DEFAULT_CMD=vim

#go
COPY --from=golang /usr/local/go /usr/local/go

#vim from vim-go and vim-go-ide
COPY material/vimrc /etc/skel/.vimrc
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -qy vim-nox git exuberant-ctags &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/* &&\
    git clone --depth 1 https://github.com/gmarik/Vundle.vim.git /etc/skel/.vim/bundle/Vundle.vim &&\
    rm -rf /etc/skel/.vim/bundle/Vundle.vim/.git &&\
    ln -s /etc/skel/.vim /root/ &&\
	vim -u /etc/skel/.vimrc +PluginInstall +qall

#Material
COPY material/scripts    /usr/local/bin/
COPY material/payload    /opt/payload/
COPY material/profile.d  /etc/profile.d/

