FROM cell/debsandbox
MAINTAINER Cell <maintainer.docker.cell@outer.systems>
ENV DOCKER_IMAGE="cell/cvim"

ADD material/scripts    /usr/local/bin/
ADD material/payload    /opt/payload/
ADD material/profile.d  /etc/profile.d/
ADD material/skel       /etc/skel/
ENV DEFAULT_CMD=vim

#go
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -qy wget &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/* &&\
    wget -O /tmp/go.tar.gz --quiet https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz &&\
    tar -C /usr/local -xzf /tmp/go.tar.gz &&\
    rm /tmp/go.tar.gz

#Go tools
RUN mkdir /tmp/go \
	&& export \
		GOPATH=/tmp/go \
		GOBIN=/usr/local/go/bin \
		PATH=${PATH}:/usr/local/go/bin &&\
    echo godoc		&& go get golang.org/x/tools/cmd/godoc &&\
    echo goimports	&& go get golang.org/x/tools/cmd/goimports &&\
    echo oracle		&& go get golang.org/x/tools/cmd/oracle &&\
    echo gorename	&& go get golang.org/x/tools/cmd/gorename &&\
    echo gocode 	&& go get github.com/nsf/gocode &&\
    echo godef		&& go get github.com/rogpeppe/godef &&\
    echo golint		&& go get github.com/golang/lint/golint &&\
    echo errcheck	&& go get github.com/kisielk/errcheck &&\
    echo gotags		&& go get github.com/jstemmer/gotags &&\
    rm -r /tmp/go

#vim from vim-go and vim-go-ide
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -qy vim-nox git exuberant-ctags &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/* &&\
    git clone --depth 1 https://github.com/gmarik/Vundle.vim.git /etc/skel/.vim/bundle/Vundle.vim &&\
    ln -s /etc/skel/.vim /root/ &&\
	vim -u /etc/skel/.vimrc +PluginInstall +qall

