HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

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
# export PATH="$PATH:${$(find ~/.local/bin ~/.local/share/npm/bin -type d -printf %p:)%%:}"
export FZF_DEFAULT_COMMAND='fd --type f --hidden'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
export FZF_ALT_C_COMMAND='fd --type d . --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
export MYVIMRC="$HOME/.config/nvim/init.lua"

export EDITOR=nvim
export PATH="$PATH:$(npm -g prefix)/bin"

# aliases
source ~/.config/zsh/aliasrc

# completion menu
# source ~/.config/zsh/menu.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# add title to terminal to display state,currently executing command, current directory...
# autoload -Uz add-zsh-hook

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
