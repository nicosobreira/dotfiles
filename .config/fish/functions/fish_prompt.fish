function fish_prompt
	set -l last_status $status
	set -l normal (set_color normal)
	set -l status_color (set_color brgreen)
	set -l cwd_color (set_color brblue)
	set -l vcs_color (set_color brpurple)
	set -l prompt_status ""

	# Since we display the prompt on a new line allow the directory names to be longer.
	set -q fish_prompt_pwd_dir_length
	or set -lx fish_prompt_pwd_dir_length 0

	# Color the prompt differently when we're root
	set -l suffix '$'
	if functions -q fish_is_root_user; and fish_is_root_user
		if set -q fish_color_cwd_root
			set cwd_color (set_color $fish_color_cwd_root)
		end
		set suffix '#'
	end

	# Color the prompt in red on error
	if test $last_status -ne 0
		set status_color (set_color $fish_color_error)
		set prompt_status $status_color "[" $last_status "]" $normal
	end

	echo
	echo -s $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
	echo -n -s $status_color $suffix ' ' $normal
end

function right_prompt
# function fish_right_prompt --description "Write the right prompt"
	# set -l total_seconds $CMD_DURATION
	set -l total_seconds (math ceil 100 / 1000)
	# set -l total_seconds (math ceil $CMD_DURATION / 1000)

	set -l hours (math -s0 "$total_seconds / 3600")
	set -l minutes (math -s0 "($total_seconds % 3600) / 60")
	set -l seconds (math -s0 "$total_seconds % 60")

	echo -s (set_color yellow)

	switch $hours
		case "0"
			if not test $minutes -eq 0
				printf "%sm" $minutes
			end
		case '*'
			printf "%sh" $hours
			printf "%sm" $minutes
	end
	printf "%ss" $seconds
end
