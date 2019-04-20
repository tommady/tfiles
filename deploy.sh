cp ./tmux.conf ~/.tmux.conf
cp ./init.vim ~/.config/nvim/init.vim

if [ -z "$(grep -n 'others' ~/.zshrc | cut -d: -f 1)" ]; then
    cp ./zshrc ~/.zshrc
else
    cp ./zshrc ~/.zshrc.tmp
    tail -n +"$(grep -n 'others' ~/.zshrc | cut -d: -f 1)" ~/.zshrc >> ~/.zshrc.tmp
    mv ~/.zshrc.tmp ~/.zshrc
fi
