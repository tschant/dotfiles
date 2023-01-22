
# Exports
export FZF_DEFAULT_COMMAND='fd --type f --hidden'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b --preview="bat --style=numbers --color=always --line-range :500 {}"'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
export FZF_ALT_C_COMMAND='fd --type d . --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
export MYVIMRC="$HOME/.config/nvim/init.lua"
export AWS_PROFILE=default

export EDITOR=nvim
export PATH="$PATH:$HOME/.local/bin"
[[ -d /home/linuxbrew/ ]] && export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

if [[ -d /home/tarryn/.spicetify ]]; then 
	export PATH="$PATH:/home/tarryn/.spicetify"
	export SPICETIFY_INSTALL="/home/tarryn/.spicetify"
fi

if type npm &>/dev/null; then
	export PATH="$PATH:$(npm -g prefix)/bin"
fi
if type nodenv &>/dev/null; then
	export PATH="$PATH:$HOME/.nodenv/shims"
	eval "$(nodenv init -)"
fi
if type cargo &>/dev/null; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi
if type ruby &>/dev/null && type gem >/dev/null; then
	PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
