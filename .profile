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
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[1;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'

if command -v vim >/dev/null; then
	export MANPAGER="vim +MANPAGER -"
	export VISUAL=$(which vim)
	export EDITOR="$VISUAL"
	alias svim="sudo vim -u $HOME/.vimrc"
fi

# -- Alias --
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
	retval=$?

	local black="\[\033[30m\]"
	local red="\[\033[31m\]"
	local green="\[\033[32m\]"
	local yellow="\[\033[33m\]"
	local blue="\[\033[34m\]"
	local magenta="\[\033[35m\]"
	local cyan="\[\033[36m\]"
	local white="\[\033[37m\]"
	local reset="\[\033[m\]"

	nonzero_return() {
		if [[ $retval != 0 ]]; then
			echo -e " ${red}[${retval}]${reset}"
		fi
	}

	git_branch() {
		branch=$(git branch --show-current 2>/dev/null)
		if [[ "${branch}" != "" ]]
		then
			echo -e " ${magenta}(${branch})${reset}"
		fi
	}

	local prompt="\n${blue}\w${reset}"
	prompt+="$(git_branch)"
	prompt+="$(nonzero_return)\n"
	prompt+="$ "
	echo -e "${prompt}"
}

export PROMPT_COMMAND='PS1=$(__prompt_command)'
