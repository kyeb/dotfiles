execute pathogen#infect()
syntax on
filetype plugin indent on

" The default vimrc file.

" Bail out if something that ran earlier, e.g. a system wide vimrc, does not
" want Vim to use these default values.
if exists('skip_defaults_vim')
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=0	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

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

set relativenumber number

vnoremap // y/<C-R>"<CR>

" Text wrapping options
au BufRead,BufNewFile *.txt setlocal textwidth=0
au BufRead,BufNewFile *.md setlocal textwidth=80


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
        \   '-xelatex',
        \ ],
        \}

"let g:vimtex_view_method = 'zathura'

" save/load folds upon closing/opening
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

