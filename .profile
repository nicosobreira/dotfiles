_MY_PATH=(~/.bin ~/.local/bin)

for dir in "${_MY_PATH[@]}"; do
	if [[ ! -d "$dir" ]]; then
		continue
	fi
	if [[ "$PATH" =~ "$dir" ]]; then
		continue
	fi
		export PATH="$PATH:$dir"
done

# -- Variables --
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[m'
export LESS_TERMCAP_se=$'\e[m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[m'
export LESS_TERMCAP_us=$'\e[1;32m'

if command -v nvim >/dev/null; then
	_NVIM='nvim -u $HOME/.vimrc'
	alias vim="${_NVIM}"
	export MANPAGER="${_NVIM} +Man!"
	export VISUAL="${_NVIM}"
	export EDITOR="${VISUAL}"
	alias svim="sudo ${_NVIM}"
elif command -v vim >/dev/null; then
	export MANPAGER="vim +MANPAGER -"
	export VISUAL=$(which vim)
	export EDITOR="$VISUAL"
	alias svim="sudo vim -u $HOME/.vimrc"
fi

# -- Alias --
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias make='make -j$(nproc)'
alias c="clear"
alias duh="du --human-readable"
alias mkdir="mkdir -p"

alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias ls="ls -h --color=auto"
alias la="ls --almost-all --dereference-command-line --color=auto --format=single-column --human-readable --size --group-directories-first --sort=version"
alias tree="tree -a -C"

# -- Better Prompt --
__prompt_command() {
	local retval=$?

	local black="\e[30m"
	local red="\e[31m"
	local green="\e[32m"
	local yellow="\e[33m"
	local blue="\e[34m"
	local magenta="\e[35m"
	local cyan="\e[36m"
	local white="\e[37m"
	local reset="\e[m"

	nonzero_return() {
		if [[ $retval != 0 ]]; then
			echo -ne " ${red}[${retval}]${reset}"
		fi
	}

	git_branch() {
		local branch=$(git branch --show-current 2>/dev/null)
		if [[ -n "$branch" ]]; then
			echo -ne " ${magenta}(${branch})${reset}"
		fi
	}

	local sep="$"
	PS1="\n${blue}\w${reset}"
	PS1+="$(git_branch)"
	PS1+="$(nonzero_return)"
	PS1+="\n${sep} "
}

export PROMPT_COMMAND='__prompt_command'
