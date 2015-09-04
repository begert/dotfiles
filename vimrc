" You are now looking at Mathias Begert's vimrc
" Started from Bram Moolenaar's example vimrc
"
" Added a lot of funny stuff inspired or copied from a lot of friendly people
" all around the internet, thanks for that!

set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on

set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4

set history=50
set list listchars=tab:»·,trail:·,nbsp:·
set ruler
set number
set relativenumber
set incsearch

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" disable annoying backup files
set nobackup
set nowritebackup

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Some shortcut for :
nnoremap ö :
" Use space to run macro recorded at q
nnoremap <Space> @q
" Use kj for exiting INSERT mode
inoremap kj <Esc>

" set the leaderkey to comma
let mapleader = ","

" open .vimrc in a new tab
noremap <leader>v :tabe $MYVIMRC<cr>
" call the last command in the lower pane of tmux
noremap <leader>. :!tmux select-pane -D && tmux send-keys up enter && tmux select-pane -l<cr><cr>
" find all block comments
noremap <leader>c /\/\*\(.\\|\n\)\{-}\*\/<cr>

" automatically reload .vimrc after save
if has("autocmd")
    autocmd! BufWritePost vimrc source $MYVIMRC
    autocmd! BufWritePost .vimrc source $MYVIMRC
    autocmd! BufWritePost nvimrc source $MYVIMRC
    autocmd! BufWritePost .nvimrc source $MYVIMRC
endif

" In many terminal emulators the mouse works just fine, thus enable it.
" But use it only in normal mode so pasting in puTTY (for example) is still
" possible
if has('mouse')
  set mouse=n
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  colorscheme desert
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

    " always set autoindenting on
    set autoindent

endif

" ----- NOW SOME PLUGIN SPECIFIC THINGS -----

" Toggle NERDTree with crtl-n
" map <C-n> :NERDTreeToggle<Cr>

" Switch <cr> <ctrl-t> behaviour for ctrl-p
" open a new tab is now default
" let g:ctrlp_prompt_mappings = {
"     \ 'AcceptSelection("e")': ['<c-t>'],
"     \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
"     \ }

" let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
