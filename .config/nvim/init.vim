"          ,--.                                    
"        ,--.'|                             ____   
"    ,--,:  : |            ,--,           ,'  , `. 
" ,`--.'`|  ' :          ,--.'|        ,-+-,.' _ | 
" |   :  :  | |     .---.|  |,      ,-+-. ;   , || 
" :   |   \ | :   /.  ./|`--'_     ,--.'|'   |  || 
" |   : '  '; | .-' . ' |,' ,'|   |   |  ,', |  |, 
" '   ' ;.    ;/___/ \: |'  | |   |   | /  | |--'  
" |   | | \   |.   \  ' .|  | :   |   : |  | ,     
" '   : |  ; .' \   \   ''  : |__ |   : |  |/      
" |   | '`--'    \   \   |  | '.'||   | |`-'       
" '   : |         \   \ |;  :    ;|   ;/           
" ;   |.'          '---" |  ,   / '---'            
" '---'                   ---`-'                   
" --- Config ---
" -- Configurations for '~/.vimrc' --
colo slate
set background=dark

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
filetype plugin indent on
syntax enable
set list lcs=tab:\|\

" - Color scheme -
" Use the same background color

if (has("termguicolors"))
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set notermguicolors
endif

" Spell checks will be colored
hi SpellBad cterm=underline
hi SpellLocal cterm=underline
hi SpellRare cterm=underline
hi SpellCap cterm=underline

" - Tabs -
set tabstop=2 "Sets indent size of tabs"
set shiftwidth=2 "Sets auto-indent size"
set autoindent "Turns on auto-indenting"
set smartindent "Remembers previous indent when creating new lines"
set noexpandtab

" - Use system clipboard -
set clipboard=unnamedplus

" - Auto-comment -
set formatoptions=cro

" - Fix Splitting -
set splitbelow splitright

" - Status bar -
set laststatus=2
set confirm
set title
set nolist

" - Show lines on
set number relativenumber

" - Highlight search text -
set hlsearch
"set incsearch

" - enable smart search sensitivity -
set ignorecase
"set smartcase

" - Menu -
set wildmenu
set wildmode=list:full

" - Cursor -
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" Fix slow when press <ESC>
set ttimeout
set ttimeoutlen=1
set ttyfast

" --- Keymap ---
" - Remap leader - 
nnoremap <leader>; ;
map ; :
let mapleader=" "

"map q :q!<CR>
map <C-s> :w<CR>

nnoremap <leader>h :split<Space>
nnoremap <leader>v :vsplit<Space>

" - Split Navigation -
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" H and L for beginning/end of line
nmap H ^
nmap L $

" Navigate visual lines
nmap j gj
nmap k gk

" Remove search highlights
nmap <F9> :nohl<CR>

" Toggle spell check
map <F5> :setlocal spell!<CR>

" - Run Commands -
command Cd :cd %:h  " :Cd go to current folder

" Exit terminal with ESC
tnoremap <Esc> <C-\><C-n>

" --- Plugins ---
" -- Plug --
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --CReate-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'preservim/nerdtree'
Plug 'tpope/vim-obsession'
Plug 'OmniSharp/omnisharp-vim'
Plug 'jlcrochet/vim-cs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tc50cal/vim-terminal'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" -- Config --
" - NERDTree Option -
nnoremap <leader>n :NERDTreeToggle<CR>
"nnoremap <C-n> :NERDTreeToggle<CR>

let NERDTreeShowHidden=1
let g:NERDTreeWinSize=20
" - Coc -
let g:coc_global_extensions = ['coc-clangd', 'coc-sh', 'coc-snippets', 'coc-python']
inoremap <expr> <TAB> pumvisible() ? coc#_select_confirm() : "<Tab>"
