if has('termguicolors')
    set termguicolors
endif
set tabstop=4
set autoindent
set shiftwidth=4
set expandtab
set nocompatible
syntax enable
set shortmess+=I
set number
set laststatus=2
set backspace=indent,eol,start
set hidden
set ignorecase
set smartcase

set noerrorbells visualbell t_vb=
set mouse+=a
set incsearch

set wildmode=longest:full,full
set wildignorecase
set virtualedit=block
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:·,nbsp:·
set nocursorcolumn
set splitbelow
set splitright
set signcolumn=yes
set colorcolumn=+1

call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" ui
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/vim-gitbranch'
Plug 'ap/vim-buftabline'
Plug 'thaerkh/vim-indentguides'

" Themes
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'
Plug 'sainnhe/gruvbox-material'
Plug 'ghifarit53/tokyonight-vim'

call plug#end()

lua require("lsp")
lua require("treesitter")

let g:buftabline_indicators=1
let g:buftabline_separators=1

let g:dracula_colorterm = 1
let g:dracula_underline = 1
let g:dracula_bold = 1
let g:gruvbox_bold = 1
set background=dark
let g:gruvbox_material_background = 'medium'
let g:dracula_italic = 0
colorscheme dracula

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', 'node_modules']


" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.
nmap <F1> <Nop>
map <C-n> :NERDTreeToggle %<CR>

" lsp-status
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return ''
endfunction

set statusline=\ \ %{gitbranch#name()}\ ❯\ 
set statusline+=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline+=\ %{LspStatus()}`

" completion-nvim
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
set shortmess+=c
let g:completion_enable_snippet = 'UltiSnips'

set updatetime=500

filetype plugin indent on

" custom mappings
let mapleader = " "
nnoremap <Leader><space> :noh<cr>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
" buffer navigation
nnoremap <F2> :bn<CR>
nnoremap <F1> :bp<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <C-space> completion#trigger_completion()

nnoremap <C-s> :w<CR> 
inoremap <C-s> <Esc>:w<CR>l
vnoremap <C-s> <Esc>:w<CR>

"fzf and git
nnoremap <C-f> :Files<CR> 
nnoremap <C-p> :Rg<CR> 

nnoremap n nzz
nnoremap N Nzz

let g:fzf_layout = { 'down': '~40%' }
let g:indentguides_spacechar = '▏'
let g:indentguides_tabchar = '▏'

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 100})
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab

autocmd CursorHold * lua vim.lsp.buf.hover()
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

