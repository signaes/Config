return {
  { "tpope/vim-surround" },
  { "windwp/nvim-autopairs" },
  { "windwp/nvim-ts-autotag" },
  { "terryma/vim-multiple-cursors" },
  { "RRethy/vim-illuminate" },
  -- Comments
  { "numToStr/Comment.nvim" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
}
