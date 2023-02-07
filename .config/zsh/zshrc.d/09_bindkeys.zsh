autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

if [ -z "${(k)key}" ]; then
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down
  bindkey  "^[[1~"   beginning-of-line
  bindkey  "^[[4~"   end-of-line
  bindkey  "^[[3~"  delete-char
else
  bindkey  $key["Up"] history-substring-search-up
  bindkey  $key["Down"] history-substring-search-down
  bindkey  $key["Home"]   beginning-of-line
  bindkey  $key["End"]   end-of-line
  bindkey  $key["Delete"]  delete-char
fi

if [[ $(uname -a) =~ "Darwin" ]]; then
	bindkey "^[[A" history-substring-search-up
	bindkey "^[[B" history-substring-search-down
	bindkey  "^[[H"   beginning-of-line
	bindkey  "^[[F"   end-of-line
	bindkey  "^[[3~"  delete-char
fi

