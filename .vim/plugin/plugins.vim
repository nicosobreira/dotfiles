" -- Plugins for '~/.vimrc' --
" - NERDTree Option -
let NERDTreeShowHidden=1

" - Indent guides -
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=blue ctermbg=4

" -- Plug --
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-obsession'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nanotee/zoxide.vim'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

colorscheme dracula
