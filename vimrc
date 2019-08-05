" kyeb vimrc

" TODO: find a color scheme
" colorscheme 

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
set lazyredraw                      " apparently default vim redraws too often in macros?
set backspace=indent,eol,start      " reasonable backspace settings

" Search options
set incsearch                       " search as characters are entered
set hlsearch                        " highlight matches


set mouse+=a                        " enable mouse movement, scrolling, selection 

" Shortcuts
let mapleader = ","                 " leader is ','
" hide search highlighting
nnoremap <leader><space> :nohlsearch<CR>

nnoremap j gj
nnoremap k gk

