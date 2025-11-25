local lsp_attach = {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),

  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    local telescope_builtin = require("telescope.builtin")

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map("gd", telescope_builtin.lsp_definitions, "[G]oto [D]efinition")

    -- Find references for the word under your cursor.
    map("gr", telescope_builtin.lsp_references, "[G]oto [R]eferences")

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map("<leader>i", telescope_builtin.lsp_implementations, "[G]oto [I]mplementation")

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map("<leader>dt", telescope_builtin.lsp_type_definitions, "Type [D]efinition")

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map("<leader>ds", telescope_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    map("<leader>bh", vim.lsp.buf.hover, "[B]uffer [H]over")

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    -- The following autocommand is used to enable inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "[T]oggle Inlay [H]ints")
    end
  end,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

local servers = {
  "lua_ls",
  "gopls",
  "pyright",
  "ruby_lsp",
  "ts_ls",
  "denols",
  "biome",
  "html",
  "rust_analyzer",
  "bashls",
  "cssls",
  "emmet-language-server",
  "tailwindcss",
  "zls",
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    "j-hui/fidget.nvim",
    "folke/neodev.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    { "williamboman/mason.nvim", config = true },
  },

  opts = function()
    return {
      inlay_hints = {
        enabled = true,
      },
      codelens = {
        enabled = true,
      },
    }
  end,


  config = function()
    function setup(name, config)
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end

    setup("zls", {
      cmd = { "zls" },
      filetypes = { "zig", "zir" },
      root_dir = require("lspconfig").util.root_pattern("build.zig", ".git") or vim.loop.cwd,
      single_file_support = true,
      capabilities = capabilities,
    })
    setup("lua_ls", { capabilities = capabilities })
    setup("gopls", { capabilities = capabilities })
    setup("ruff", {})
    setup("pyright", {
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
          },
        },
      },
    })
    setup("ruby_lsp", { capabilities = capabilities })
    setup("ts_ls", {
      single_file_support = false,
      capabilities = capabilities,
    })
    setup("biome", {})
    setup("denols", {
      init_options = {
        lint = true,
        unstable = true,
      },
      on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, 'LspDenolsCache', function()
          client:exec_cmd({
            title = 'DenolsCache',
            command = 'deno.cache',
            arguments = { {}, vim.uri_from_bufnr(bufnr) },
          }, { bufnr = bufnr }, function(err, _, ctx)
            if err then
              local uri = ctx.params.arguments[2]
              vim.notify('cache command failed for' .. vim.uri_to_fname(uri), vim.log.levels.ERROR)
            end
          end)
        end, {
          desc = 'Cache a module and all of its dependencies.',
        })

        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatting", {}),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, async = true })
            end,
          })
        end
      end,
      cmd = { 'deno', 'lsp' },
      cmd_env = { NO_COLOR = true },
      filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
      root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
      root_markers = { 'deno.json', 'deno.jsonc', '.git' },
      capabilities = capabilities,
      settings = {
        deno = {
          enable = true,
          suggest = {
            imports = {
              hosts = {
                ["https://deno.land"] = true,
              },
            },
          },
        },
      },
    })
    setup("html", { capabilities = capabilities })
    setup("rust_analyzer", { capabilities = capabilities })
    setup("bashls", { capabilities = capabilities })
    setup("emmet_language_server", {
      filetypes = {
        "css",
        "eruby",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "pug",
        "typescriptreact",
      },
      -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
      -- **Note:** only the options listed in the table are supported.
      init_options = {
        ---@type table<string, string>
        includeLanguages = {},
        --- @type string[]
        excludeLanguages = {},
        --- @type string[]
        extensionsPath = {},
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
        preferences = {},
        --- @type boolean Defaults to `true`
        showAbbreviationSuggestions = true,
        --- @type "always" | "never" Defaults to `"always"`
        showExpandedAbbreviation = "always",
        --- @type boolean Defaults to `false`
        showSuggestionsAsSnippets = false,
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
        syntaxProfiles = {},
        --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
        variables = {},
      },
    })

    setup("tailwindcss", {
      tailwindcss = function(_, opts)
        local tw = require("lspconfig.server_configurations.tailwindcss")
        opts.filetypes = opts.filetypes or {}

        -- Add default filetypes
        vim.list_extend(opts.filetypes, tw.default_config.filetypes)

        -- Remove excluded filetypes
        --- @param ft string
        opts.filetypes = vim.tbl_filter(function(ft)
          return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
        end, opts.filetypes)

        -- Additional settings for Phoenix projects
        opts.settings = {
          tailwindCSS = {
            includeLanguages = {
              elixir = "html-eex",
              eelixir = "html-eex",
              heex = "html-eex",
            },
          },
        }

        -- Add additional filetypes
        vim.list_extend(opts.filetypes, opts.filetypes_include or {})
      end,
    })

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    setup("cssls", {
      capabilities = capabilities,
    })

    setup("harper_ls", {
      capabilities = capabilities,
    })

    vim.api.nvim_create_autocmd("LspAttach", lsp_attach)

    require("mason").setup()
    require("mason-tool-installer").setup({
      ensure_installed = servers,
    })
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls" },
      automatic_enable = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)

          if type(server) == "table" then
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            setup(server_name, server)
          end
        end,
      },
    })
  end,
}
