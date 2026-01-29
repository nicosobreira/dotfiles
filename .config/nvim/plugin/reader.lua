local float = {
	win = nil,
	bg_wins = {},
}

local default_opts = {
	percentage = { width = 1, height = 1 },
}

local function dim_backgrounds(exclude_win)
	float.bg_wins = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if win ~= exclude_win then
			vim.api.nvim_set_option_value("winhighlight", "Normal:Conceal", {
				win = win,
			})
			table.insert(float.bg_wins, win)
		end
	end
end

-- Restores background windows
local function undim_backgrounds()
	for _, win in ipairs(float.bg_wins) do
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_set_option_value("winhighlight", "", {
				win = win,
			})
		end
	end

	float.bg_wins = {}
end

local function open_buf_in_float(opts)
	opts = vim.tbl_deep_extend("force", default_opts, opts)
	local percentage = opts.percentage

	local columns = vim.o.columns
	local lines = vim.o.lines

	local width = math.floor(columns * percentage.width)
	local height = math.floor(lines * percentage.height)

	local row = math.floor((lines - height) / 2)
	local col = math.floor((columns - width) / 2)

	local buf = vim.api.nvim_get_current_buf()

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = { "", "", "", "|", "", "", "", "|" },
	})

	vim.api.nvim_set_option_value("wrap", true, {
		win = win,
	})

	vim.api.nvim_set_option_value("linebreak", true, {
		win = win,
	})

	-- dim_backgrounds(win)

	return win
end

function ReaderToggle()
	-- If window exists and is valid → close it
	if float.win and vim.api.nvim_win_is_valid(float.win) then
		vim.api.nvim_win_close(float.win, true)
		float.win = nil
		float.buf = nil

		-- undim_backgrounds()
		return
	end

	-- Otherwise create it
	local _ = open_buf_in_float({
		percentage = {
			width = 0.65,
			height = 1,
		},
	})
end

vim.keymap.set("n", "<leader>r", ReaderToggle)
