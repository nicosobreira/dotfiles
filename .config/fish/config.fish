# Only run in interactive shells
if not status is-interactive
	exit
end

set fish_greeting

# Set Terminal Lang to English
set -gx LANG en_US.UTF-8
set -gx LANGUAGE en_US

# Custom PATH
set -l my_path $HOME/.bin $HOME/.local/bin

for dir in $my_path
	if test -d $dir
		and not contains $dir $PATH
		set -gx PATH $dir $PATH
	end
end

# FZF setup
if command -v fzf >/dev/null
	fzf --fish | source
end

# Less man colors
set -gx LESS_TERMCAP_mb (printf "\e[1;35m")
set -gx LESS_TERMCAP_md (printf "\e[1;35m")
set -gx LESS_TERMCAP_me (printf "\e[m")
set -gx LESS_TERMCAP_se (printf "\e[m")
set -gx LESS_TERMCAP_so (printf "\e[1;44;33m")
set -gx LESS_TERMCAP_ue (printf "\e[m")
set -gx LESS_TERMCAP_us (printf "\e[1;32m")

set -gx LESS "-R"
set -gx MYVIMRC "$HOME/.vimrc"

# Editor settings
if command -v nvim >/dev/null
	alias v="nvim"
	set -gx MANPAGER "nvim +Man!"
	set -gx VISUAL "nvim"
	set -gx EDITOR "$VISUAL"
else if command -v vim >/dev/null
	set -gx MANPAGER "vim +MANPAGER -"
	set -gx VISUAL (which vim)
	set -gx EDITOR "$VISUAL"
end

# Functions
function dwm-make
	if ! command -v dwm >/dev/null
		echo "Command \"dwm\" not found"
		return
	end

	set -l current_dir $PWD

	echo -e "\tDwmblocks"

	cd "$HOME/suckless/dwmblocks" || return
	sh -c "sudo make clean install"
	pkill -TERM dwmblocks
	dwmblocks >/dev/null 2>&1 &

	echo -e "\tDwm"

	cd "$HOME/suckless/dwm" || return
	sh -c "sudo make clean install"

	cd "$current_dir" || return
end

function y
	if ! command -v yazi >/dev/null
		echo "Command \"yazi\" not found"
		return
	end

	set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set -l cwd (cat -- "$tmp") && test -n "$cwd" && test "$cwd" != "$PWD"
		cd -- "$cwd" || return
	end
	rm -f -- "$tmp"
end

function notes
	set -l notes_file "$HOME/.notes"
	if not test -f "$notes_file"  # File not found
		return
	end
	if not test -s "$notes_file"  # File is empty
		return
	end
	printf "\tNOTES\n"
	cat "$notes_file"
end

# Aliases
alias dwm-edit='$EDITOR $HOME/suckless/dwm/config.h'

alias l="lazygit"

alias svim='sudo $EDITOR -u $HOME/.vimrc'
alias make='make -j(nproc)'
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

notes
