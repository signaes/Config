return {
  "nvim-treesitter/nvim-treesitter",
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.install').prefer_git = true

    require("nvim-treesitter.configs").setup({
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
      },                                    -- one of "all" or a list of languages
      auto_install = true,
      ignore_install = { "php", "phpdoc" }, -- List of parsers to ignore installing
      highlight = {
        enable = true,                      -- false will disable the whole extension
        disable = { "css" },                -- list of language that will be disabled
        additional_vim_regex_highlighting = { "ruby" },
      },
      autopairs = {
        enable = true,
      },
      indent = { enable = true, disable = { "python", "css", "ruby" } },
      rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
      },
    })
  end
}
