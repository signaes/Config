return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { "<Leader>ff",  "<CMD>lua require('telescope.builtin').find_files()<CR>", desc = "Find Files" },
    { "<Leader>fg",  "<CMD>Telescope live_grep<CR>",                           desc = "Live Grep" },
    { "<Leader>fb",  "<CMD>Telescope buffers<CR>",                             desc = "Buffers" },
    { "<Leader>fh",  "<CMD>Telescope help_tags<CR>",                           desc = "Help Tags" },
    { "<Leader>ftg", "<CMD>Telescope git_files<CR>",                           desc = "Git Files" },
    { "<Leader>fs",  "<CMD>Telescope grep_string<CR>",                         desc = "Grep String" },
    { "<Leader>fo",  "<CMD>Telescope oldfiles<CR>",                            desc = "Old Files" },
  },
}
