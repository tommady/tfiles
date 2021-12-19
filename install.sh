#!/bin/sh

set -u

main() {
    need_cmd uname
    need_cmd mktemp
    need_cmd rmdir
    need_cmd git
    need_cmd make

    check_architecture

    ensure cd $HOME
    ensure install_zsh
    ensure install_nerd_font_SauceCodePro
    ensure install_oh_my_zsh
    ensure install_powerlevel10k
    ensure download_scripts
    ensure deploy_scripts
    ignore cd $HOME
}

function deploy_scripts() {
    cd $HOME/tfiles
    make
    cd $HOME
}

function download_scripts() {
    git clone --depth 1 https://github.com/tommady/tfiles.git $HOME/tfiles
}

function install_powerlevel10k() {
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    # p10k configure <--- run it if you don't like my configuration of p10k
}

function install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install_nerd_font_SauceCodePro() {
    local _dir="$(mktemp -d)"
    local _file="${_dir}/nerd-fonts"

    git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts $_file
    cd $_file
    git sparse-checkout add patched-fonts/SauceCodePro
    ./install.sh SauceCodePro

    ignore rmdir $_dir
    cd $HOME
}

function install_zsh() {
    local _dir="$(mktemp -d)"
    local _file="${_dir}/zsh"

    git clone git://git.code.sf.net/p/zsh/code $_file
    cd $_file

    ./configure --prefix=/usr --sysconfdir=/etc/zsh --enable-etcdir=/etc/zsh
    make
    make install
    chsh -s $(which zsh)

    ignore rmdir $_dir
    cd $HOME
}

function check_architecture() {
    local _ostype
    _ostype="$(uname -s)"

    if ![[ "$_ostype" = Linux || "$_ostype" = Darwin ]]; then
        err "only support Linux or Darwin architectures"
    fi
}

ensure() {
    if ! "$@"; then err "command failed: $*"; fi
}

ignore() {
    "$@"
}

need_cmd() {
    if ! check_cmd "$1"; then
        err "need '$1' (command not found)"
    fi
}

check_cmd() {
    command -v "$1" >/dev/null  2>&1
}

say() {
    printf 'tfile: %s\n' "$1"
}

err() {
    say "$1" >&2
    exit 1
}

main "$@" || exit 1
