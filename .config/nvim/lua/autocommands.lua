local function augroup(name)
	return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Terminal options
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup("term_open"),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.spell = false
	end
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- Set spell depending on the file type
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("set_spell"),
	pattern = {"markdown", "txt", "plaintex"},
	callback = function()
		vim.opt_local.spell = true
	end
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"checkhealth",
		"dbout",
		"help",
		"lspinfo",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
					buffer = event.buf,
					silent = true,
					desc = "Quit buffer",
				})
		end)
	end,
})

-- Automatic create Header Guards
vim.api.nvim_create_autocmd("BufNewFile", {
	group = augroup("auto_create_header_guards"),
	pattern = "*.h",
	callback = function(args)
		-- Ask the user if they want a header guard
		local choice = vim.fn.input("Add header guard? [Y/N]: ")
		if choice:lower() ~= "y" then
			return
		end

		-- Extract filename without extension (uppercase for guard)
		local filename = vim.fn.fnamemodify(args.file, ":t:r"):upper()
		local guard = filename .. "_H"

		-- Insert the header guard
		local lines = {
			"#ifndef " .. guard,
			"#define " .. guard,
			"",
			"",
			"",
			"#endif // " .. guard
		}

		vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)

		-- Place cursor between the guards
		vim.api.nvim_win_set_cursor(0, {4, 0})  -- Line 4, column 0
	end
})
