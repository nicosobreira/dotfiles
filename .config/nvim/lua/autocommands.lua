local function augroup(name)
	return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

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

-- Different folding methods depending on file type
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("fold_method_sytax"),
	pattern = { "c", "cpp", "java", "php" },
	callback = function()
		vim.opt_local.foldmethod = "syntax"
	end
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("fold_method_indent"),
	pattern = "python",
	callback = function()
		vim.opt_local.foldmethod = "indent"
	end
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("fold_method_marker"),
	pattern = "vim",
	callback = function()
		vim.opt_local.foldmethod = "marker"
	end
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
