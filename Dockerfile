FROM cell/playground
ENV DOCKER_IMAGE="cell/cvim"
ENV DEFAULT_CMD=vim

#go
RUN apt-get update &&\
  DEBIAN_FRONTEND=noninteractive apt install -qy --no-install-recommends golang-go &&\
  apt-get clean -y && rm -rf /var/lib/apt/lists/*

#vim from vim-go
COPY material/vimrc /etc/skel/.vimrc
RUN apt-get update &&\
  DEBIAN_FRONTEND=noninteractive apt-get install -qy vim-nox git exuberant-ctags silversearcher-ag &&\
  apt-get clean -y && rm -rf /var/lib/apt/lists/* &&\
  git clone --depth 1 https://github.com/junegunn/fzf.git /etc/skel/.fzf &&\
  /etc/skel/.fzf/install --bin &&\
  git clone --depth 1 https://github.com/gmarik/Vundle.vim.git /etc/skel/.vim/bundle/Vundle.vim &&\
  rm -rf /etc/skel/.vim/bundle/Vundle.vim/.git &&\
  ln -s /etc/skel/.vim /root/ &&\
  vim -u /etc/skel/.vimrc +PluginInstall +qall &&\
  GOBIN=/usr/local/bin vim -u /etc/skel/.vimrc +GoInstallBinaries +qall

#Material
COPY material/scripts    /usr/local/bin/
COPY material/payload    /opt/payload/
COPY material/profile.d  /etc/profile.d/

