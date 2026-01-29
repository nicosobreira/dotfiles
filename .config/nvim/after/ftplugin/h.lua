-- Automatic create Header Guards
vim.api.nvim_create_autocmd("BufNewFile", {
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
