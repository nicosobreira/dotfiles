# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return ;;
esac

# append to the history file, don't overwrite it
shopt -s histappend
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=erasedups:ignoredups

shopt -s checkwinsize

[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"

export LANG=en_US.UTF-8
export LANGUAGE=en_US

# Custom PATH
_MY_PATH=("$HOME/.bin" "$HOME/.local/bin")

for _dir in "${_MY_PATH[@]}"; do
	if [[ -d "${_dir}" ]] && [[ ! ":${PATH}:" =~ :${_dir}: ]]; then
		export PATH="${_dir}:${PATH}"
	fi
done

_SOURCES=("$HOME/.env" /usr/share/bash-completion/bash_completion /etc/bash_completion "$HOME/.cargo/env")
for _file in "${_SOURCES[@]}"; do
	[[ -f "${_file}" ]] && source "${_file}"
done

# Dircolors setup
if command -v dircolors &>/dev/null; then
	if [[ -f ~/.dircolors ]]; then
		eval "$(dircolors -b ~/.dircolors)"
	else
		eval "$(dircolors -b)"
	fi
fi

if command -v fzf &>/dev/null; then
	eval "$(fzf --bash)"
fi

# -- Variables --
# `man -P less` have color support
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[m'
export LESS_TERMCAP_se=$'\e[m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[m'
export LESS_TERMCAP_us=$'\e[1;32m'

export LESS="-R"
export MYVIMRC="$HOME/.vimrc"

if command -v nvim &>/dev/null; then
	alias v="nvim"
	export MANPAGER="nvim +Man!"
	export VISUAL="nvim"
	export EDITOR="${VISUAL}"
elif command -v vim &>/dev/null; then
	export MANPAGER="vim +MANPAGER -"
	export VISUAL="$(which vim)"
	export EDITOR="$VISUAL"
fi

# -- Functions --
function reload() {
	[[ -f "$HOME/.profile" ]] && source "$HOME/.profile"
}

function notes() {
	local notes_file="$HOME/.notes"

	[[ ! -f "$notes_file" ]] && return
	[[ ! -s "$notes_file" ]] && return  # File is empty

	printf "\tNOTES\n"
	cat "$notes_file"
}

# -- Alias --
alias tm="tmux-manager"
alias l="lazygit"

alias svim='sudo vim -u $HOME/.vimrc'
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
function __prompt_command() {
	local retval=$?

	local sep="$"
	# local black="\e[30m"
	local red="\e[31m"
	# local green="\e[32m"
	# local yellow="\e[33m"
	local blue="\e[34m"
	local magenta="\e[35m"
	local cyan="\e[36m"
	# local white="\e[37m"
	local reset="\e[m"

	function _nonzero_return() {
		if [[ "$retval" -ne 0 ]]; then
			printf " %s[%s]%s" "${red}" "${retval}" "${reset}"
		fi
	}

	function _git_branch() {
		local branch
		branch=$(git branch --show-current 2>/dev/null)
		if [[ -n "$branch" ]]; then
			printf " %s(%s)%s" "${magenta}" "${branch}" "${reset}"

		fi
	}

	function _nix_shell() {
		if [[ $NIX_BINTOOLS ]]; then
			printf " %s{%s}%s" "${cyan}" "nix" "${reset}"
		fi
	}

	PS1="\n"

	PS1+="${blue}\w${reset}"
	PS1+="$(_git_branch)"
	PS1+="$(_nonzero_return)"
	PS1+="$(_nix_shell)"
	PS1+="\n"
	PS1+="${sep} "
}

export PROMPT_COMMAND='__prompt_command'

notes
