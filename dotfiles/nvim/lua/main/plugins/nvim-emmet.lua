return {
	"olrtg/nvim-emmet",
	config = function()
		vim.keymap.set({ "n" }, "<c-e>", require("nvim-emmet").wrap_with_abbreviation)
	end,
}
