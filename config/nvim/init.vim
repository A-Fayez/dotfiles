if has('termguicolors')
    set termguicolors
endif
set tabstop=4
set autoindent
set shiftwidth=4
set expandtab
set nocompatible
syntax enable
set background=""
set shortmess+=I
set number
set relativenumber
set laststatus=2
set backspace=indent,eol,start
set hidden
set ignorecase
set smartcase

set noerrorbells visualbell t_vb=
set mouse+=a
set incsearch

call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'

" ui
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline', {'branch': 'master'}
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
" Themes
Plug 'chriskempson/base16-vim'
Plug 'sainnhe/sonokai'
Plug 'ayu-theme/ayu-vim'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'

call plug#end()

let g:dracula_colorterm = 1
let g:dracula_italic = 1
let g:dracula_underline = 1
let g:dracula_bold = 1
colorscheme dracula

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
set splitbelow
" navigate auto-completion window with tab
" Theme and airline configs
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline_powerline_fonts = 1
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=1

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.
map <C-n> :NERDTreeToggle %<CR>

" lsp-status
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return ''
endfunction

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline+=\ %{LspStatus()}`

" completion-nvim
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_enable_snippet = 'UltiSnips'
"autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc

"diagnostics-nvim
let g:diagnostic_insert_delay = 0
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_trimmed_virtual_text = '40'
set signcolumn=yes
set updatetime=300
"autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()
" Goto previous/next diagnostic warning/error

lua require("lsp")
"lua require("treesitter")

filetype plugin indent on

" custom mappings
let mapleader = " "
nnoremap <Leader><space> :noh<cr>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
" buffer navigation
nnoremap <F3> :bn<CR>
nnoremap <F2> :bp<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <C-space> completion#trigger_completion()

nnoremap <C-s> :w<CR> 
inoremap <C-s> <Esc>:w<CR>l
vnoremap <C-s> <Esc>:w<CR>

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
"fzf and git
nnoremap <C-f> :Files<CR> 
nnoremap <Leader>gs :GFiles?<CR> 
nnoremap <Leader>gb :Git branch<CR> 
nnoremap <Leader>lg :Commits<CR> 
nnoremap <leader>gf :Git fetch --all<CR>
nnoremap <leader>grum :Git rebase upstream/master<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>

nnoremap n nzz
nnoremap N Nzz

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" Enable type inlay hints
autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:·,nbsp:·,space:·
"set colorcolumn=+1

