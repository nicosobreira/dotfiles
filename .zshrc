# -- Basic --
# - Colors -
autoload -U colors && colors

# - Autocomplete -
# Add space to final
#zstyle ':autocomplete:*' add-space \
#    executables aliases functions builtins reserved-words commands
# Alias - green
#zstyle ':completion:*:aliases' list-colors '=*=1;33'

# - Others -
setopt histignorealldups sharehistory
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# -- Aliases --
profile="$HOME/.profile"
if [ -f $profile ]; then
	source $profile
fi

# -- Znap Init --
# Download Znap, if it's not there yet.
[[ -r ~/Repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap
source ~/Repos/znap/znap.zsh  # Start Znap

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

# - Other -
# Sytax highlight
file="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -f $file ]; then
	source $file
fi
