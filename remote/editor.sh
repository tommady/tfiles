#!/bin/bash

set -u

main() {
    need_cmd uname
    need_cmd mktemp
    need_cmd rmdir
    need_cmd make
    need_cmd bash

    check_architecture

    ensure cd $HOME
    install_oh_my_zsh
    install_powerlevel10k
    download_my_tfiles
    deploy_my_tfiles
    ignore cd $HOME
}

function deploy_my_tfiles() {
    # for tmux tpm
    ensure git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    ensure cd $HOME/tfiles
    ensure make deploy_tmux
    ensure make deploy_nvim
    ensure make deploy_p10k
    ensure make deploy_zshrc
    ensure cd $HOME
}

function download_my_tfiles() {
    ensure git clone --depth 1 https://github.com/tommady/tfiles.git $HOME/tfiles
}

function install_powerlevel10k() {
    ensure git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    # p10k configure <--- run it if you don't like my configuration of p10k
}

function install_oh_my_zsh() {
    ensure sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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
