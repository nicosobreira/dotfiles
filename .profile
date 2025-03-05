_MY_PATH=(~/.bin ~/.local/bin)

for dir in "${_MY_PATH[@]}"; do
	if [[ ! -d "$dir" ]]; then
		continue
	fi
	if [[ $PATH == *"$dir"* ]]; then
		continue
	fi
	PATH="$dir:$PATH"
done

# -- Variables --
export MANPAGER="less -R"
if command -v nvim >/dev/null; then
	export VISUAL=$(which nvim)
	export EDITOR="$VISUAL"
	export MANPAGER="less -R"
else
	export VISUAL=$(which vim)
	export EDITOR="$VISUAL"
fi

# -- Alias --
# - Code -
alias make='make -j$(nproc)'

# - Terminal -
# Basic
alias c="clear"
alias duh="du --human-readable"
alias mkdir="mkdir -p"

alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias ls="ls -h --color=auto"
alias la="ls -a --color=auto --format=single-column -h -s --group-directories-first --sort=version"
alias tree="tree -a -C"

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

function __nonzero_return() {
	if [[ $? != 0 ]]; then
		echo -e " \033[0;31m[${?}]\033[m"
	fi
}

function __git_branch() {
	branch=$(git branch --show-current 2>/dev/null)
	if [[ "${branch}" != "" ]]
	then
		# This echo generates a new retval this is the problem
		echo -e " \033[0;35m(${branch})\033[m"
	fi
}

export PS1="\n${__BLUE}\w${__RESET}"
PS1+="\`__nonzero_return\`"
PS1+="\`__git_branch\`\n"
PS1+="$ "
. "$HOME/.cargo/env"
