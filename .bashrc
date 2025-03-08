# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*)
		;;
	*)
		return
		;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=erasedups:ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"

# Set Terminal Lang to English
export LANG=en_US.UTF-8
export LANGUAGE=en_US

_SOURCES=(/etc/bashrc /usr/share/bash-completion/bash_completion /etc/bash_completion $HOME/.profile $HOME/.cargo/env)
for file in "${_SOURCES[@]}"; do
	[[ ! -f "$file" ]] && continue
	source "$file"
done

if command -v fzf >/dev/null; then
	eval "$(fzf --bash)"
fi

if command -v zoxide >/dev/null; then
	eval "$(zoxide init bash)"
fi
