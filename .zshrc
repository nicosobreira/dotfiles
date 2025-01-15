# -- Basic -- # - Profile -
profile="$HOME/.profile"
if [ -f $profile ]; then
	source $profile
fi

# - Colors -
autoload -U colors && colors

# - Others -
setopt histignorealldups sharehistory
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# -- Znap Init --
# Download Znap, if it's not there yet.
znap_folder="$REPOS/znap"
[[ -r "$znap_folder/znap.zsh" ]] ||
	git clone --depth 1 -- \
		https://github.com/marlonrichert/zsh-snap.git $znap_folder
source "$znap_folder/znap.zsh"  # Start Znap

# -- Plugins --
# - Source -
znap source marlonrichert/zsh-autocomplete
# - Function -
# Lazy-load some features
znap function _pyenv pyenv "znap eval pyenv 'pyenv init - --no-rehash'"
compctl -K    _pyenv pyenv

# - Eval -
znap eval starship 'starship init zsh'
znap eval zoxide 'zoxide init zsh'
znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'
#znap eval fzf '$(fzf --zsh)'

# - Other -
# Sytax highlight
file="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -f $file ]; then
	source $file
fi

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
