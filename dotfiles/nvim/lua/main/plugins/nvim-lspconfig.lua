local python_extrapaths = os.getenv("NEOVIM_LSP_CONFIG_PYTHON_EXTRAPATHS") or ""

local servers = { 
  lua = { name = "lua_ls", settings = {} },
  json = { name = "jsonls", settings = {} },
  typescript = { name = "tsserver", settings = {}},
  rust = { name = "rust_analyzer", settings = {} },
  terraform = { name = "terraformls", settings = {} },
  go = { name = "gopls", settings = {} },
  ruby = { name = "ruby-lsp", settings = {} },
  python = {
    name = "pyright",
    settings = {
      pyright = { autoImportCompletion = true },
      python = {
        analysis = {
          autoSearchPaths = true,
          extraPaths = python_extrapaths,
        },
      },
    },
  }
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "j-hui/fidget.nvim",
    "folke/neodev.nvim",
  },

  config = function()
    lspconfig = require("lspconfig")

    for _, config in ipairs(servers) do
      lspconfig[config.name].setup(config.settings)
    end
  end
}
