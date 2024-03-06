set nocompatible
let g:polyglot_disabled = ['markdown']

" -- Configurations for '~/.vimrc' --
set wrap
set mouse=a	

set ignorecase
set smartcase
set termguicolors
set background=dark
set termencoding=utf-8
set encoding=utf-8

set ruler
set showmode

set nobackup
set noswapfile

set scrolloff=5
filetype plugin indent on
syntax on
set list lcs=tab:\|\

" - Tabs -
"set expandtab
set tabstop=2 "Sets indent size of tabs"
set shiftwidth=2 "Sets auto-indent size"
set autoindent "Turns on auto-indenting"
set smartindent "Remembers previous indent when creating new lines"
set noexpandtab
"set copyindent

" - Use system clipborad -
set clipboard+=unnamedplus

" - Auto-comment -
set formatoptions=cro

" - Fix Splitting -
set splitbelow splitright

" - Status bar -
set laststatus=2
set confirm
set title

" - Show lines - 
set number
"set relativenumber

" - Hightlight text -
set hlsearch
set incsearch

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

" When in InsertMode the line will apper
:autocmd InsertEnter * set cursorline
:autocmd InsertLeave * set nocursorline

" Fix slow when presse <ESC>
set ttimeout
set ttimeoutlen=1
set ttyfast

" Adds fzf
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
