#!/bin/sh

set -u

main() {
    need_cmd uname
    need_cmd mktemp
    need_cmd rmdir
    # need_cmd git
    need_cmd make
    need_cmd bash

    check_architecture

    ensure cd $HOME
    install_zsh
    install_nerd_font_SauceCodePro
    install_oh_my_zsh
    install_powerlevel10k
    download_scripts
    deploy_scripts
    ignore cd $HOME
}

function deploy_scripts() {
    ensure cd $HOME/tfiles
    ensure make
    ensure cd $HOME
}

function download_scripts() {
    ensure git clone --depth 1 https://github.com/tommady/tfiles.git $HOME/tfiles
}

function install_powerlevel10k() {
    ensure git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    # p10k configure <--- run it if you don't like my configuration of p10k
}

function install_oh_my_zsh() {
    ensure sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install_nerd_font_SauceCodePro() {
    local _dir="$(mktemp -d)"
    local _file="${_dir}/nerd-fonts"

    ensure git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts $_file
    ensure cd $_file
    ensure git sparse-checkout add patched-fonts/SauceCodePro
    ensure ./install.sh SauceCodePro

    ignore rmdir $_dir
    ensure cd $HOME
}

function install_zsh() {
    if [ "$(uname)" == "Darwin" ]; then
        # make sure you have brew installed
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew doctor
        brew install zsh
    elif [ -f "/etc/arch-release" ]; then
        pacman --noconfirm -Syu podman
    elif ensure grep 'Ubuntu' /etc/lsb-release; then
        apt update
        apt upgrade
        apt install zsh
    else
        err "Only support Mac, ArchLinux and Ubuntu"
    fi

    chsh -s $(which zsh)
}

function check_architecture() {
    local _os="$(uname)"
    if [[ "${_os}" != "Linux" && "${_os}" != "Darwin" ]]; then
        err "only support Linux or Darwin OS"
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
