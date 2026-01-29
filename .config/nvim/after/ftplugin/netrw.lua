-- Navigation mappings
vim.keymap.set("n", "h", "-", { buffer = true, remap = true, desc = "Up directory" })
vim.keymap.set("n", "l", "<CR>", { buffer = true, remap = true, desc = "Open directory/file" })

-- File operations
vim.keymap.set("n", "a", "%", { buffer = true, remap = true, desc = "Create file" })
vim.keymap.set("n", "r", "R", { buffer = true, remap = true, desc = "Rename file" })

require("custom.ftclose").setup()

-- NOTE: This settings are buggy
-- vim.g.netrw_list_hide = "^\\./$,^\\.\\./$"
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_hide = 1
-- vim.g.netrw_banner = 0
-- vim.g.netrw_altfile = 1
-- vim.g.netrw_alto = 1
