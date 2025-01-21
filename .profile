_MY_PATH=(~/.bin ~/.local/bin /opt/nvim-linux64/bin)

for dir in "${_MY_PATH[@]}"; do
	if [[ -d "$dir" ]]; then
		export PATH="$dir:$PATH"
	fi
done

# -- Variables --
if [[ $(command -v nvim) ]]; then
  export VISUAL=$(which nvim)
  export EDITOR="$VISUAL"
  export MANPAGER="nvim -c 'setlocal nospell' +Man!"
fi

# -- Alias --
[[ -f ~/.alias ]] && source ~/.alias

if [[ $(command -v exa) ]]; then
    alias la="exa -lah --no-user --no-permissions --sort=type"
    alias tree="exa --tree"
else
    alias ls="ls --color=auto"
    alias la="ls -la"
fi

# -- PS1 --
# https://ezprompt.net/
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		#STAT=`parse_git_dirty`
		echo -e " (\033[0;35m${BRANCH}${STAT}\033[m)"
	else
		echo ""
	fi
}

function nonzero_return() {
	RETVAL=$?
	if [[ $RETVAL != 0 ]]; then
        echo -e " [\033[0;31m$RETVAL\033[m]"
	fi
}

export PS1="\[\e[32m\]\u\[\e[m\]:\[\e[34m\]\w\[\e[m\]\[\e[37m\]\`nonzero_return\`\[\e[m\]\`parse_git_branch\`\\$ "

# Generated for envman. Do not edit.
