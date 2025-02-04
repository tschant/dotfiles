alias ,s="git status" \
	,l="git log" \
	,f="git fetch --all" \
	,c="git checkout" \
	,stash="git stash" \
	,glog="git glog" \
	,show="git show" \
	,dft="git dft" \
	,p="git push origin"

,rb() {
	BRANCH="${1:-origin/main}"
	echo "Rebasing $BRANCH"
	git fetch --all
	git rebase "$BRANCH"
}

,cb() {
	if [[ -n "$1" ]]; then
		BASE_BRANCH="${2:-origin/main}"
		NAME="$(whoami)"
		echo "Checkout new branch $NAME/$1, base $BASE_BRANCH"
		git fetch --all
		git checkout -b "$NAME/$1" "$BASE_BRANCH"
	fi
}

# ,p() {
# 	if [[ -n "$1" ]]; then
# 		echo "Push to branch $1"
# 		git push origin "$1"
# 	fi
# }
