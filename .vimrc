"        ,---.  ,--,           ,.----,. 
"       /__./|,--.'|        ,-+-,.' _ | 
"  ,---.;  ; ||  |,      ,-+-. ;   , || 
" /___/ \  | |`--'_     ,--.'|'   |  || 
" \   ;  \ ' |,' ,'|   |   |  ,', |  |, 
"  \   \  \: |'  | |   |   | /  | |--'  
"   ;   \  ' .|  | :   |   : |  | ,     
"    \   \   ''  : |__ |   : |  |/      
"     \   `  ;|  | '.'||   | |`-'       
"      :   \ |;  :    ;|   ;/           
"       '---" |  ,   / '---'            "
"              ---`-'                   

" --- Config ---
" -- Configurations for '~/.vimrc' --
filetype plugin indent on
syntax enable

set nocompatible
set wrap
set linebreak
set mouse=a

set termencoding=utf-8
set encoding=utf-8

set showmode

set nobackup
set noswapfile

set scrolloff=5

" - Colorsheme -
" Use the same background color
set termguicolors
set background=dark

" - Tabs -
set tabstop=8 "Sets indent size of tabs"
set shiftwidth=8 "Sets auto-indent size"
set autoindent "Turns on auto-indenting"
set smartindent "Remembers previous indent when creating new lines"

" - Use system clipborad -
set clipboard=unnamedplus

" - Auto-comment -
set formatoptions=cro

" - Status bar -
set laststatus=2
set confirm
set title

" - Show lines on
set number relativenumber
set nu rnu

" - Hightlight search text -
set hlsearch

" - enable smart search sensitivity -
set ignorecase
set smartcase

" - Menu, mais opções -
set wildmenu
set wildmode=list:full

" - Cursor -
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Fix slow when presse <ESC>
set ttimeout
set ttimeoutlen=1
set ttyfast

" --- Keymap ---
" - Remap space - 
nnoremap <space>; ;
map ; :
let mapspace=" "

map <C-s> <cmd>w<CR>
map <space>s <cmd>so $MYVIMRC<CR>

" - Terminal -
tmap <ESC> <C-\><C-n> 

" - Split Navigation -
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Navegate visual lines
nmap j gj
nmap k gk

" Remove search highlights
nmap <ESC> <cmd>nohl<CR>

" - Run Commads -
command Cd <cmd>cd %:h<CR>  "Cd go to current folder

" --- Plugins ---
" -- Plug --
"let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
"if empty(glob(data_dir . '/autoload/plug.vim'))
  "silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --CReate-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif
"
"call plug#begin()
"
"Plug 'preservim/nerdtree'
"Plug 'catppuccin/vim', { 'as': 'catppuccin' }
"Plug 'tpope/vim-obsession'
"Plug 'OmniSharp/omnisharp-vim'
"Plug 'jlcrochet/vim-cs'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
"call plug#end()
"
" -- Config --
" - Catppuccin -
"colo catppuccin_frappe
"
" - NERDTree Option -
"let NERDTreeShowHidden=1