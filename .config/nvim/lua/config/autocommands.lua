--- Creates an augroup with a prefix
---@param name string
local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

local markdown_group = augroup("MarkdownConceal")

-- Sets the concellevel automatic in markdown files
vim.api.nvim_create_autocmd("FileType", {
	group = markdown_group,
	pattern = "markdown",
	callback = function(args)
		local bufnr = args.buf

		local function set_normal_mode()
			vim.opt_local.conceallevel = 2
			vim.opt_local.list = false
		end

		local function set_insert_mode()
			vim.opt_local.conceallevel = 0
			vim.opt_local.list = true
		end

		set_normal_mode()

		vim.api.nvim_create_autocmd("InsertEnter", {
			group = markdown_group,
			buffer = bufnr,
			callback = set_insert_mode,
		})

		vim.api.nvim_create_autocmd("InsertLeave", {
			group = markdown_group,
			buffer = bufnr,
			callback = set_normal_mode,
		})
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
	group = augroup("CreateDirectorysRecursive"),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		if not file:match("://") then
			vim.fn.mkdir(vim.fs.dirname(file), "p")
		end
	end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("CheckTime"),
	callback = function()
		if vim.opt_local.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("HightLightYank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- Automatic create Header Guards
vim.api.nvim_create_autocmd("BufNewFile", {
	group = augroup("FilePrepend"),
	pattern = { "*.h", "*.hpp" },
	callback = function(args)
		local lines = { "" }
		local cursorPos = { 0, 0 }

		-- Ask the user if they want a header guard
		local choice = vim.fn.input("Add header guard? [Y/N]: ")
		if choice:lower() == "y" then
			-- Extract filename without extension (uppercase for guard)
			local filename = vim.fn.fnamemodify(args.file, ":t:r"):upper()
			local guard = "_" .. filename .. "_H"

			-- Insert the header guard
			lines = {
				"#ifndef " .. guard,
				"#define " .. guard,
				"",
				"",
				"",
				"#endif // " .. guard,
			}

			cursorPos = { 4, 0 }
		else
			lines = {
				"#pragma once",
				"",
			}

			cursorPos = { 3, 0 }
		end

		vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)

		-- Place cursor between the guards
		vim.api.nvim_win_set_cursor(0, cursorPos)
	end,
})

-- Automatic create Shebang
vim.api.nvim_create_autocmd("BufNewFile", {
	group = augroup("Shebang"),
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
		vim.api.nvim_win_set_cursor(0, { 3, 0 })
	end,
})
