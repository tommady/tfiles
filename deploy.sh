cp ./tmux.conf ~/.tmux.conf
cp ./init.vim ~/.config/nvim/init.vim
cp ./alacritty.yml ~/.config/alacritty/alacritty.yml
cp ./p10k.zsh ~/.p10k.zsh

# prevent target host does not have rg, so using grep here
if [ -z "$(grep -n 'others' ~/.zshrc | cut -d: -f 1)" ]; then
    cp ./zshrc ~/.zshrc
else
    cp ./zshrc ~/.zshrc.tmp
    tail -n +"$(grep -n 'others' ~/.zshrc | cut -d: -f 1)" ~/.zshrc >> ~/.zshrc.tmp
    mv ~/.zshrc.tmp ~/.zshrc
fi
