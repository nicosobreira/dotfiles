" -- Keymaps for '~/.vimrc' --
" - Remap leader - 
nnoremap <leader>; ;
map ; :

let mapleader=" "

map q :q!<CR>
map <C-s> :w<CR>

map <M-z> <C-R>

nnoremap <leader>h :split<Space>
nnoremap <leader>v :vsplit<Space>

" - NERDTree -
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" - Fzf -
nnoremap <Leader>p :Files<CR>

" - Split Navigation -
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" - Run Commads -
" :Py run python file
"command Py :w<CR>:exec  '! clear; python3.12' shellescape(@%, 1)<CR>
command Cd :cd %:h  " :Cd go to current folder
command Term :term ++curwin " :Term opens a terminal

" - No indent on paste -
set pastetoggle=<F2>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" - White space characters -
set nolist
set listchars=eol:$,tab:.\ ,trail:.,extends:>,precedes:<,nbsp:_
highlight SpecialKey term=standout ctermfg=darkgray guifg=darkgray
" display white space characters with F3
nnoremap <F3> :set list! list?<CR>
