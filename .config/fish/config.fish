if status is-interactive
  # -- Variables --
  set -U NVIM $HOME/.config/nvim
  set -U CONFIG $HOME/.config/fish/
  set -gx PAGER less

  # -- Shortcuts
  function fish_user_key_bindings
    bind \b backward-kill-word
  end
  # -- Alias --
  
   # - Code -
	alias pyt="python3.12 -m pytest -s"
	alias pip="python3.12 -m pip"
	alias py="python3.12"

  # CSharp
	alias cscript="dotnet script"

  # - Git -
	alias commit="git commit -m"
	alias push="git pull origin; git push origin"
	alias pull="git pull origin"
	alias add="git add"
	alias remote="git remote add origin"

  # - Terminal -
  # Basic
	alias v="nvim"
	alias c="clear"
	alias xtar="tar -xvf"
	alias nala="sudo nala"
	alias remove="rm -rfd"
	alias duh="du --human-readable"
	alias tkill="tmux kill-session"

  # la and exa
	if type -q exa
    alias ls="exa"
		alias la="exa -lah --no-time --no-user --no-permissions --sort=type"
		alias tree="exa --tree"
	else
		alias ls="ls --color=auto"
		alias la="ls -la"
	end
	alias dir="dir --color=auto"
	alias vdir="vdir --color=auto"
	alias grep="grep --color=auto"
	alias fgrep="fgrep --color=auto"
	alias egrep="egrep --color=auto"

  #	- Flatpak -
	alias protontricks="flatpak run com.github.Matoking.protontricks"
	alias protontricks-launch="flatpak run --command=protontricks-launch com.github.Matoking.protontricks"
	alias flatpak-list="flatpak list --columns=name,app,size"
	
  # -- Source --
  fzf --fish | source
  zoxide init fish | source
  #starship init fish | source
end
