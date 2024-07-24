return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },

  config = function()
    local gitsigns = require('gitsigns')

    gitsigns.setup({
      on_attach = function(bufnr)
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", '<leader>gh', gitsigns.preview_hunk, {})
        map("n", '<leader>gb', gitsigns.toggle_current_line_blame, {})
      end
    })
  end
}
