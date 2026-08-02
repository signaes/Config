return {
  "folke/snacks.nvim",
  keys = {
    { "<Leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
  },
  opts = {
    image = {
      enabled = true,
      -- Optional: configure as needed
      doc = {
        enabled = true, -- show images in markdown, html, etc.
        inline = true,  -- render images inline in buffers
        float = true,   -- show images in floating windows on hover
        max_width = 80,
        max_height = 40,
      },
    },
    picker = {
      enabled = true,
    },
    -- Explicitly disable everything else (optional but explicit)
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    words = { enabled = false },
    zen = { enabled = false },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
  end,
}
