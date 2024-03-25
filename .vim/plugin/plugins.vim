" -- Plugins for '~/.vimrc' --
" - NERDTree Option -
let NERDTreeShowHidden=1

" - Polyglot -
let g:polyglot_disabled = ['markdown']

" -- Plug --
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --CReate-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'preservim/nerdtree'
"Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-obsession'
Plug 'nanotee/zoxide.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'OmniSharp/omnisharp-vim'
Plug 'jlcrochet/vim-cs'

call plug#end()
