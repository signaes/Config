# LSP Configuration Documentation

This document provides comprehensive documentation for the LSP (Language Server Protocol) configuration in `lua/main/plugins/lsp.lua`.

## Overview

The LSP configuration sets up language servers to provide intelligent code completion, error checking, refactoring, and other IDE-like features in Neovim. It uses the modern Neovim 0.11+ `vim.lsp.config()` API for server configuration.

## File Structure

### Helper Functions

#### `is_deno_project(root_dir)`
- **Purpose**: Detects if the current directory is a Deno project
- **Mechanism**: Traverses up the directory tree looking for Deno-specific files:
  - `deno.json`
  - `deno.jsonc` 
  - `deno.lock`
- **Returns**: `true` if any Deno files are found, `false` otherwise
- **Usage**: Helps determine whether to use `denols` or `ts_ls` for TypeScript/JavaScript files

#### `is_node_project(root_dir)`
- **Purpose**: Detects if the current directory is a Node.js project
- **Mechanism**: Traverses up the directory tree looking for Node.js package files:
  - `package.json`
  - `package-lock.json`
  - `yarn.lock`
  - `pnpm-lock.yaml`
- **Returns**: `true` if any Node.js files are found, `false` otherwise
- **Usage**: Helps determine whether to use `ts_ls` or `denols` for TypeScript/JavaScript files

#### `prevent_conflicting_servers(client, bufnr)`
- **Purpose**: Prevents TypeScript language servers from conflicting with each other
- **Mechanism**: 
  - When `denols` starts, it stops any running `ts_ls`
  - When `ts_ls` starts, it stops any running `denols`
- **Why Needed**: TypeScript projects can be either Node.js or Deno projects, but not both simultaneously
- **Notification**: Informs the user when a server is stopped in favor of another

### Autocommand Setup

#### `lsp_attach` Group
- **Creation**: Creates an autocommand group named "kickstart-lsp-attach"
- **Clear Option**: `{ clear = true }` prevents duplicate autocommands on config reload
- **Purpose**: Manages all LSP-related autocommands in a single group

#### LSP Attach Callback
- **Trigger**: Runs whenever an LSP server attaches to a buffer
- **Actions Performed**:
  1. **Conflict Prevention**: Calls `prevent_conflicting_servers()`
  2. **Keybinding Setup**: Creates buffer-local LSP keybindings
  3. **Document Highlighting**: Sets up reference highlighting
  4. **Inlay Hints**: Configures inlay hint toggling if supported

### LSP Keybindings

All keybindings are buffer-local (only work in files with attached LSP servers):

#### Navigation Keybindings
- `gd` - Go to definition (using Telescope)
- `gr` - Go to references (using Telescope)
- `<leader>i` - Go to implementation (using Telescope)
- `<leader>dt` - Go to type definition (using Telescope)
- `gD` - Go to declaration (not definition)

#### Symbol Search
- `<leader>ds` - Document symbols (current file)
- `<leader>ws` - Workspace symbols (entire project)

#### Actions
- `<leader>rn` - Rename symbol under cursor
- `<leader>ca` - Code actions (quick fixes, refactoring)
- `<leader>bh` - Hover documentation
- `<leader>th` - Toggle inlay hints (if supported)

### Document Highlighting

- **Trigger**: `CursorHold` and `CursorHoldI` events
- **Action**: Highlights all references to the symbol under the cursor
- **Cleanup**: Automatically clears highlights when cursor moves (`CursorMoved`, `CursorMovedI`)
- **Detach Handling**: Cleans up autocommands when LSP server detaches

### Custom Commands

#### `:LspDebug`
- **Purpose**: Provides comprehensive debugging information for LSP configuration
- **Information Displayed**:
  - Current file and directory
  - Project type detection (Deno/Node.js)
  - Buffer-specific LSP clients
  - All active LSP clients
- **Usage**: Debug why a language server isn't attaching or working correctly

#### `:LspStatus`
- **Purpose**: Shows status of LSP clients attached to current buffer
- **Information Displayed**:
  - Server name and root directory
  - Server capabilities
  - Diagnostic support
  - Completion support
- **Usage**: Quick check of what's currently working in your buffer

### Language Servers Configuration

#### Server List (`servers` variable)
The following language servers are automatically installed and configured:

| Server | Language | Purpose |
|--------|----------|---------|
| `lua_ls` | Lua | Lua language server with Neovim-specific support |
| `gopls` | Go | Official Go language server |
| `pyright` | Python | Microsoft's Python language server |
| `ruby_lsp` | Ruby | Ruby language server |
| `ts_ls` | TypeScript/JavaScript | TypeScript language server (Node.js projects) |
| `denols` | TypeScript/JavaScript | Deno language server (Deno projects) |
| `html` | HTML | HTML language server |
| `rust_analyzer` | Rust | Rust language server |
| `bashls` | Bash/Shell | Bash language server |
| `cssls` | CSS | CSS language server |
| `emmet_language_server` | HTML/CSS | Emmet abbreviations and snippets |
| `tailwindcss` | CSS | Tailwind CSS class completion |
| `zls` | Zig | Zig language server |
| `astro` | Astro | Astro framework language server |

