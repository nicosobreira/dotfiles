# Set up the prompt

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
[[ -r ~/.config/repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.config/repos/znap
source ~/.config/repos/znap/znap.zsh  # Start Znap

# -- Plugins --
# - Znap -
znap source marlonrichert/zsh-autocomplete

# - Other -
# Sytax highlight
file="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -f $file ]; then
	source $file
fi
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
