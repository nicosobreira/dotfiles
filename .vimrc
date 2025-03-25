"        ,---.  ,--,           ,.----,. "
"       /__./|,--.'|        ,-+-,.' _ | "
"  ,---.;  ; ||  |,      ,-+-. ;   , || "
" /___/ \  | |`--'_     ,--.'|'   |  || "
" \   ;  \ ' |,' ,'|   |   |  ,', |  |, "
"  \   \  \: |'  | |   |   | /  | |--'  "
"   ;   \  ' .|  | :   |   : |  | ,     "
"    \   \   ''  : |__ |   : |  |/      "
"     \   `  ;|  | '.'||   | |`-'       "
"      :   \ |;  :    ;|   ;/           "
"       '---" |  ,   / '---'            "
"              ---`-'                   "

" -- Config --
filetype plugin indent on
syntax enable

if has('nvim')
	colorscheme sorbet
else
	colorscheme koehler
endif

set background=dark
set termguicolors

set omnifunc=syntaxcomplete#Complete

set nocompatible
set wrap
set linebreak
set mouse=a
set autoread

set termencoding=utf-8
set encoding=utf-8

set showmode

set nobackup
set noswapfile

set scrolloff=5

set spelllang=en,pt_br
highlight SpellBad cterm=underline ctermbg=Black

" - Tabs -
set tabstop=4	"Sets indent size of tabs
set shiftwidth=4	"Sets auto indent size
set autoindent	"Turns on auto indenting
set smartindent	"Remembers previous indent when creating new lines

" Prettier tabs and trailing spaces
set list
set listchars=tab:\|\ ,trail:*
highlight SpecialKey ctermfg=darkgray guifg=gray70

" - Use system clipboard -
set clipboard=unnamedplus

" - Auto comment -
set formatoptions=cro

" - Status bar -
set laststatus=2
set confirm
set title

" - Show lines on
set number relativenumber

" - Highlight search text -
set hlsearch

" - Fix splitting -
set splitbelow
set splitright

" - Enable smart search sensitivity -
set ignorecase
set smartcase

" - Menu, mais opções -
set wildmenu
set wildmode=list:full
set wildoptions=fuzzy

" - Cursor -
let &t_EI = "\e[2 q"
let &t_SI = "\e[6 q"

" -- Key map --
" - Remap space -
noremap <space>; ;
noremap ; :

nnoremap <C-s> <cmd>w<CR>

" - Terminal -
tmap <ESC> <C-\><C-n>
tmap <C-h> <C-\><C-n><cmd>wincmd h<CR>
tmap <C-j> <C-\><C-n><cmd>wincmd j<CR>
tmap <C-k> <C-\><C-n><cmd>wincmd k<CR>
tmap <C-l> <C-\><C-n><cmd>wincmd l<CR>

" - Netrw -
au FileType netrw nmap <buffer> h -
au FileType netrw nmap <buffer> l <CR>

" - Split Navigation -
nmap <C-h> <cmd>wincmd h<CR>
nmap <C-j> <cmd>wincmd j<CR>
nmap <C-k> <cmd>wincmd k<CR>
nmap <C-l> <cmd>wincmd l<CR>

" Navigate visual lines
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" Tabs
nmap <Tab> gt
nmap <S-Tab> gT
nmap <space>n <cmd>$tabnew<CR>
nmap <space>N <cmd>0tabnew<CR>

" Remove search highlights
nmap <ESC> <cmd>nohl<CR>

nmap Q <cmd>echo "Vi mode disable"<CR>

nmap <space>r <cmd>so $HOME/.vimrc <bar> echo "Source vimrc"<CR>

" -- Plugins --
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
