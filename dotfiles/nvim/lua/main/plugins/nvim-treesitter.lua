return {
  "nvim-treesitter/nvim-treesitter",
  build = ':TSUpdate',
  dependencies = { "HiPhish/rainbow-delimiters.nvim" },
  config = function()
    require('nvim-treesitter.install').prefer_git = true

    require("nvim-treesitter.configs").setup({
      modules = {},
      sync_install = false,
      auto_install = true,
      ignore_install = { "php", "phpdoc" }, -- List of parsers to ignore installing
      highlight = {
        enable = true,                      -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
      },
      ensure_installed = {
        "bash",
        "diff",
        "html",
        "markdown",
        "markdown_inline",
        "vim",
        "lua",
        "python",
        "ruby",
        "typescript",
        "javascript",
        "json",
        "scss",
        "rust",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "zig",
      }, -- one of "all" or a list of languages
      autopairs = {
        enable = true,
      },
      indent = { enable = true, disable = { "python", "css", "ruby" } },
    })
  end
}
