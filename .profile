# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# -- Custom alias --

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
alias remote="git remove add origin"

# - Terminal -
# Basic
alias c="clear"
alias xtar="tar -xvf"
alias nala="sudo nala"
alias svim="sudoedit"
alias remove="rm -rfdv"
alias execute="chmod u+x"
alias copy="cp -r"

# la and exa
if command -v exa > /dev/null; then
	alias ls="exa"
	alias la="exa -al"
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
