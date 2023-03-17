HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# setopt APPEND_HISTORY
# setopt HIST_IGNORE_ALL_DUPS
# setopt INC_APPEND_HISTORY
# setopt SHARE_HISTORY
# preexec_custom_history() {
# 	echo "$HOSTNAME $$ $(date "+%Y-%m-%dT%H:%M:%S%z") $1" >> "$HISTFILE"
# }
# preexec_functions+=(preexec_custom_history)

# History
# http://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt append_history          # append to history file
# setopt extended_history        # write the history file in the ':start:elapsed;command' format
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_find_no_dups       # don't display a previously found event
setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_dups        # don't record an event that was just recorded again
setopt hist_ignore_space       # don't record an event starting with a space
setopt hist_no_store           # don't store history commands
setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
setopt hist_save_no_dups       # don't write a duplicate event to the history file
setopt hist_verify             # don't execute immediately upon history expansion
setopt inc_append_history      # write to the history file immediately, not when the shell exits
unsetopt hist_beep             # don't beep when attempting to access a missing history entry
# unsetopt share_history         # don't share history between all sessions

export PATH="$PATH:$HOME/.local/bin:/opt/hombrew/bin"

# vi mode
bindkey -v
export KEYTIMEOUT=1

autoload -Uz compinit && compinit

# these directories are necessary for zsh, to
# create history file, etc... Create them if don't exist
[[ ! -d ~/.cache/zsh ]] && mkdir -p ~/.cache/zsh
[[ ! -d ~/.local/share/zsh ]] && mkdir -p ~/.local/share/zsh

if ! [ -x "$(command -v z)" ]; then
	eval "$(zoxide init zsh)"
fi

# aliases
source ~/.config/zsh/aliasrc

# Need to configure zellij before can use
# source ~/.config/zsh/zellij.zsh

# https://gitlab.com/phoneybadger/pokemon-colorscripts
# ln -s <repo>/pokemon-colorscripts/ ~/.local/bin/
[[ ! -f ~/.local/bin/pokemon-colorscripts/pokemon-colorscripts.sh ]] || sh ~/.local/bin/pokemon-colorscripts/pokemon-colorscripts.sh -r

for i in ~/.config/zsh/zshrc.d/*.zsh; do
	if [[ $__bashrc_bench ]]; then
		TIMEFORMAT="$i: %R"
		time . "$i"
		unset TIMEFORMAT
	else
		source "$i"
	fi
done; unset i
