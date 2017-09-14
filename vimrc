" You are now looking at Mathias Begert's vimrc
" Started from Bram Moolenaar's example vimrc

set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'Shougo/vimproc' "tsuquyomi needs this...
Plugin 'Quramy/tsuquyomi' "typescript
Plugin 'tpope/vim-surround'

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

" set the leaderkey to comma
let mapleader = ","

" move window with c-k and c-j
nnoremap <C-k> <C-Y><C-Y><C-Y>
nnoremap <C-j> <C-E><C-E><C-E>

" Shortcut to switch window
nnoremap ö <C-w>p
" Use space to run macro recorded at q
nnoremap <Space> @q
" Use kj for exiting INSERT mode
inoremap kj <Esc>

" add some mappings to simply add (or surround) xml tags
noremap mt diwi<<esc>pa><esc>a</<esc>pa><esc>F<
vnoremap mt di<xxx><esc>o</xxx><esc>P>/<\/xxx<cr>/xxx<cr>Ncw

" validate xml buffer
function! ValidateXmlBuffer()
    let res = system("xmllint --valid --noout -", join(getline(1, '$'), "\n"))
    if strlen(res) == 0
        echom "perfekts igsämäl"
    else
        echo "igsämäl het ä fähler:" res
    endif
endfunction
noremap <leader>x :call ValidateXmlBuffer()<cr>

" pretty print json
command! -range -nargs=0 -bar JsonTool <line1>,<line2>!python -m json.tool

" open .vimrc in a new tab
noremap <leader>v :tabe $MYVIMRC<cr>
" call the last command in the lower pane of tmux
noremap <leader>. :!tmux select-pane -D && tmux send-keys up enter && tmux select-pane -l<cr><cr>
" find all block comments
noremap <leader>c /\/\*\(.\\|\n\)\{-}\*\/<cr>
"
" move inside splits with leader instead of <c-w>
noremap <leader>h <c-w>h
noremap <leader>j <c-w>j
noremap <leader>k <c-w>k
noremap <leader>l <c-w>l

" jump c-] on german keyboard
nmap <leader>b <c-]>

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
  map <ScrollWheelUp> <C-Y>
  map <ScrollWheelDown> <C-E>
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

  " format xml-files with xmllint
  autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

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
map <C-n> :NERDTreeToggle<Cr>

" automatically exclude all .gitignore'd file for ctrl-p
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
