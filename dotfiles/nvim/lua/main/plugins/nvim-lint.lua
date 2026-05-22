return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    local function linter_available(name)
      return vim.fn.executable(name) == 1
    end

    local linters = {
      javascript = { "oxlint" },
      typescript = { "oxlint" },
      javascriptreact = { "oxlint" },
      typescriptreact = { "oxlint" },
      python = { "ruff" },
      bash = { "shellcheck" },
      sh = { "shellcheck" },
      zsh = { "shellcheck" },
      lua = { "luacheck" },
      go = { "golangcilint" },
      markdown = { "markdownlint-cli2" },
      css = { "stylelint" },
      scss = { "stylelint" },
    }

    -- Only register linters that are actually installed
    for ft, linter_list in pairs(linters) do
      local available = {}

      for _, linter in ipairs(linter_list) do
        if linter_available(linter) then
          table.insert(available, linter)
        end
      end

      if #available > 0 then
        lint.linters_by_ft[ft] = available
      end
    end

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
