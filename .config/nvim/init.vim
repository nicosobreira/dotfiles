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

" - Colorsheme -
" Use the same background color
set termguicolors
set background=dark

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" - Tabs -
set tabstop=2 "Sets indent size of tabs"
set shiftwidth=2 "Sets auto-indent size"
set autoindent "Turns on auto-indenting"
set smartindent "Remembers previous indent when creating new lines"
set noexpandtab

" - Use system clipborad -
set clipboard=unnamedplus

" - Auto-comment -
set formatoptions=cro

" - Fix Splitting -
set splitbelow splitright

" - Status bar -
set laststatus=2
set confirm
set title

" - Show lines on
set number relativenumber

" - Hightlight search text -
set hlsearch
"set incsearch

" - enable smart search sensitivity -
set ignorecase
"set smartcase

" - Menu, mais opções -
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

" Fix slow when presse <ESC>
set ttimeout
set ttimeoutlen=1
set ttyfast

" --- Keymap ---
" - Remap leader - 
nnoremap <leader>; ;
map ; :
let mapleader=" "

map q :q!<CR>
map <C-s> :w<CR>

nnoremap <leader>h :split<Space>
nnoremap <leader>v :vsplit<Space>

" - Split Navigation -
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" H and L for begginning/end of line
nmap H ^
nmap L $

" Navegate visual lines
nmap j gj
nmap k gk

" Remove search highlights
nmap <F9> :nohl<CR>

" - Run Commads -
command Cd :cd %:h  " :Cd go to current folder

" - White space characters -
set nolist
set listchars=eol:$,tab:.\ ,trail:.,extends:>,precedes:<,nbsp:_
highlight SpecialKey term=standout ctermfg=darkgray guifg=darkgray
" display white space characters with F3
nnoremap <F3> :set list! list?<CR>

" --- Plugins ---
" -- Plug --
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --CReate-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'preservim/nerdtree'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'tpope/vim-obsession'
Plug 'OmniSharp/omnisharp-vim'
Plug 'jlcrochet/vim-cs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tc50cal/vim-terminal'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" -- Config --
" - Catppuccin -
colo catppuccin_frappe

" - TagBar -
nmap <F8> :TagbarToggle<CR>

" - NERDTree Option -
nnoremap <leader>n :NERDTreeToggle<CR>
"nnoremap <C-n> :NERDTreeToggle<CR>

let NERDTreeShowHidden=1
let g:NERDTreeWinSize=20
" - Coc -
let g:coc_global_extensions = ['coc-clangd', 'coc-sh', 'coc-snippets', 'coc-python', 'coc-markdownlint']
inoremap <expr> <TAB> pumvisible() ? coc#_select_confirm() : "<Tab>"
