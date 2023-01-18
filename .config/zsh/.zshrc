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

autoload -Uz compinit && compinit

source ~/.config/zsh/prompt.zsh
source ~/.config/zsh/exports.zsh

# these directories are necessary for zsh, to
# create history file, etc... Create them if don't exist
[[ ! -d ~/.cache/zsh ]] && mkdir -p ~/.cache/zsh
[[ ! -d ~/.local/share/zsh ]] && mkdir -p ~/.local/share/zsh


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
# [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

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

if ! command -v z &> /dev/null; then
	eval "$(zoxide init zsh)"
fi

# aliases
source ~/.config/zsh/aliasrc

# Need to configure zellij before can use
# source ~/.config/zsh/zellij.zsh

# https://gitlab.com/phoneybadger/pokemon-colorscripts
# ln -s <repo>/pokemon-colorscripts/ ~/.local/bin/
[[ ! -f ~/.local/bin/pokemon-colorscripts/pokemon-colorscripts.sh ]] || sh ~/.local/bin/pokemon-colorscripts/pokemon-colorscripts.sh -r

# source antidote
source ~/.config/zsh/antidote.zsh
