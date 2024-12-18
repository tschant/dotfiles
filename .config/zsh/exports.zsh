export PATH="$PATH:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin"

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
[[ -d /home/linuxbrew/ ]] && export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
[[ -d /opt/homebrew/bin/ ]] && export PATH="$PATH:/opt/homebrew/bin/"

if [[ -d /home/tarryn/.spicetify ]]; then 
	export PATH="$PATH:$HOME/.spicetify"
	export SPICETIFY_INSTALL="$HOME/.spicetify"
fi

if type npm &>/dev/null; then
	export PATH="$PATH:$(npm -g prefix)/bin"
fi
if type nodenv &>/dev/null; then
	export PATH="$PATH:$HOME/.nodenv/shims"
	eval "$(nodenv init -)"
fi

if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
	export PATH="$PATH:$HOME/.nvm"
	[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
	[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi
if [[ -d $HOME/.pyenv ]]; then
	export PYENV_ROOT="$HOME/.pyenv"
	[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
fi

if type cargo &>/dev/null; then
	# gping, alacritty, delta, exa, 
	export PATH="$PATH:$HOME/.cargo/bin"
fi
if type ruby &>/dev/null && type gem >/dev/null; then
	PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
if [[ -d $HOME/.tmux/plugins/ ]]; then 
	[[ -d $HOME/.tmux/plugins/t-smart-tmux-session-manager ]] && export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH 
fi

if [[ -d /Applications/WezTerm.app/Contents/MacOS ]]; then
	PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
	export PATH
fi


# bun completions
if [ -s "$HOME/.bun/_bun" ]; then
	source "$HOME/.bun/_bun"
	PATH="$PATH:$HOME/.bun/bin"
fi

if [ -d "$HOME/Library/Python/3.11/lib/python/site-packages" ]; then
	PATH="$PATH:$HOME/Library/Python/3.11/lib/python/site-packages"
fi

if type navi &>/dev/null; then
	eval "$(navi widget zsh)"
fi

if [ -d "$HOME/perl5/perlbrew" ]; then
	source "$HOME/perl5/perlbrew/etc/bashrc"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
