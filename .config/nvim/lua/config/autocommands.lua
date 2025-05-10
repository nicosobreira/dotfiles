---@param name string
local function augroup(name)
	return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Terminal options
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup("term_open"),
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.wo.spell = false
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
		vim.wo.spell = true
	end
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.wo.conceallevel = 0
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
					desc = "[q]uit buffer",
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
		vim.api.nvim_win_set_cursor(0, {4, 0})
	end
})

-- Automatic create Shebang
vim.api.nvim_create_autocmd("BufNewFile", {
	group = augroup("auto_create_shebang"),
	pattern = "*.sh",
	callback = function(_)
		local shell = vim.fn.input("Add Shebang [press ENTER to NONE]: ")
		if shell:lower() == "" then
			return
		end

		local lines = {
			"#!/usr/bin/env " .. shell,
			"",
			"",
		}

		vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)

		-- Place cursor some spaces  below
		vim.api.nvim_win_set_cursor(0, {3, 0})
	end
})

-- Sets the concellevel automatic in markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.api.nvim_create_autocmd("ModeChanged", {
			buffer = 0,  -- Only for current buffer
			callback = function()
				vim.wo.conceallevel = (vim.fn.mode() == "i") and 0 or 2
			end
		})
		-- Initialize based on current mode
		vim.wo.conceallevel = (vim.fn.mode() == "i") and 0 or 2
	end
})
