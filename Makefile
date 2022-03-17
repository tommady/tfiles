SHELL:=/bin/bash
.ONESHELL:
.PHONY: deploy_tmux deploy_nvim deploy_p10k deploy_zshrc deploy_alacritty
.SILENT: deploy_tmux deploy_nvim deploy_p10k deploy_zshrc deploy_alacritty

all: deploy_tmux deploy_nvim deploy_p10k deploy_zshrc deploy_alacritty

deploy_tmux:
	cp ./tmux.conf ~/.tmux.conf

deploy_nvim:
	cp ./init.vim ~/.config/nvim/init.vim

deploy_alacritty:
	cp ./alacritty.yml ~/.config/alacritty/alacritty.yml

deploy_p10k:
	cp ./p10k.zsh ~/.p10k.zsh

deploy_zshrc:
	cp ./zshrc ~/.zshrc
