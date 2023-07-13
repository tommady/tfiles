FROM docker.io/archlinux:base-devel

# install the binaries
RUN pacman -Syu --noconfirm git zsh exa ripgrep fd neovim bat jq sd fzf just wget tmux gopls gofumpt go

# install tmux tpm
RUN git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install powerlevel10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# install zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# copy my dotfiles
RUN git clone --depth 1 https://github.com/tommady/tfiles.git $HOME/tfiles

RUN cp $HOME/tfiles/remote/tmux.conf $HOME/.tmux.conf
RUN mkdir -p $HOME/.config/nvim && cp $HOME/tfiles/remote/init.vim $HOME/.config/nvim/init.vim
RUN cp $HOME/tfiles/remote/zshrc $HOME/.zshrc
RUN cp $HOME/tfiles/remote/p10k.zsh $HOME/.p10k.zsh

# fix up LC_ALL: cannot change locale (en_US.UTF-8)
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8

# setup default shell to zsh
RUN chsh -s /bin/zsh

ENTRYPOINT ["sleep", "infinity"] 
