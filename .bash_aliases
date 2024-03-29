# Custom alias

#  -- Code --
# - Python -
alias pyt="python3.12 -m pytest -s"
alias pip="python3.12 -m pip"
alias py="python3.12"

# - CSharp -
alias cscript="dotnet script"

# - Git -
alias status="git status"
alias commit="git commit -m"
alias push="git push origin"
alias pull="git pull origin"
alias add="git add"
alias remote="git remove add origin"

#  -- Terminal --
# - Basic -
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

#	 -- Flatpak --
alias protontricks="flatpak run com.github.Matoking.protontricks"
alias protontricks-launch="flatpak run --command=protontricks-launch com.github.Matoking.protontricks"
