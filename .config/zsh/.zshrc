HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
# setopt SHARE_HISTORY
# preexec_custom_history() {
# 	echo "$HOSTNAME $$ $(date "+%Y-%m-%dT%H:%M:%S%z") $1" >> "$HISTFILE"
# }
# preexec_functions+=(preexec_custom_history)


# vi mode
bindkey -v
export KEYTIMEOUT=1

autoload -Uz compinit
compinit

source ~/.config/zsh/prompt.zsh
source <(antibody init)
antibody bundle < ~/.config/zsh/plugins/zsh_plugins.txt

# these directories are necessary for zsh, to
# create history file, etc... Create them if don't exist
[[ ! -d ~/.cache/zsh ]] && mkdir -p ~/.cache/zsh
[[ ! -d ~/.local/share/zsh ]] && mkdir -p ~/.local/share/zsh

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
fi
if type cargo &>/dev/null; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi
if type ruby &>/dev/null && type gem >/dev/null; then
	PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

bindkey "$key[Up]" history-substring-search-up
bindkey "$key[Down]" history-substring-search-down
bindkey  "$key[Home]"   beginning-of-line
bindkey  "$key[End]"   end-of-line
bindkey  "$key[Delete]"  delete-char

if [[ $(uname -a) =~ "Darwin" ]]; then
	bindkey "^[[A" history-substring-search-up
	bindkey "^[[B" history-substring-search-down
	bindkey  "^[[H"   beginning-of-line
	bindkey  "^[[F"   end-of-line
	bindkey  "^[[3~"  delete-char
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

for i in ~/.config/zsh/zshrc.d/*.zsh; do
	if [[ $__bashrc_bench ]]; then
		TIMEFORMAT="$i: %R"
		time . "$i"
		unset TIMEFORMAT
	else
		source "$i"
	fi
done; unset i

source ~/.config/zsh/menu.zsh
eval "$(nodenv init -)"
export PATH="$PATH:$(npm -g prefix)/bin"

if ! command -v z &> /dev/null; then
	eval "$(zoxide init zsh)"
fi

# aliases
source ~/.config/zsh/aliasrc

# https://gitlab.com/phoneybadger/pokemon-colorscripts
# ln -s <repo>/pokemon-colorscripts/ ~/.local/bin/
[[ ! -f ~/.local/bin/pokemon-colorscripts/pokemon-colorscripts.sh ]] || sh ~/.local/bin/pokemon-colorscripts/pokemon-colorscripts.sh -r
