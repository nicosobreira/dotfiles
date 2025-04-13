return {
	"tpope/vim-obsession",
	cmd = { "Obsession" },
	keys = {
		{
			"<leader>o",
			function()
				vim.cmd("Obsession! Session.vim")
			end,
			desc = "New [o]bsession"
		}
	}
}
