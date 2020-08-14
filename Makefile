SHELL:=/bin/bash
.ONESHELL:
.PHONY: deploy_tmux deploy_nvim deploy_alacritty deploy_p10k deploy_zshrc

all: deploy_tmux deploy_nvim deploy_alacritty deploy_p10k deploy_zshrc

deploy_tmux:
	cp ./tmux.conf ~/.tmux.conf

deploy_nvim:
	cp ./init.vim ~/.config/nvim/init.vim

deploy_alacritty:
	cp ./alacritty.yml ~/.config/alacritty/alacritty.yml

deploy_p10k:
	cp ./p10k.zsh ~/.p10k.zsh

deploy_zshrc:
	if [[ -z "$$(grep -n 'others' ~/.zshrc | cut -d: -f 1)" ]]; then 
	    cp ./zshrc ~/.zshrc
	else 
	    cp ./zshrc ~/.zshrc.tmp
	    tail -n +"$$(grep -n 'others' ~/.zshrc | cut -d: -f 1)" ~/.zshrc >> ~/.zshrc.tmp
	    mv ~/.zshrc.tmp ~/.zshrc
	fi
