# Kali Linux Docker Image

A Kali Linux Docker image containing the full suite of hacking tools.

*Borrowed **heavily** from [XaviTorello](https://github.com/XaviTorello/kali-full-docker)*

## X11 Forwarding configured

- In addition to the full Kali suite of tools, X11 forwarding is configured to run at launch when using `scripts/run.sh`. It is encouraged to extract the commands within the script and create a bash function to execute from terminal.

## Additional Software Included

- silversearcher-ag
- tree
- ranger
- rename
- peco
- mlocate
- wget
- curl 
- telnet
- git
- iputils-tracepath
- net-tools
- build-essentials
- tmux
- tmate
- xterm
- zsh
- zstd
- ltrace
- strace
- vim
- less
- colordiff
- colortail
- strace 
- ltrace
- unzip
- unrar
- python3-setuptools 
- python3-pip
- bash-completion
- nodejs
- npm
- yarn
- gcc
- clang
- clang-tools
- ninja
- x11-apps
- xauth


### Bonus vimrc and bash aliases
- A basic `vimrc` is included, which contains some simple, but (in my opinion) nice-to-haves, as well as a few simple `ls` related aliases

## Installation

```sh
$ ./scripts/install.sh
```

## Rebuilding

If any changes are made to the Dockerfile, and you want to rebuild the image:

```sh
$ ./scripts/rebuild.sh
```

## Launching the Docker image

```sh
$ ./scripts/run.sh
```
