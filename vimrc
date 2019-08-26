" kyeb vimrc

" Colorscheme 
set background=dark
colorscheme solarized

" Cursor
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[0 q"

syntax enable                       " enables syntax processing (whatever that means)
filetype indent on

" Tab settings
set tabstop=4                       " number of visual spaces per <TAB>
set expandtab                       " tabs are spaces
set softtabstop=4                   " number of spaces that <TAB> or <BS> add/remove
set shiftwidth=4                    " number of spaces that <<, >>, or other auto indents use

" set showmatch                       " unclear, highlights matching [{()}]?
set number                          " show line numbers
set wildmenu                        " nice visual autocomplete for commands
"set lazyredraw                      " apparently default vim redraws too often in macros?
set backspace=indent,eol,start      " reasonable backspace settings

" Search options
set incsearch                       " search as characters are entered
set hlsearch                        " highlight matches

set mouse+=a                        " enable mouse movement, scrolling, selection 

" Fix a couple default file annoyances and undo options
let g:netrw_dirhistmax=0            " disable some weird annoying .netrwhist file
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo//
set viminfofile=~/.vim/.viminfo     " move .viminfo out of $HOME

set undofile                        " enable persistent undo


" Shortcuts
let mapleader = ","                 " leader is ','
" hide search highlighting
nnoremap <leader><space> :nohlsearch<CR>
" up and down behave visually
nnoremap j gj
nnoremap k gk
" gundo.vim shortcut
nnoremap <leader>h :GundoToggle<CR>
" vim-commentary shortcut to match other editors
" TODO: fix this
" nnoremap <CR>/ gcc

" Custom syntax and commenting
au BufRead,BufNewFile */sway/config set filetype=i3config
au FileType python setlocal commentstring=#\ %s

