return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "oxlint" },
      typescript = { "oxlint" },
      javascriptreact = { "oxlint" },
      typescriptreact = { "oxlint" },
      bash = { "shellcheck" },
      sh = { "shellcheck" },
      zsh = { "shellcheck" },
      lua = { "luacheck" },
      go = { "golangcilint" },
      markdown = { "markdownlint-cli2" },
      css = { "stylelint" },
      scss = { "stylelint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end
}
