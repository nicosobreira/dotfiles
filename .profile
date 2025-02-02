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
else
	export VISUAL=$(which vim)
	export EDITOR="$VISUAL"
fi

# -- Alias --
[[ -f ~/.alias ]] && source ~/.alias

if [[ $(command -v exa) ]]; then
    alias la="exa -lah --no-user --no-permissions --sort=type"
    alias tree="exa --tree"
else
    alias ls="ls -h --color=auto"
    alias la="ls -la"
fi

# -- PS1 --
# https://ezprompt.net/
__BLACK="\[\033[30m\]"
__RED="\[\033[31m\]"
__GREEN="\[\033[32m\]"
__YELLOW="\[\033[33m\]"
__BLUE="\[\033[34m\]"
__MAGENTA="\[\033[35m\]"
__CYAN="\[\033[36m\]"
__WHITE="\[\033[37m\]"
__RESET="\[\033[m\]"

function __parse_git_branch() {
	BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	if [ ! "${BRANCH}" == "" ]
	then
		echo -e " \033[0;35m(${BRANCH})\033[m"
	fi
}

function __nonzero_return() {
	if [[ $? != 0 ]]; then
        echo -e " [\033[0;31m$?\033[m]"
	fi
}

PS1="${__BLUE}\w${__RESET}"
PS1+='$(__parse_git_branch)'
PS1+='$(__nonzero_return)\n'
PS1+="$ "

# Generated for envman. Do not edit.
