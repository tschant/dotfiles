alias ,s="git status"	\
	,l="git log" \
	,f="git fetch --all" \
	,c="git checkout" \
	,stash="git stash" \
	,glog="git glog" \
	,show="git show" \
	,dft="git dft"

,rb() {
	if [[ -n "$1" ]]; then
		git rebase "${1:-origin/main}"
	fi
}

,cb() {
	if [[ -n "$1" ]]; then
		git checkout -b "$1" "${2:-origin/main}"
	fi
}

,p() {
	if [[ -n "$1" ]]; then
		git push origin "$1"
	fi
}
