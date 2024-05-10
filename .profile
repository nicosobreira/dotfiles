# set PATH so it includes user's private bin if it exists
if [[ -d $HOME/.bin ]]; then
	PATH="$HOME/.bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [[ -d $HOME/.local/bin ]]; then
	PATH="$HOME/.local/bin:$PATH"
fi
# -- Variables --
export VISUAL=$(which nvim)
export EDITOR="$VISUAL"
export REPOS="$HOME/.local/share/Repos"
export NVCONF="$HOME/.config/nvim"

## -- Commands --
##tabs 4

# -- Custom alias --
# - Get multiple config files -

# - Nvim Layouts -
alias vv="NVIM_APPNAME=nvim-lua nvim"
alias v="nvim"
# - Code -
# Python
alias pyt="python3.12 -m pytest -s"
alias pip="python3.12 -m pip"
alias py="python3.12"

# CSharp
alias cscript="dotnet script"

# - Git -
alias status="git status"
alias commit="git commit -m"
alias push="git push origin"
alias pull="git pull origin"
alias add="git add"
alias remote="git remote add origin"

# - Terminal -
# Basic
alias v="nvim"
alias c="clear"
alias xtar="tar -xvf"
alias nala="sudo nala"
alias svim="sudoedit"
alias remove="rm -rfd"
alias execute="chmod u+x"
alias copy="cp -r"
alias duh="du --human-readable"
alias tkill="tmux kill-session"

# la and exa
if command -v exa > /dev/null; then
	alias ls="exa"
	alias la="exa -lah --no-time --no-user --no-permissions"
	alias tree="exa --tree"
else
	alias ls="ls --color=auto"
	alias la="ls -la"
fi

# cat and bat
if command -v bat > /dev/null; then
	alias cat="bat -pp --tabs 4"
fi
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

#	- Flatpak -
alias protontricks="flatpak run com.github.Matoking.protontricks"
alias protontricks-launch="flatpak run --command=protontricks-launch com.github.Matoking.protontricks"
alias flatpak-list="flatpak list --columns=name,app,size"
