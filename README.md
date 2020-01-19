# Kali Linux Docker Image

A Kali Linux Docker image containing the full suite of hacking tools.

_Borrowed **heavily** from [XaviTorello](https://github.com/XaviTorello/kali-full-docker)_

## X11 Forwarding

- In addition to the full Kali suite of tools, X11 forwarding is configured to run at launch when
  using `scripts/run.sh`. It is encouraged to extract the commands within the script and create a bash
  function to execute from terminal.

## Host Interface

- By default, `scripts/run.sh` launches with access to host interfaces. Feel free to modify this to
  your liking

## Additional Software Included

- silversearcher-ag
- tree
- ranger
- rename
- peco
- mlocate
- goaccess
- gedit (for all you non-vimmers)
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

### Bonus Vimrc and Bash Aliases

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

## Launching the Kali Linux Docker Image

```sh
$ ./scripts/run.sh
```
