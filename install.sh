#!/bin/bash

mkdir -p $HOME/.config
[[ ! -d $HOME/.config/alacritty ]] && ln -s $(pwd)/.config/alacritty $HOME/.config/alacritty
[[ ! -d $HOME/.config/cava ]] && ln -s $(pwd)/.config/cava $HOME/.config/cava
[[ ! -d $HOME/.config/kitty ]] && ln -s $(pwd)/.config/kitty $HOME/.config/kitty
[[ ! -d $HOME/.config/nvim ]] && ln -s $(pwd)/.config/nvim $HOME/.config/nvim
[[ ! -d $HOME/.config/ranger ]] && ln -s $(pwd)/.config/ranger $HOME/.config/ranger
[[ ! -d $HOME/.config/spotify-tui ]] && ln -s $(pwd)/.config/spotify-tui $HOME/.config/spotify-tui
[[ ! -d $HOME/.config/zsh ]] && ln -s $(pwd)/.config/zsh $HOME/.config/zsh
[[ ! -d $HOME/.config/tmux ]] && ln -s $(pwd)/.config/tmux $HOME/.config/tmux
[[ ! -d $HOME/.config/navi ]] && ln -s $(pwd)/.config/navi $HOME/.config/navi

[[ ! -e $HOME/.zshenv ]] && ln -s $(pwd)/.zshenv $HOME/.zshenv
[[ ! -e $HOME/.vimrc ]] && ln -s $(pwd)/.vimrc $HOME/.vimrc
[[ ! -e $HOME/.bashrc ]] && ln -s $(pwd)/.bashrc $HOME/.bashrc
[[ ! -e $HOME/.bash_profile ]] && ln -s $(pwd)/.bash_profile $HOME/.bash_profile
[[ ! -e $HOME/.tmux.conf ]] && ln -s $(pwd)/.tmux.conf $HOME/.tmux.conf
[[ ! -e $HOME/.config/starship.toml ]] && ln -s $(pwd)/.config/starship/starship.toml $HOME/.config/starship.toml

if [[ ! -d $HOME/.config/wezterm ]]; then
	ln -s $(pwd)/.config/wezterm $HOME/.config/wezterm
	git clone https://github.com/danielcopper/wezterm-session-manager.git ~/.config/wezterm/wezterm-session-manager
fi

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
if [ -x "$(command -v git)" ]; then
	[[ ! -d $HOME/.vim ]] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Curl based installs
if [ -x "$(command -v curl)" ]; then
	! [ -x "$(command -v starship)" ] && curl -sS https://starship.rs/install.sh | sh
	! [ -x "$(command -v zoxide)" ] && curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
	! [ -x "$(command -v bun)" ] && curl -fsSL https://bun.sh/install | bash
fi

if [ -x "$(command -v bun)" ]; then
	bun add --global typescript
	bun add --global typescript-language-server
	bun add --global tailwindcss-language-server
	bun add --global tldr
fi


echo "Need to install manually:"
! [ -x "$(command -v tmux)" ] && echo "tmux"
! [ -x "$(command -v fzf)" ] && echo "fzf"
! [ -x "$(command -v fdfind)" ] && echo "fdfind"
! [ -x "$(command -v exa)" ] && echo "exa"
! [ -x "$(command -v rg)" ] && echo "ripgrep"
! [ -x "$(command -v npm)" ] && echo "node|npm"
! [ -x "$(command -v nodenv)" ] && echo "nodenv"
! [ -x "$(command -v cargo)" ] && echo "rust|cargo"
! [ -x "$(command -v lazygit)" ] && echo "lazygit"

