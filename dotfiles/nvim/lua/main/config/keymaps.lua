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
n("<C-w>", "<Esc>:w<Esc><cr>k")

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


-- Telescope
n("<Leader>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>")
n("<Leader>fg", "<CMD>Telescope live_grep<CR>")
n("<Leader>fb", "<CMD>Telescope buffers<CR>")
n("<Leader>fh", "<CMD>Telescope help_tags<CR>")
n("<Leader>ftg", "<CMD>Telescope git_files<CR>")
n("<Leader>fs", "<CMD>Telescope grep_string<CR>")
n("<Leader>fo", "<CMD>Telescope oldfiles<CR>")

-- Goto preview
n("<Leader>fpd", "<CMD>lua require('goto-preview').goto_preview_definition()<CR>")
n("<Leader>fpt", "<CMD>lua require('goto-preview').goto_preview_type_definition()<CR>")
n("<Leader>fpi", "<CMD>lua require('goto-preview').goto_preview_implementation()<CR>")
n("<Leader>fpi", "<CMD>lua require('goto-preview').goto_preview_implementation()<CR>")
n("<Leader>fps", "<CMD>lua require('goto-preview').goto_preview_declaration()<CR>")
n("<Leader>fpr", "<CMD>lua require('goto-preview').goto_preview_references()<CR>")
n("<Leader>fpx", "<CMD>lua require('goto-preview').close_all_win()<CR>")
n("<Esc>", "<CMD>lua require('goto-preview').close_all_win()<CR>")

-- Harpoon
n("<leader>ha", "<CMD>lua require('harpoon.mark').add_file()<CR>")
n("<leader>hm", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>")
n("<leader>hnn", "<CMD>lua require('harpoon.ui').nav_next()<CR>")
n("<leader>hnp", "<CMD>lua require('harpoon.ui').nav_prev()<CR>")
