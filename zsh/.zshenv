skip_global_compinit=1

export DOTFILES=$HOME/dotfiles
for FILE in $DOTFILES/terminal-conf/*
do
	source $FILE
done
for FILE in $DOTFILES/zsh-conf/*
do
	source $FILE
done
# Source variables
#source "$DOTFILES/terminal/variables.sh"

# Source alias
#source "$DOTFILES/terminal/alias.sh"

# Source commands
#source "$DOTFILES/terminal/commands.sh"
