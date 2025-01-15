if status is-interactive
  # -- Variables --
  set -gx NVIM $HOME/.config/nvim
  set -gx FISH $HOME/.config/fish/
  set -gx VISUAL (which nvim)
  set -gx EDITOR $VISUAL
  set -gx PAGER less
  set -gx MANPAGER "nvim -c 'setlocal nospell' +Man!"
  set -gx fish_greeting ""
  
  # -- Shortcuts
  function fish_user_key_bindings
    bind \b backward-kill-word
  end
  
  # -- Alias --
  [ -f ~/.alias ] && source ~/.alias
  # la and exa
  if type -q exa
    alias la="exa -lah --no-user --no-permissions --sort=type"
    alias tree="exa --tree --sort=type"
  else
    alias ls="ls --color=auto"
    alias la="ls -la"
  end
	
  # -- Source --
  fzf --fish | source
  zoxide init fish | source
end

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
