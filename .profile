if [[ -d "$HOME/.bin" ]]; then
	export PATH="$HOME/.bin:$PATH"
fi

if [[ -d "$HOME/.local/bin" ]]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

if [[ -d "/opt/nvim-linux64/bin" ]]; then
	export PATH="/opt/nvim-linux64/bin:$PATH"
fi
# -- Variables --
if [[ `command -v nvim` ]]; then
  export VISUAL=$(which nvim)
  export EDITOR="$VISUAL"
  export MANPAGER="nvim -c 'setlocal nospell' +Man!"
fi

# -- Alias --
[[ -f ~/.alias ]] && source ~/.alias

# -- PS1 --
_ERROR_COUNT=0
function nonzero_return() {
	RETVAL=$?
	if [[ $RETVAL != 0 ]]; then
		if [[ $_ERROR_COUNT != 0 ]]; then
			_ERROR_COUNT=0
		else
			echo " [$RETVAL]"
			_ERROR_COUNT=$((_ERROR_COUNT+1))
		fi
	fi
}

#export PS1="\w\`nonzero_return\`\\$ "
