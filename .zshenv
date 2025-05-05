# Sets VARIABLES

# PATH
typeset -U path PATH
path=(~/.local/bin ~/.bin $path)
export PATH

# Set language to English
export LANG=en_US.UTF-8
export LANGUAGE=en_US

# Vim / Neovim
export MYVIMRC="$HOME/.vimrc"
if command -v nvim &>/dev/null; then
	alias vim="nvim"
	export MANPAGER="nvim +Man!"
	export VISUAL="nvim"
	export EDITOR="${VISUAL}"
elif command -v vim &>/dev/null; then
	export MANPAGER="vim +MANPAGER -"
	export VISUAL=$(which vim)
	export EDITOR="$VISUAL"
fi
