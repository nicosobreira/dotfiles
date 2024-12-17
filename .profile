# set PATH so it includes user's private bin if it exists
if [[ -d $HOME/.bin ]]; then
	export PATH="$HOME/.bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [[ -d $HOME/.local/bin ]]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

export PATH="/opt/nvim-linux64/bin:$PATH"

# -- Variables --
export VISUAL=$(which nvim)
export EDITOR="$VISUAL"
export REPOS="$HOME/.local/share/Repos"
export NVCONF="$HOME/.config/nvim"

# -- Alias --
[[ -f ~/.alias ]] && source ~/.alias

# la and exa
if [[ -x $(command -v exa) ]]; then
  alias la="exa -lah --no-user --no-permissions --sort=type"
  alias tree="exa --tree"
else
  alias ls="ls --color=auto"
  alias la="ls -la"
fi
