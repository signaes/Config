local options = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Modes
-- --   normal_mode = "n",
-- --   insert_mode = "i",
-- --   visual_mode = "v",
-- --   visual_block_mode = "x",
-- --   term_mode = "t",
-- --   command_mode = "c",

local function map(mode, b, c)
  keymap(mode, b, c, options)
end
local function n(b, c)
  map("n", b, c)
end
local function i(b, c)
  map("i", b, c)
end
local function v(b, c)
  map("v", b, c)
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
n("<Leader>h", ":set hlsearch! hlsearch?<CR>")

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
n("<C-w>", "<Esc>:w<Esc><cr>k")

-- Telescope
n("<Leader>f", "<CMD>lua require('telescope.builtin').find_files()<CR>")
n("<Leader>g", "<CMD>Telescope live_grep<CR>")

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
n("<Leader>d", ":lua vim.diagnostic.open_float()<CR>")

-- Ollama Gen
n("<Leader>]", ":Gen<CR>")
v("<Leader>]", ":Gen<CR>")
