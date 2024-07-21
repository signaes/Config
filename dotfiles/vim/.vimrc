let mapleader      = ' '
let maplocalleader = ' '

set hidden
set cmdheight=2
set updatetime=300
set signcolumn=yes
set backspace=indent,eol,start
set autoindent
set smartindent
set encoding=utf-8
set hlsearch        " highlight search matches
set incsearch       " search while characters are entered
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set ai              " Auto indent
set si              " Smart indent
set showmatch       " show matching braces
set ruler
filetype indent on  " enable filetype specific indentation

" Enable syntax highlighting
syntax on
syntax enable

" Color scheme
set background=dark

" Keep the cursor on the same column
set nostartofline

" Splits
nnoremap <Leader><Bar> :vsplit<cr>
nnoremap <Leader>_ :split<cr>

" Splits navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Numbers
set number
set relativenumber

" Tabs
nnoremap <Leader>t :tabnew<cr>
nnoremap <Tab>   :tabnext<cr>
nnoremap <S-Tab> :tabprevious<cr>

" Write
nnoremap <Leader>w :w<cr>
nnoremap <C-w> <Esc>:w<Esc><cr>k
inoremap <C-w> <Esc>:w<Esc><cr>k

" Automatically update a file if it is changed externally
set autoread

" Toggle the highlighting for the current search
nnoremap <Leader>h :set hlsearch! hlsearch?<cr>

" Quit
nnoremap <Leader>q <Esc>:q<Esc><cr>k

" Move lines
nnoremap <Leader>k :m-2<cr>
nnoremap <Leader>j :m+<cr>

" Trim white spaces at the end of lines
autocmd BufWritePre * %s/\s\+$//e

" FZF
nnoremap <Leader>f :FZF<cr>

" Esc
inoremap <c-e> <Esc>l

" Mouse support
set mouse=a

" Show command
set showcmd

" Backup and swp
set backupdir=~/.vim/backup
set directory=~/.vim/swap

" Reads local project .vimrc file
set exrc
set secure  " disables shell execution and write operations

" Folding
set foldmethod=indent
set foldlevel=99

" Enable folding
nnoremap <leader> za

" line length
set textwidth=80
set colorcolumn=+1
