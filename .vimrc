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
" == CONFIG ==
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

syntax on
set termguicolors

colorscheme koehler

set background=dark
filetype plugin indent on

set nocompatible

set omnifunc=syntaxcomplete#Complete

set wrap
set linebreak
set mouse=a
set autoread
set noruler

set undofile
set undolevels=10000
set noundofile

set encoding=utf-8

set showmode

set nobackup
set noswapfile

set scrolloff=10

" - Spell Fix -
set spelllang=en,pt_br
highlight SpellBad cterm=underline ctermbg=Black
autocmd FileType markdown,txt setlocal spell

" - Indentation -
set breakindent
set tabstop=4	"Sets indent size of tabs
set shiftwidth=4	"Sets auto indent size
set autoindent	"Turns on auto indenting
set smartindent	"Remembers previous indent when creating new lines

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
set cursorline
highlight CursorLineNR cterm=bold

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
set wildmode=longest:full,full
set wildoptions=fuzzy

" - Netrw -
" Hide './' and '../'
let g:netrw_list_hide = '^\./$,^\.\./$'
let g:netrw_hide = 1
let g:netrw_banner = 0
let g:netrw_altfile = 1  " Better behavior when toggling
let g:netrw_alto = 1     " Makes splits open to the right (instead of left)

" - Cursor -
let &t_EI = "\e[2 q"
let &t_SI = "\e[6 q"

" - Folds options -
set foldlevel=99
autocmd FileType c,cpp,java,php setlocal foldmethod=syntax
autocmd FileType python setlocal foldmethod=indent
autocmd FileType vim setlocal foldmethod=marker

" == MAPPINGS ==
let mapleader = " "

nmap <C-s> <cmd>w<CR>

" - Remap space -
nnoremap ; :
nnoremap : ;

" Visual mode
vnoremap ; :
vnoremap : ;

" Operator-pending mode
onoremap ; :
onoremap : ;

" Move to the end/beggining of the line
nnoremap H _
nnoremap L $

" - Terminal -
tmap <ESC> <C-\><C-n>
tmap <C-h> <C-\><C-n><cmd>wincmd h<CR>
tmap <C-j> <C-\><C-n><cmd>wincmd j<CR>
tmap <C-k> <C-\><C-n><cmd>wincmd k<CR>
tmap <C-l> <C-\><C-n><cmd>wincmd l<CR>

" - Netrw -
au FileType netrw nmap <buffer> h -
au FileType netrw nmap <buffer> l <CR>
au FileType netrw nmap <buffer> % a
nmap <leader>e <cmd>Explore<CR>

" - Split Navigation -
nmap <C-h> <C-w>h h<CR>
nmap <C-j> <C-w>j j<CR>
nmap <C-k> <C-w>k k<CR>
nmap <C-l> <C-w>l l<CR>

" - Navigate visual lines -
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" - Tabs -
nmap <Tab> gt
nmap <S-Tab> gT
nmap <leader>n <cmd>$tabnew<CR>
nmap <leader>N <cmd>0tabnew<CR>

" Resize window using <ctrl> arrow keys
nnoremap <silent> <C-Up> :resize +2<CR>
nnoremap <silent> <C-Down> :resize -2<CR>
nnoremap <silent> <C-Left> :vertical resize +2<CR>
nnoremap <silent> <C-Right> :vertical resize -2<CR>

" Move Lines
nnoremap <silent> <A-j> :<C-u>execute 'move .+' . v:count1<CR>==
nnoremap <silent> <A-k> :<C-u>execute 'move .-' . (v:count1 + 1)<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :<C-u>execute "'<,'>move '>+" . v:count1<CR>gv=gv
vnoremap <silent> <A-k> :<C-u>execute "'<,'>move '<-" . (v:count1 + 1)<CR>gv=gv

" - Extra -
nmap <ESC> <cmd>nohl<CR>
nmap Q <cmd>echo "Vi mode disable"<CR>
nmap <leader>r <cmd>source $HOME/.vimrc <bar> echo "Source vimrc"<CR>
nmap <leader>s <cmd>set spell! <bar> echo "Spell check" (&spell ? "ON" : "OFF") <CR>
nmap <leader>= gg=G<C-o>
xnoremap < <gv
xnoremap > >gv

" == PLUGINS ==
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install vim plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run Plug Install if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
			\| PlugInstall --sync | source $MYVIMRC
			\| endif

call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'bfrg/vim-c-cpp-modern'

call plug#end()

let g:cpp_type_name_highlight = 0
