return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  priority = 1000,
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
      require("nvim-tree").setup{
        auto_reload_on_write = true,
        view = {
          adaptive_size = true,
          centralize_selection = false,
          width = 40,
          side = "right",
          preserve_window_proportions = false,
          number = false,
          relativenumber = false,
          signcolumn = "yes",
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          debounce_delay = 50,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        filters = {
          dotfiles = false,
          custom = {},
          exclude = {},
        },
        git = {
          enable = true,
          ignore = true,
          show_on_dirs = true,
          timeout = 400,
        },
        trash = {
          cmd = "gio trash",
          require_confirm = true,
        },
      } 
  end
}
