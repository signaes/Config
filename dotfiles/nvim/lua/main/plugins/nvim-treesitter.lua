return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  dependencies = { "HiPhish/rainbow-delimiters.nvim" },
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    local parsers = {
      "bash", "diff", "html", "markdown", "markdown_inline", "vim",
      "lua", "python", "ruby", "typescript", "javascript", "json",
      "scss", "rust", "go", "gomod", "gowork", "gosum", "zig",
    }

    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "bash", "diff", "html", "markdown", "vim", "lua", "python",
        "ruby", "typescript", "javascript", "javascriptreact",
        "typescriptreact", "json", "scss", "rust", "go", "zig",
      },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    local indent_disable = { python = true, css = true, ruby = true }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function()
        if not indent_disable[vim.bo.filetype] then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end
}
