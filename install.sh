#!/bin/bash

mkdir -p $HOME/.config
[[ ! -d $HOME/.config/alacritty ]] && ln -s $(pwd)/.config/alacritty $HOME/.config/alacritty
[[ ! -d $HOME/.config/cava ]] && ln -s $(pwd)/.config/cava $HOME/.config/cava
[[ ! -d $HOME/.config/kitty ]] && ln -s $(pwd)/.config/kitty $HOME/.config/kitty
[[ ! -d $HOME/.config/nvim ]] && ln -s $(pwd)/.config/nvim $HOME/.config/nvim
[[ ! -d $HOME/.config/ranger ]] && ln -s $(pwd)/.config/ranger $HOME/.config/ranger
[[ ! -d $HOME/.config/spotify-tui ]] && ln -s $(pwd)/.config/spotify-tui $HOME/.config/spotify-tui
[[ ! -d $HOME/.config/zsh ]] && ln -s $(pwd)/.config/zsh $HOME/.config/zsh
[[ ! -d $HOME/.config/tmux ]] && ln -s $(pwd)/tmux $HOME/.config/tmux

[[ ! -e $HOME/.zshenv ]] && ln -s $(pwd)/.zshenv $HOME/.zshenv
[[ ! -e $HOME/.vimrc ]] && ln -s $(pwd)/.vimrc $HOME/.vimrc
[[ ! -e $HOME/.bashrc ]] && ln -s $(pwd)/.bashrc $HOME/.bashrc
[[ ! -e $HOME/.bash_profile ]] && ln -s $(pwd)/.bash_profile $HOME/.bash_profile
[[ ! -e $HOME/.tmux.conf ]] && ln -s $(pwd)/.tmux.conf $HOME/.tmux.conf

OS_NAME=$(uname -a)
if [[ "$OS_NAME" =~ "Linux" ]]; then
	echo "Linux OS Detected"
	[[ ! -e $HOME/.config/alacritty/key-bindings.yml ]] && ln -s $(pwd)/.config/alacritty/key-bindings.linux.yml $HOME/.config/alacritty/key-bindings.yml
	[[ ! -e $HOME/.config/alacritty/os-overrides.yml ]] && ln -s $(pwd)/.config/alacritty/os-overrides.linux.yml $HOME/.config/alacritty/os-overrides.yml
	[[ ! -d $HOME/.config/polybar ]] && ln -s $(pwd)/.config/polybar $HOME/.config/polybar
	[[ ! -d $HOME/.config/rofi ]] && ln -s $(pwd)/.config/rofi $HOME/.config/rofi
elif [[ "$OS_NAME" =~ "Darwin" ]]; then
	echo "Mac OS Detected"
	[[ ! -e $HOME/.config/alacritty/key-bindings.yml ]] && ln -s $(pwd)/.config/alacritty/key-bindings.mac.yml $HOME/.config/alacritty/key-bindings.yml
	[[ ! -e $HOME/.config/alacritty/os-overrides.yml ]] && ln -s $(pwd)/.config/alacritty/os-overrides.mac.yml $HOME/.config/alacritty/os-overrides.yml
	[[ ! -d $HOME/.config/sketchybar ]] && ln -s $(pwd)/.config/sketchybar $HOME/.config/sketchybar
	[[ ! -d $HOME/.config/skhd ]] && ln -s $(pwd)/.config/skhd $HOME/.config/skhd
	[[ ! -d $HOME/.config/yabai ]] && ln -s $(pwd)/.config/yabai $HOME/.config/yabai
else
	echo "Unsupported OS"
fi

# git based installs
if which git >/dev/null; then
	[[ ! -d $HOME/.vim ]] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Curl based installs
if which curl >/dev/null; then
	! [ -x "$(command -v starship)" ] && curl -sS https://starship.rs/install.sh | sh
	! [ -x "$(command -v zoxide)" ] && curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

fi
