-- Prevents conflicting TypeScript language servers from running simultaneously
-- Deno projects should use denols, while Node.js projects should use ts_ls
-- When one server starts, it stops the other to avoid conflicts
local function prevent_conflicting_servers(client)
  if client and client.name == "denols" then
    -- Stop ts_ls if running
    for _, active_client in ipairs(vim.lsp.get_clients()) do
      if active_client.name == "ts_ls" then
        active_client:stop(true)
        vim.notify("Stopped ts_ls in favor of denols", vim.log.levels.INFO)
      end
    end
  elseif client and client.name == "ts_ls" then -- Fixed: = → ==
    -- Stop denols if it's running
    for _, active_client in ipairs(vim.lsp.get_clients()) do
      if active_client.name == "denols" then
        active_client:stop(true)
        vim.notify("Stopped denols in favor of ts_ls", vim.log.levels.INFO)
      end
    end
  end
end

-- Autocommand configuration that runs when an LSP server attaches to a buffer
-- Sets up keybindings, highlights, and other LSP functionality
local lsp_attach = {
  -- Creates an autocommand group to manage LSP-related events
  -- "lsp-attach" is the unique identifier for this group
  -- { clear = true } ensures no duplicate autocommands if config is reloaded
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),

  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- Prevent conflicting TypeScript servers
    prevent_conflicting_servers(client)

    -- Helper function to create buffer-local keymaps with LSP prefix
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    local telescope_builtin = require("telescope.builtin")

    -- LSP Navigation keybindings using Telescope
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

    -- LSP Actions keybindings
    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    -- Show hover information for the symbol under cursor
    map("<leader>bh", vim.lsp.buf.hover, "[B]uffer [H]over")

    -- Document highlighting setup
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

      -- Highlight references when cursor holds
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      -- Clear highlights when cursor moves
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- Inlay hints setup
    -- The following autocommand is used to enable inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
          { bufnr = event.buf }
        )
      end, "[T]oggle Inlay [H]ints")
    end

    -- Diagnostic float (available whenever LSP is attached
    map("<leader>dd", vim.diagnostic.open_float, "Open Diagnostic Float")
  end,
}

-- Custom user commands for debugging LSP
-- Debug LSP configuration for current buffer
vim.api.nvim_create_user_command("LspDebug", function()
  local buf = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(buf)
  local dir = vim.fs.dirname(filename)

  print("=== LSP Debug Info ===")
  print("File: " .. filename)
  print("Directory: " .. dir)
  print("Buffer clients:")
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
    print("  - " .. client.name .. " (root: " .. (client.root_dir or "unknown") .. ")")
  end
  print("All active clients:")
  for _, client in ipairs(vim.lsp.get_clients()) do
    print("  - " .. client.name .. " (root: " .. (client.root_dir or "unknown") .. ")")
  end
  print("====================")
end, { desc = "Debug LSP configuration for current buffer" })

-- Quick LSP status for current buffer
vim.api.nvim_create_user_command("LspStatus", function()
  local buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = buf })

  if #clients == 0 then
    print("No LSP clients attached to current buffer")
    return
  end

  print("=== LSP Status ===")
  for _, client in ipairs(clients) do
    print("Server: " .. client.name)
    print("  Root: " .. (client.root_dir or "unknown"))
    print("  Capabilities: " .. table.concat(vim.tbl_keys(client.server_capabilities or {}), ", "))
    print("  Supports completion: " .. tostring(client:supports_method(vim.lsp.protocol.Methods.textDocument_completion)))
    print("---")
  end
end, { desc = "Show LSP status for current buffer" })

-- Set up LSP capabilities with completion support
-- Start with default capabilities and enhance with nvim-cmp completion capabilities
local base_capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities())

-- List of language servers to automatically install via Mason
-- These servers will be installed and configured automatically
local servers = {
  ["lua_ls"]                = "lua-language-server",
  ["gopls"]                 = "gopls",
  ["pyright"]               = "pyright",
  ["ruby_lsp"]              = "ruby-lsp",
  ["ts_ls"]                 = "typescript-language-server",
  ["denols"]                = "deno",
  ["html"]                  = "html-lsp",
  ["rust_analyzer"]         = "rust-analyzer",
  ["bashls"]                = "bash-language-server",
  ["cssls"]                 = "css-lsp",
  ["emmet_language_server"] = "emmet-language-server",
  ["tailwindcss"]           = "tailwindcss-language-server",
  ["zls"]                   = "zls",
  ["astro"]                 = "astro-language-server",
  ["harper_ls"]             = "harper-ls",
  ["ruff"]                  = "ruff",
}

