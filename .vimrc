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

" --- Config ---
filetype plugin indent on
syntax enable

colorscheme sorbet
set background=dark

set omnifunc=syntaxcomplete#Complete

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

set spell
set spelllang=en,pt_br
highlight SpellBad cterm=underline ctermbg=Black

" - Tabs -
set tabstop=4 "Sets indent size of tabs
set shiftwidth=4 "Sets auto-indent size
set autoindent "Turns on auto-indenting
set smartindent "Remembers previous indent when creating new lines

" Prettier
set list
set listchars=tab:\|\ ,trail:*
highlight SpecialKey ctermfg=darkgray guifg=gray70

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

" - Hightlight search text -
set hlsearch

" - Fix spliting -
set splitbelow
set splitright

" - Enable smart search sensitivity -
set ignorecase
set smartcase

" - Menu, mais opções -
set wildmenu
set wildmode=list:full

" - Cursor -
let &t_EI = "\e[2 q"
let &t_SI = "\e[6 q"

" --- Keymap ---
" - Remap space -
nnoremap <space>; ;
map ; :

map <C-s> <cmd>w<CR>

" - Terminal -
tmap <ESC> <C-\><C-n>
tmap <C-w>h <C-\><C-w>h
tmap <C-w>j <C-\><C-w>j
tmap <C-w>k <C-\><C-w>k
tmap <C-w>l <C-\><C-w>l

" - Split Navigation -
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Navegate visual lines
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

" hoeler
let g:colors = getcompletion('', 'color')
func! NextColors()
    let idx = index(g:colors, g:colors_name)
    return (idx + 1 >= len(g:colors) ? g:colors[0] : g:colors[idx + 1])
endfunc
func! PrevColors()
    let idx = index(g:colors, g:colors_name)
    return (idx - 1 < 0 ? g:colors[-1] : g:colors[idx - 1])
endfunc
nnoremap <C-n> :exe "colo " .. NextColors()<CR>
nnoremap <C-p> :exe "colo " .. PrevColors()<CR>

" Block arrow keys
"nnoremap <Left> <cmd>echo "No left for you!"<CR>
"vnoremap <Left> <cmd><C-u>echo "No left for you!"<CR>
"inoremap <Left> <C-o><cmd>echo "No left for you!"<CR>
"
"nnoremap <Right> <cmd>echo "No right for you!"<CR>
"vnoremap <Right> <cmd><C-u>echo "No right for you!"<CR>
"inoremap <Right> <C-o><cmd>echo "No right for you!"<CR>
"
"nnoremap <Up> <cmd>echo "No up for you!"<CR>
"vnoremap <Up> <cmd><C-u>echo "No up for you!"<CR>
"inoremap <Up> <C-o><cmd>echo "No up for you!"<CR>
"
"nnoremap <Down> <cmd>echo "No down for you!"<CR>
"vnoremap <Down> <cmd><C-u>echo "No down for you!"<CR>
"inoremap <Down> <C-o><cmd>echo "No down for you!"<CR>
