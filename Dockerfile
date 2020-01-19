FROM kalilinux/kali-linux-docker:latest

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm-256color

RUN rm -fR /var/lib/apt/ && apt clean && apt update && apt upgrade -y && apt install -y software-properties-common kali-linux-full kali-linux kali-linux-wireless kali-linux-top10 --fix-missing && \
    echo 'VERSION_CODENAME=kali-rolling' >> /etc/os-release

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -

RUN apt install -y git colordiff colortail unzip tmux xterm zsh curl telnet strace ltrace tmate less build-essential wget python3-setuptools python3-pip tor proxychains proxychains4 zstd net-tools bash-completion iputils-tracepath nodejs yarnpkg libssl-dev libxml2-dev libxslt1-dev htop silversearcher-ag git tree ranger rename manpages-dev peco vim gcc clang clang-tools cmake automake ninja-build build-essential global python3-flake8* python3-virtualenv autoconf pkg-config mlocate x11-apps xauth firefox-esr gedit goaccess

RUN git clone https://github.com/danielmiessler/SecLists /usr/share/seclists

RUN git clone https://github.com/andresriancho/w3af.git /opt/w3af && \
    apt install -y libssl-dev libxml2-dev libxslt1-dev zlib1g-dev python-dev; \
    /opt/w3af/w3af_console ; \
    bash /tmp/w3af_dependency_install.sh ; \
    echo 'export PATH=/opt/w3af:$PATH' >> /etc/profile

RUN curl https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip | gunzip - > /usr/bin/ngrok && chmod +x /usr/bin/ngrok

# code-server
RUN mkdir -p /opt/code-server && \
    curl -Ls https://api.github.com/repos/codercom/code-server/releases/latest | grep "browser_download_url.*linux" | cut -d ":" -f 2,3 | tr -d \"  | xargs curl -Ls | tar xz -C /opt/code-server --strip 1 && \
    echo "export PATH=/opt/code-server:$PATH" >> /etc/profile

RUN pip install virtualenvwrapper && \
    echo 'export WORKON_HOME=$HOME/.virtualenvs' >> /etc/profile && \
    echo 'export PROJECT_HOME=$HOME/Projects' >> /etc/profile && mkdir /root/Projects && \
    echo 'export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh' >> /etc/profile && \
    bash /usr/local/bin/virtualenvwrapper.sh && \
    echo 'source /usr/local/bin/virtualenvwrapper.sh' >> /etc/profile

RUN mkdir -p /root/Downloads /root/Documents /root/Pictures /root/Videos

# Tor refresh every 5 requests
RUN echo MaxCircuitDirtiness 10 >> /etc/tor/torrc && \
    update-rc.d tor enable

# Use random proxy chains / round_robin_chain for pc4
RUN sed -i 's/^strict_chain/#strict_chain/g;s/^#random_chain/random_chain/g' /etc/proxychains.conf && \
    sed -i 's/^strict_chain/#strict_chain/g;s/^round_robin_chain/round_robin_chain/g' /etc/proxychains4.conf

RUN updatedb && apt autoremove -y && apt clean

# rather basic vim config
RUN echo "colorscheme elflord" >> /root/.vimrc
RUN echo "set nocompatible" >> /root/.vimrc
RUN echo "filetype off" >> /root/.vimrc
RUN echo "syntax on" >> /root/.vimrc
RUN echo "set modelines=0" >> /root/.vimrc
RUN echo "set ruler" >> /root/.vimrc
RUN echo "set visualbell" >> /root/.vimrc
RUN echo "set encoding=utf-8" >> /root/.vimrc
RUN echo "set wrap" >> /root/.vimrc
RUN echo "set formatoptions=tcqrn1" >> /root/.vimrc
RUN echo "set tabstop=2" >> /root/.vimrc
RUN echo "set shiftwidth=2" >> /root/.vimrc
RUN echo "set softtabstop=2" >> /root/.vimrc
RUN echo "set expandtab" >> /root/.vimrc
RUN echo "set noshiftround" >> /root/.vimrc
RUN echo "set hidden" >> /root/.vimrc
RUN echo "set ttyfast" >> /root/.vimrc
RUN echo "set laststatus=2" >> /root/.vimrc
RUN echo "set showmode" >> /root/.vimrc
RUN echo "set showcmd" >> /root/.vimrc
RUN echo "set hlsearch" >> /root/.vimrc
RUN echo "set incsearch" >> /root/.vimrc
RUN echo "set ignorecase" >> /root/.vimrc
RUN echo "set smartcase" >> /root/.vimrc
RUN echo "set showmatch" >> /root/.vimrc
RUN echo "set wildmenu" >> /root/.vimrc
RUN echo "set smartindent" >> /root/.vimrc
RUN echo "set secure" >> /root/.vimrc
RUN echo "set title" >> /root/.vimrc
RUN echo "set splitbelow" >> /root/.vimrc
RUN echo "set splitright" >> /root/.vimrc
RUN echo "set nospell" >> /root/.vimrc
RUN echo "set t_Co=256" >> /root/.vimrc
RUN echo "au BufWritePre * :%s/\s\+$//e" >> /root/.vimrc
RUN echo "let g:netrw_banner = 0" >> /root/.vimrc
RUN echo "colorscheme elflord" >> /root/.vimrc

RUN echo "source ~/.bashrc" >> /etc/profile

RUN echo "alias ll='ls -CFlh --color=auto'" >> /root/.bashrc
RUN echo "alias la='ls -alFh --color=auto'" >> /root/.bashrc
RUN echo "alias l='ls -CFh --color=auto'" >> /root/.bashrc
RUN echo "alias ls='ls -CFh --color=auto'" >> /root/.bashrc
RUN echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> /root/.bashrc
RUN echo "alias r='ranger'" >> /root/.bashrc
RUN echo "alias vi='vim'" >> /root/.bashrc

# FYI: for proxy chains with TOR, run $ service tor start

WORKDIR /root
ENV DISPLAY=$DISPLAY
RUN touch /root/.Xauthority

CMD ["/bin/bash", "--init-file", "/etc/profile"]
