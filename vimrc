" kyeb vimrc

" Colorscheme 
packadd! onedark.vim
let g:onedark_termcolors=24
let g:onedark_terminal_italics=1
colorscheme onedark
if (has("termguicolors"))
    set termguicolors
endif

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
set ttimeoutlen=0                   " fix the delay when pressing escape


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
" TODO: fix commenting
" nnoremap <CR>/ gcc

" Nerdtree bindings
" Open nerdtree on `vim`
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open nerdtree on `vim dir`
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close vim when only nerdtree remains
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Airline options
let g:airline#extensions#tabline#enabled = 1

" Custom syntax and commenting
au BufRead,BufNewFile */sway/config set filetype=i3config
au FileType python setlocal commentstring=#\ %s
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc

" Custom file type options
au BufRead,BufNewFile *.md setlocal textwidth=80    " Markdown auto-wraps at 80
au FileType c setlocal shiftwidth=2 softtabstop=2   " C files get 2 spaces for tab
