local defaultOptions = { noremap = true, silent = true }

local function merge(t1, t2)
  local result = {}

  for k, v in pairs(t1) do result[k] = v end
  for k, v in pairs(t2) do result[k] = v end

  return result
end

-- Modes
-- --   normal_mode = "n",
-- --   insert_mode = "i",
-- --   visual_mode = "v",
-- --   visual_block_mode = "x",
-- --   term_mode = "t",
-- --   command_mode = "c",

local function map(mode, binding, command, options)
  vim.keymap.set(mode, binding, command, merge(options or {}, defaultOptions))
end
local function n(binding, command, options)
  map("n", binding, command, options)
end
local function i(binding, command, options)
  map("i", binding, command, options)
end
local function v(binding, command, options)
  map("v", binding, command, options)
end
local function x(binding, command, options)
  map("x", binding, command, options)
end

map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal Mode --

-- Splits
n("<Leader><Bar>", ":vsplit<CR>")
n("<Leader>_", ":split<CR>")

-- Navigation
n("<C-J>", "<C-W><C-J>")
n("<C-K>", "<C-W><C-K>")
n("<C-L>", "<C-W><C-L>")
n("<C-H>", "<C-W><C-H>")

-- Tabs
n("<Leader>t", ":tabnew<CR>")
n("<Tab>", ":tabnext<CR>")
n("<S-Tab>", ":tabprevious<CR>")

-- Toggle the highlighting for the current search
n("<Leader>sh", ":set hlsearch! hlsearch?<CR>")

-- Quit
n("<Leader>q", "<Esc>:q<Esc><CR>")

-- Move lines
n("<Leader>k", ":m-2<CR>")
n("<Leader>j", ":m+<CR>")

-- Resize with arrows
n("<Leader><Up>", ":resize +2<CR>")
n("<Leader><Down>", ":resize -2<CR>")
n("<Leader><Left>", ":vertical resize +2<CR>")
n("<Leader><Right>", ":vertical resize -2<CR>")

-- Navigate buffers
n("<S-l>", ":bnext<CR>")
n("<S-h>", ":bprevious<CR>")

-- Write
n("<C-w>", "<Esc>:w<Esc><CR>k")

-- Nvimtree
n("<Leader>\\", ":NvimTreeToggle<CR>")
n("<Leader>/", ":NvimTreeFindFile<CR>")

-- Insert Mode --

-- Write
i("<C-w>", "<Esc>:w<Esc><CR>k")

-- Visual Mode --

-- Stay in indent mode
v("<", "<gv")
v(">", ">gv")

-- Move text up and down
v("<Leader>k", ":m .-2<CR>==")
v("<Leader>j", ":m .+1<CR>==")
v("p", '"_dP')

-- Diagnostics
n("<Leader>dd", ":lua vim.diagnostic.open_float()<CR>")

-- Telescope
n("<Leader>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>")
n("<Leader>fg", "<CMD>Telescope live_grep<CR>")
n("<Leader>fb", "<CMD>Telescope buffers<CR>")
n("<Leader>fh", "<CMD>Telescope help_tags<CR>")
n("<Leader>ftg", "<CMD>Telescope git_files<CR>")
n("<Leader>fs", "<CMD>Telescope grep_string<CR>")
n("<Leader>fo", "<CMD>Telescope oldfiles<CR>")

-- Replace across many occurrences
n("<C-n>", "*``cgn")
x("<C-n>", "y/\\V<C-r>\"<CR>``cgn")
