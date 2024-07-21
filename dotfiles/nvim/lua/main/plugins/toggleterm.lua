return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]],
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
