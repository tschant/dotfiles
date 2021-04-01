export PATH=/usr/local/bin:/usr/local/sbin:$PATH

case $- in
   *i*) source ~/.bashrc
esac

bind '"\e[1;2A":history-search-backward'
bind '"\e[1;2B":history-search-forward'

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
_dir_chomp () {
    local IFS=/ c=1 n d
    local p=(${1/#$HOME/\~}) r=${p[*]}
    local s=${#r}
    while ((s>$2&&c<${#p[*]}-1))
    do
        d=${p[c]}
        n=1;[[ $d = .* ]]&&n=2
        ((s-=${#d}-n))
        p[c++]=${d:0:n}
    done
    echo "${p[*]}"
}
# Time-Username:Full Dir (git branch) $ (# for root)
export PS1="\[\033[01;31m\]\@-\u\[\033[00m\]:\[\033[01;34m\]$(
  _dir_chomp "$PWD" 15
)\[\033[01;36m\]\$(parse_git_branch)\[\033[00m\]\n\[\033[01;37m\]\$ \[\033[0;37m\]"

# With Git Branch
# Username@Host Short Dir (git branch) $
# export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
# Original
# username@hostname:full dir $ (# for root)
# ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033
