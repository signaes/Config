local options = {
  backup = false,
  number = true,
  relativenumber = true,
  numberwidth = 4,
  autoread = true,  -- automatically update a file if it is changed externally
  cmdheight = 2,    -- more space in the neovim command line for displaying messages
  conceallevel = 0, -- so that `` is visible in markdown files
  autoindent = true,
  smartindent = true,
  wrap = false,
  fileencoding = "utf-8",
  hlsearch = true,   -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  smartcase = true,
  incsearch = true,
  expandtab = true,
  tabstop = 2,    -- insert 2 spaces for a tab
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  showmatch = true,
  ruler = true,
  mouse = "a",         -- allow the mouse to be used in neovim
  pumheight = 10,      -- pop up menu height
  splitbelow = true,   -- force all horizontal splits to go below current window
  splitright = true,   -- force all vertical splits to go to the right of current window
  showcmd = true,
  updatetime = 300,    -- faster completion (4000ms default)
  undofile = true,     -- enable persistent undo
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  cursorline = true,   -- highlight the current line
  signcolumn = "yes",
  termguicolors = true,
  sidescrolloff = 0, -- only scroll horizontally when reaching the end of the pane
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd([[set iskeyword+=-]])
