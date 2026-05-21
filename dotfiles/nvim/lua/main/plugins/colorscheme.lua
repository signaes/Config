return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm",
      styles = {
        functions = {
          italic = true,
        },
      },
      on_colors = function() end,
      on_highlights = function() end,
    })

    vim.cmd([[colorscheme tokyonight]])
  end,
}
