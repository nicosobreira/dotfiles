local M = {}

-- Default configuration
M.config = {
	width = 0.5, -- fraction of editor width (0.0 – 1.0)
	cursor_line = 0.25, -- cursor stays at this fraction from the top
}

-- Internal state
local state = {
	win = nil,
	buf = nil,
	src_buf = nil,
	autocmd_group = nil,
}

-- Return true if the reader window is currently open
local function is_open()
	return state.win ~= nil and vim.api.nvim_win_is_valid(state.win)
end

-- Calculate window dimensions from current editor size
local function get_dimensions()
	local lines = vim.o.lines - vim.o.cmdheight - (vim.o.laststatus > 0 and 1 or 0)
	local cols = vim.o.columns
	local height = lines
	local width = math.max(1, math.floor(cols * M.config.width))
	local row = 0
	local col = math.floor((cols - width) / 2)
	return { height = height, width = width, row = row, col = col }
end

-- Mirror the source buffer content into the reader buffer
local function sync_content()
	if not state.src_buf or not vim.api.nvim_buf_is_valid(state.src_buf) then
		return
	end
	if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
		return
	end

	local lines = vim.api.nvim_buf_get_lines(state.src_buf, 0, -1, false)
	vim.bo[state.buf].modifiable = true
	vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
	vim.bo[state.buf].modifiable = false
end

-- Scroll so the cursor sits at one-quarter of the visible window height
local function anchor_cursor()
	if not is_open() then
		return
	end
	local win_height = vim.api.nvim_win_get_height(state.win)
	local cursor_row = vim.api.nvim_win_get_cursor(state.win)[1]
	-- desired screen line for cursor (1-indexed from top of window)
	local target_line = math.max(1, math.floor(win_height * M.config.cursor_line))
	-- topline = cursor_row - (target_line - 1)
	local topline = math.max(1, cursor_row - target_line + 1)
	vim.api.nvim_win_set_option(state.win, "scrolloff", 0)
	-- Use winrestview to set the topline precisely
	vim.api.nvim_win_call(state.win, function()
		vim.fn.winrestview({ topline = topline })
	end)
end

-- Open the reader window
function M.open()
	if is_open() then
		return
	end

	state.src_buf = vim.api.nvim_get_current_buf()

	-- Create a scratch buffer for the reader
	state.buf = vim.api.nvim_create_buf(false, true)
	vim.bo[state.buf].buftype = "nofile"
	vim.bo[state.buf].bufhidden = "wipe"
	vim.bo[state.buf].swapfile = false
	vim.bo[state.buf].filetype = vim.bo[state.src_buf].filetype

	-- Populate content
	sync_content()

	-- Open a floating window
	local d = get_dimensions()
	state.win = vim.api.nvim_open_win(state.buf, true, {
		relative = "editor",
		row = d.row,
		col = d.col,
		width = d.width,
		height = d.height,
		style = "minimal",
		border = { "", "", "", "|", "", "", "", "|" },
		zindex = 45,
	})

	-- Window-local options for a distraction-free reading experience
	local wo = vim.wo[state.win]
	wo.wrap = true
	wo.linebreak = true
	wo.number = false
	wo.relativenumber = false
	wo.signcolumn = "no"
	wo.foldcolumn = "0"
	wo.colorcolumn = ""
	wo.cursorline = true
	wo.scrolloff = 0

	-- Enforce read-only in the floating window
	vim.bo[state.buf].modifiable = false
	vim.bo[state.buf].readonly = true

	-- Register autocmds scoped to this session
	state.autocmd_group = vim.api.nvim_create_augroup("ReaderPlugin", { clear = true })

	-- Keep cursor anchored at ¼ whenever it moves
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = state.autocmd_group,
		buffer = state.buf,
		callback = anchor_cursor,
	})

	-- Resize the float when the editor is resized
	vim.api.nvim_create_autocmd("VimResized", {
		group = state.autocmd_group,
		callback = function()
			if not is_open() then
				return
			end
			local nd = get_dimensions()
			vim.api.nvim_win_set_config(state.win, {
				relative = "editor",
				row = nd.row,
				col = nd.col,
				width = nd.width,
				height = nd.height,
			})
			anchor_cursor()
		end,
	})

	-- Sync content if the source buffer changes
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufWritePost" }, {
		group = state.autocmd_group,
		buffer = state.src_buf,
		callback = function()
			sync_content()
		end,
	})

	-- Clean up state when the window is closed
	vim.api.nvim_create_autocmd("WinClosed", {
		group = state.autocmd_group,
		pattern = tostring(state.win),
		callback = function()
			M._cleanup()
		end,
	})

	vim.keymap.set("n", "q", function()
		vim.api.nvim_buf_delete(state.buf, {})
	end, { buffer = state.buf })

	anchor_cursor()
end

-- Close the reader window
function M.close()
	if is_open() then
		vim.api.nvim_win_close(state.win, true)
	end
	M._cleanup()
end

-- Toggle open / close
function M.toggle()
	if is_open() then
		M.close()
	else
		M.open()
	end
end

-- Internal cleanup (called by autocmd or close())
function M._cleanup()
	if state.autocmd_group then
		pcall(vim.api.nvim_del_augroup_by_id, state.autocmd_group)
		state.autocmd_group = nil
	end
	state.win = nil
	state.buf = nil
	state.src_buf = nil
end

-- Setup called by lazy.nvim (or any plugin manager)
---@param opts table|nil
function M.setup(opts)
	opts = opts or {}
	M.config = vim.tbl_deep_extend("force", M.config, opts)

	-- Validate width
	if type(M.config.width) ~= "number" or M.config.width <= 0 or M.config.width > 1 then
		vim.notify("[reader.nvim] 'width' must be a number between 0 and 1. Resetting to 0.5", vim.log.levels.WARN)
		M.config.width = 0.5
	end

	-- User commands
	vim.api.nvim_create_user_command("ReaderOpen", M.open, { desc = "Open reader window" })
	vim.api.nvim_create_user_command("ReaderClose", M.close, { desc = "Close reader window" })
	vim.api.nvim_create_user_command("ReaderToggle", M.toggle, { desc = "Toggle reader window" })
end

return M
