if not status is-interactive
	exit 0
end

# -- Variables --
set -gx NVIM $HOME/.config/nvim
set -gx FISH $HOME/.config/fish/
set -gx VISUAL (which nvim)
set -gx EDITOR $VISUAL
set -gx PAGER less
set -gx MANPAGER "less -R"
set -gx fish_greeting ""

# -- Shortcuts
function fish_user_key_bindings
bind \b backward-kill-word
end

# -- Alias --
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
# la and exa
if type -q exa
    alias la="exa -lah --no-user --no-permissions --sort=type"
    alias tree="exa --tree --sort=type"
else
    alias ls="ls --color=auto"
    alias la="ls -la"
end

# -- Source --
zoxide init fish | source
