return {
  "akinsho/toggleterm.nvim",
  lazy = false,
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<Leader>.]],
      hide_numbers = true,
      shade_terminals = true,
      shell = vim.o.shell,
      direction = "float",
      close_on_exit = true,
      float_opts = {
        border = "curved",
      },
    })
  end
}
