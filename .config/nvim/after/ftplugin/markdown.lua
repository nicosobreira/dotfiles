local decorate = function(lines, range_start, range_end)
	-- vim.cmd([[! tr -s " "]])
	vim.cmd([[!column -t -s '|' -o '|']])
end

vim.api.nvim_create_user_command("TableFormat", function(opts)
	if opts.range == 0 then
		vim.print("ERROR: Select a table using V")
		return 1
	end

	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)

	decorate(lines, opts.line1, opts.line2)
end,
	{
		nargs = 0,
		desc = "Format a markdown table",
		range = true,
	}
)
