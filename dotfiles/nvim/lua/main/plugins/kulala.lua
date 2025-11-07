return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>fks", desc = "Send request" },
    { "<leader>fka", desc = "Send all requests" },
    { "<leader>fks", desc = "Open scratchpad" },
  },
  ft = { "http", "rest" },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>fk",
    kulala_keymaps_prefix = "",
  },
}
