# - Colors -
autoload -U colors && colors

# -- History --
setopt histignorealldups sharehistory
setopt extended_history       # record timestamp of command in H
setopt hist_expire_dups_first # delete duplicates first when HIS
setopt hist_ignore_dups       # ignore duplicated commands histo
setopt hist_ignore_space      # ignore commands that start with 
setopt hist_verify            # show command with history expans
setopt share_history          # share command history data

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# -- Autocomplete --
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# load bash completion functions
autoload -U +X bashcompinit && bashcompinit

# -- Key maps --
bindkey -e

# -- Evals --
if command -v fzf &>/dev/null; then
	eval "$(fzf --zsh)"
fi

# -- Functions --
function dwm-make() {
	if ! command -v dwm &>/dev/null; then
		echo "Command \"dwm\" not found"
		return
	fi

	local current_dir="$PWD"

	echo -e "\tDwmblocks"

	cd "$HOME/suckless/dwmblocks"
	sudo make clean install
	kill -TERM $(pidof dwmblocks)
	dwmblocks &>/dev/null &

	echo -e "\tDwm"

	cd "$HOME/suckless/dwm"
	sudo make clean install

	cd "$current_dir"
}

function cht() {
	local style="dracula"
	local query="$*"
	query="${query// /+}"
	curl -s "cht.sh/${query}?style=${style}" | $PAGER
}

function y() {
	if ! command -v yazi >/dev/null; then
		echo "Command \"yazi\" not found"
		return
	fi

	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [[ -n "$cwd" ]] && [[ "$cwd" != "$PWD" ]]; then
		builtin cd -- "$cwd" || return
	fi
	rm -f -- "$tmp"
}

function reload() {
	[[ -f "$HOME/.zprofile" ]] && source "$HOME/.zprofile"
}

function notes() {
	local notes_file="$HOME/.notes"
	[[ ! -f "$notes_file" ]] && return  # File not found
	[[ ! -s "$notes_file" ]] && return  # File is empty
	printf "\tNOTES\n"
	cat "$notes_file"
}

# -- Alias --
alias dwm-edit='$EDITOR $HOME/suckless/dwm/config.h'

alias svim='sudo vim -u $HOME/.vimrc'
alias make='make -j$(nproc)'
alias c="clear"
alias duh="du --human-readable"
alias mkdir="mkdir -p"

alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias ls="ls -h --color=always"
alias la="ls --almost-all --dereference-command-line --color=always --format=single-column --human-readable --group-directories-first --sort=version"
alias tree="tree -a -C"
alias ..="cd .."
alias ...="cd ../.."

# -- Prompt --
autoload -Uz promptinit && promptinit

function prompt_better_setup() {
PS1='
%F{blue}%~%f
$ '
}

prompt_themes+=( better )
prompt better

notes
