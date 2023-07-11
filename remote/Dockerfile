FROM docker.io/archlinux:base-devel

# install the binaries
RUN pacman -Syu --noconfirm git zsh exa ripgrep fd neovim bat jq sd fzf just wget tmux

# install tmux tpm
RUN git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install powerlevel10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# copy my dotfiles
RUN git clone --depth 1 https://github.com/tommady/tfiles.git $HOME/tfiles

RUN ls -la $HOME/tfiles

RUN cp $HOME/tfiles/remote/tmux.conf $HOME/.tmux.conf
RUN cp $HOME/tfiles/remote/init.vim $HOME/.config/nvim/init.vim
RUN cp $HOME/tfiles/remote/zshrc $HOME/.zshrc
RUN cp $HOME/tfiles/remote/p10k.zsh $HOME/.p10k.zsh

ENTRYPOINT ["sleep", "infinity"] 