#### Individual Server Configurations

##### Astro Server
- **Filetypes**: `astro`
- **Purpose**: Astro framework support

##### Zig Language Server (`zls`)
- **Command**: `zls`
- **Filetypes**: `zig`, `zir`
- **Root Detection**: Looks for `build.zig` or `.git` files
- **Single File Support**: Enabled for standalone Zig files

##### Lua Language Server (`lua_ls`)
- **Capabilities**: Enhanced with nvim-cmp completion
- **Special**: Configured with lazydev for Neovim API support

##### Python Language Server (`pyright`)
- **Settings**:
  - `autoSearchPaths`: Automatically finds Python packages
  - `diagnosticMode`: "openFilesOnly" (better performance)
  - `useLibraryCodeForTypes`: Better type inference from installed packages

##### Emmet Language Server
- **Filetypes**: CSS, ERB, HTML, JavaScript, JSX, Less, Sass, SCSS, Pug, TSX
- **Init Options**: Default Emmet configuration
- **Purpose**: HTML/CSS abbreviation expansion

##### Tailwind CSS Server
- **Extended Filetypes**: Includes Phoenix/Elixir templates
- **Settings**: Configured for various templating languages
- **Purpose**: Tailwind CSS class completion and IntelliSense

##### Harper Linter (`harper_ls`)
- **Purpose**: Grammar and spell checking
- **Linters Enabled**:
  - Spell checking
  - Sentence capitalization
  - Unclosed quotes
  - Long sentences
  - Repeated words
  - Spacing issues
- **Severity**: "hint" (non-intrusive)
- **Dialect**: American English

### Plugin Dependencies

#### Core Dependencies
- **`neovim/nvim-lspconfig`**: Main LSP configuration plugin
- **`williamboman/mason.nvim`**: Package manager for LSP servers
- **`williamboman/mason-lspconfig.nvim`**: Mason integration for LSP servers
- **`WhoIsSethDaniel/mason-tool-installer.nvim`**: Automatic tool installation

#### Development Support
- **`folke/lazydev.nvim`**: Lua development with type hints
  - Only loads on Lua files
  - Provides Neovim API completions
- **`folke/neodev.nvim`**: Additional Neovim API type hints

#### User Experience
- **`j-hui/fidget.nvim`**: LSP progress notifications
  - Shows loading status for language servers
  - Displays progress for long-running operations

### Initialization Process

1. **Plugin Loading**: Lazy.nvim loads the plugin and its dependencies
2. **Capabilities Setup**: Merges default LSP capabilities with nvim-cmp completion
3. **Server Configuration**: Configures each language server with `vim.lsp.config()`
4. **Mason Setup**: Initializes Mason package manager
5. **Server Installation**: Automatically installs all servers in the `servers` list
6. **Autocommand Setup**: Creates LSP attach autocommands
7. **User Commands**: Registers `:LspDebug` and `:LspStatus` commands

### Troubleshooting

#### Common Issues

1. **Language Server Not Starting**
   - Run `:LspDebug` to check project detection
   - Verify server is installed with `:Mason`
   - Check file associations with `:LspInfo`

2. **TypeScript Server Conflicts**
   - The configuration automatically handles this
   - Deno projects use `denols`, Node.js projects use `ts_ls`
   - Check project type with `:LspDebug`

3. **Missing Features**
   - Verify the server supports the feature with `:LspStatus`
   - Check capabilities list in status output
   - Some features require specific server settings

#### Debug Commands

- `:LspDebug` - Comprehensive debugging information
- `:LspStatus` - Current buffer LSP status
- `:LspInfo` - Neovim's built-in LSP information
- `:Mason` - Mason package manager UI

#### Log Levels
The configuration uses various log levels:
- `DEBUG`: Project detection information
- `INFO`: Server start/stop notifications
- `ERROR`: Error messages from language servers

### Performance Considerations

1. **Lazy Loading**: Most plugins only load when needed
2. **Selective Servers**: Only relevant servers start based on file type
3. **Diagnostic Mode**: Python set to "openFilesOnly" for better performance
4. **Single File Support**: Enabled where appropriate for standalone files

### Customization

#### Adding New Language Servers
1. Add server name to `servers` list
2. Add `vim.lsp.config()` call with server settings
3. Restart Neovim or reload configuration

#### Modifying Keybindings
Keybindings are defined in the `lsp_attach` callback. Modify the `map()` calls to change keys or add new ones.

#### Server Settings
Each server can be customized in its `vim.lsp.config()` call. Refer to the respective server's documentation for available options.

## Best Practices

1. **Use `:LspDebug`** for troubleshooting issues
2. **Check file associations** if a server isn't starting
3. **Verify Mason installation** for missing servers
4. **Restart Neovim** after major configuration changes
5. **Use lazy loading** for new plugins to maintain startup performance

This configuration provides a solid foundation for modern Neovim LSP usage while maintaining flexibility for customization.