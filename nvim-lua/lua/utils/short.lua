function map(mode, lsh, rsh, opts)
	opts = opts or {noremap = true}
	vim.keymap.set(mode, lsh, rsh, opts)
end
function command (user, comm, opts)
	opts = opts or {}
	vim.api.nvim_create_user_command(user, comm, opts)
end
cmd = vim.cmd
opt = vim.opt
g = vim.g
o = vim.o
