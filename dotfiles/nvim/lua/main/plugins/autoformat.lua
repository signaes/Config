return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>l",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "n",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "oxfmt", "prettier", stop_after_first = true },
      typescript = { "oxfmt", "prettier", stop_after_first = true },
      javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
      typescriptreact = { "oxfmt", "prettier", stop_after_first = true },
      json = { "prettier" },
      go = { "gofmt", "goimports" },
      rust = { "rustfmt" },
      zig = { "zigfmt" },
      ruby = { "rufo", "standardrb", "rubocop" },
      astro = { "prettier" },
    },
  },
}
