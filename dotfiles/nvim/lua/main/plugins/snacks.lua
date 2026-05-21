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
    notifier = { enabled = false },
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
    -- Prevent treesitter + snacks.image crashes on picker markdown previews
    local markdown = require("snacks.picker.util.markdown")
    local orig_render = markdown.render

    markdown.render = function(buf, render_opts)
      -- Preview scratch buffers are left with filetype="snacks_picker_preview" before render()
      if vim.bo[buf].filetype == "snacks_picker_preview" then
        -- Suppress FileType to avoid any ftplugin re-triggering treesitter
        local ei = vim.o.eventignore
        vim.o.eventignore = "all"
        vim.bo[buf].filetype = "markdown.snacks_picker_preview"
        vim.o.eventignore = ei
        -- Use regex syntax instead of treesitter for the preview
        vim.bo[buf].syntax = "markdown"
        return
      end
      return orig_render(buf, render_opts)
    end
  end
}
