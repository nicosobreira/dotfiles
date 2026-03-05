--- Creates an augroup with a prefix
---@param name string
local function augroup(name)
	local prefix = "custom"
	return vim.api.nvim_create_augroup(prefix .. "_" .. name, { clear = false })
end

-- Sets the concellevel automatic in markdown files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("markdown_conceal_toggle"),
	pattern = { "markdown", "rst" },
	callback = function()
		vim.api.nvim_create_autocmd("ModeChanged", {
			buffer = 0, -- Only for current buffer
			callback = function()
				local mode = vim.api.nvim_get_mode().mode
				mode = mode:sub(1, 1)

				if mode == "n" then
					-- Normal mode → conceal enabled
					vim.opt_local.conceallevel = 2
				elseif mode == "i" or mode == "v" or mode == "V" then
					-- Insert mode → conceal disabled
					vim.opt_local.conceallevel = 0
				end
			end,
		})

		local mode = vim.api.nvim_get_mode().mode
		mode = mode:sub(1, 1)

		-- Initialize based on current mode
		vim.opt_local.conceallevel = (mode == "i") and 0 or 2
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		if not file:match("://") then
			vim.fn.mkdir(vim.fs.dirname(file), "p")
		end
	end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.opt_local.buftype ~= "nofile" then
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
	pattern = { "markdown", "txt", "plaintex" },
	callback = function()
		vim.b.spell = true
	end,
})

-- Automatic create Header Guards
vim.api.nvim_create_autocmd("BufNewFile", {
	group = augroup("file_prepend"),
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
	group = augroup("file_prepend"),
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

vim.api.nvim_create_autocmd("BufNewFile", {
	group = augroup("file_prepend"),
	pattern = { "shell.nix" },
	callback = function(_)
		-- Insert the header guard
		local lines = {
			"{pkgs ? import <nixpkgs> {}}:",
			"pkgs.mkShell {",
			"  strictDeps = true;",
			"  # Tools",
			"  nativeBuildInputs = with pkgs; [",
			"  ];",
			"",
			"  # Libraries",
			"  buildInputs = with pkgs; [",
			"  ];",
			"}",
		}

		vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
	end,
})
