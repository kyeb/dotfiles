execute pathogen#infect()
syntax on
filetype plugin indent on

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  au FileType tex set tw=79
  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


" Custom options
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.
set undodir=~/.vim/tmp,.

set number relativenumber

vnoremap // y/<C-R>"<CR>

" Allow mouse usage
set mouse=a

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab


" Extension options
let g:vimtex_view_method = 'zathura'
let g:airline_powerline_fonts = 1
" currently not working: onedark airline theme
let g:airline_theme='onedark'

" use system clipboard if gvim is installed
set clipboard=unnamedplus

" make backspace normal
set backspace=2

"onedark.vim overrides 
if (has("autocmd") && !has("gui_running"))
  augroup colors
    autocmd!
    " Set a custom background color in the terminal
    let s:background = { "gui": "#282C34", "cterm": "235", "cterm16": "0" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "bg": s:background }) "No `fg` setting
    " Custom tab coloring
    autocmd ColorScheme * call onedark#extend_highlight("TabLine", {"fg": {"gui": "#282C34"}})
    autocmd ColorScheme * call onedark#extend_highlight("TabLine", {"bg": {"gui": "#abb2bf"}})
    autocmd ColorScheme * call onedark#extend_highlight("TabLineFill", {"bg": {"gui": "#abb2bf"}})
  augroup END
endif

set termguicolors
colorscheme onedark

" vimtex options
" Disable overfull/underfull \hbox and all package warnings
let g:vimtex_quickfix_latexlog = {
     \ 'overfull' : 0,
     \ 'underfull' : 0,
     \ 'packages' : {
     \   'default' : 0,
     \ },
     \}

" Set up a build directory to stop annoying files in directory
" Set callback to 0 to disable some random warning that came up
let g:vimtex_compiler_latexmk = {
        \ 'build_dir' : 'build/',
        \ 'executable' : 'latexmk',
        \ 'callback' : 0,
        \ 'options' : [
        \   '-synctex=0',
        \   '-interaction=nonstopmode',
        \ ],
        \}

" save/load folds upon closing/opening
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