-- Main LSP plugin configuration
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Lua development support with type hints
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim%.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    -- Automatic tool installation via Mason
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Mason package manager (configured with defaults)
    { "williamboman/mason.nvim", config = true },
  },

  -- Main configuration function for LSP servers
  config = function()
    -- Astro framework language server configuration
    vim.lsp.config('astro', {
      filetypes = { "astro" },
      before_init = function(_, config)
        local cwd = vim.fn.getcwd()
        local tsdk = cwd .. "/node_modules/typescript/lib"
        -- If no local TypeScript, fall back to global npm install
        if vim.fn.isdirectory(tsdk) == 0 then
          local ok, global_root = pcall(function()
            return vim.fn.trim(vim.fn.system("npm root -g"))
          end)
          if ok and global_root and global_root ~= "" then
            tsdk = global_root .. "/typescript/lib"
          end
        end
        if vim.fn.isdirectory(tsdk) == 1 then
          config.init_options = config.init_options or {}
          config.init_options.typescript = { tsdk = tsdk }
        end
      end,
    })

    -- Zig language server configuration with custom root detection
    vim.lsp.config('zls', {
      cmd = { "zls" },
      filetypes = { "zig", "zir" },
      root_markers = { "build.zig", ".git" },
      capabilities = vim.deepcopy(base_capabilities),
    })

    -- Lua language server configuration
    vim.lsp.config('lua_ls', { capabilities = vim.deepcopy(base_capabilities) })

    -- Go language server configuration
    vim.lsp.config('gopls', { capabilities = vim.deepcopy(base_capabilities) })

    -- ruff (Python linter) configuration
    vim.lsp.config('ruff', {})

    -- Python language server configuration with custom settings
    vim.lsp.config('pyright', {
      capabilities = vim.deepcopy(base_capabilities),
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

    -- Ruby language server configuration
    vim.lsp.config('ruby_lsp', { capabilities = vim.deepcopy(base_capabilities) })

    -- HTML language server configuration
    vim.lsp.config('html', { capabilities = vim.deepcopy(base_capabilities) })

    -- Rust language server configuration
    vim.lsp.config('rust_analyzer', {
      capabilities = vim.deepcopy(base_capabilities),
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
          },
        },
      },
    })

    -- Bash/Shell language server configuration
    vim.lsp.config('bashls', { capabilities = vim.deepcopy(base_capabilities) })

    -- Emmet language server configuration for HTML/CSS abbreviations
    vim.lsp.config('emmet_language_server', {
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
      init_options = {
        includeLanguages = {},
        excludeLanguages = {},
        extensionsPath = {},
        preferences = {},
        showAbbreviationSuggestions = true,
        showExpandedAbbreviation = "always",
        showSuggestionsAsSnippets = false,
        syntaxProfiles = {},
        variables = {},
      },
    })

    -- Tailwind CSS language server configuration with extended filetypes
    vim.lsp.config('tailwindcss', {
      filetypes = {
        "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango",
        "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars",
        "hbs", "html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache",
        "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss",
        "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript",
        "typescriptreact", "vue", "svelte", "heex",
      },
      settings = {
        tailwindCSS = {
          includeLanguages = {
            elixir = "html-eex",
            eelixir = "html-eex",
            heex = "html-eex",
          },
        },
      },
    })


    -- CSS language server configuration
    vim.lsp.config('cssls', {
      capabilities = vim.deepcopy(base_capabilities),
    })

    -- Harper language server for grammar and spell checking
    vim.lsp.config('harper_ls', {
      capabilities = vim.deepcopy(base_capabilities),
      settings = {
        ["harper-ls"] = {
          userDictPath = "",
          workspaceDictPath = "",
          fileDictPath = "",
          linters = {
            SpellCheck = true,
            SpelledNumbers = false,
            AnA = true,
            SentenceCapitalization = true,
            UnclosedQuotes = true,
            WrongQuotes = false,
            LongSentences = true,
            RepeatedWords = true,
            Spaces = true,
            Matcher = true,
            CorrectNumberSuffix = true
          },
          codeActions = {
            ForceStable = false
          },
          markdown = {
            IgnoreLinkTitle = false
          },
          diagnosticSeverity = "hint",
          isolateEnglish = false,
          dialect = "American",
          maxFileLength = 120000,
          ignoredLintsPath = "",
          excludePatterns = {}
        }
      }
    })

    for server, _ in pairs(servers) do
      vim.lsp.enable(server)
    end

    -- Set up the LSP attach autocommand
    vim.api.nvim_create_autocmd("LspAttach", lsp_attach)

    -- Clean up autocommands when LSP detaches
    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),

      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
      end,
    })

    -- Initialize Mason and install language servers
    require("mason").setup()
    require("mason-tool-installer").setup({
      ensure_installed = vim.tbl_values(servers),
    })
  end,
}
