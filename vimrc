""" Auto Installation

" wget -O ~/.vim/plugged/vim-snippets/UltiSnips/terraform.snippets
" https://github.com/sebosp/vim-snippets-terraform/raw/master/terraform.snippets

if empty(glob("~/.vim/autoload/plug.vim"))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  auto VimEnter * PlugInstall
endif

if !isdirectory($HOME . "/.vim/undodir")
  call mkdir($HOME . "/.vim/undodir", "p")
endif

if empty($HOME . "/.vim/colors/codedark.vim")
  silent !curl -fLo ~/.vim/colors/codedark.vim --create-dirs
        \ https://raw.githubusercontent.com/tomasiser/vim-code-dark/master/colors/codedark.vim
endif

if empty($HOME . "/.vim/autoload/airline/codedark.vim")
  silent !curl -fLo ~/.vim/autoload/airline/codedark.vim --create-dirs
        \ https://raw.githubusercontent.com/tomasiser/vim-code-dark/master/autoload/airline/themes/codedark.vim
endif

""" Appearance

syntax on
set number relativenumber
set nowrap
colorscheme codedark
let g:airline_theme = 'codedark'

""" Behaviour modifiers

set undofile
set undodir=~/.vim/undodir
set clipboard=unnamed

autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

set ignorecase
set incsearch
set smartcase
set hlsearch!

" Pared with .tmux.conf config for navigation in tmux and vim
" {{{
function! TmuxMove(direction)
  let wnr = winnr()
  silent! execute 'wincmd ' . a:direction
  " If the winnr is still the same after we moved, it is the last pane
  if wnr == winnr()
    call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
  end
endfunction

nnoremap <silent> <c-h> :call TmuxMove('h')<cr>
nnoremap <silent> <c-j> :call TmuxMove('j')<cr>
nnoremap <silent> <c-k> :call TmuxMove('k')<cr>
nnoremap <silent> <c-l> :call TmuxMove('l')<cr>
" }}}

" complete settings
set wildmode=longest,list,full
set completeopt=longest,menuone

" auto highlight current word under cursor
" {{{
set updatetime=10 " Short updatetime so the CursorHold event fires fairly often

function! HighlightWordUnderCursor()
  if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]' 
    exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/' 
  else 
    match none 
  endif
endfunction

autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()
" }}}

" Quickly edit/reload this configuration file
nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC<CR>

" Auto reload vimrc file upon save
if has ('autocmd') " Remain compatible with earlier versions
  augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

""" Plugins

call plug#begin('~/.vim/plugged')
filetype plugin indent on

Plug 'scrooloose/nerdtree'                                           " File tree browser
Plug 'jistr/vim-nerdtree-tabs'                                       " NerdTree independent of tabs
Plug 'Xuyuanp/nerdtree-git-plugin'                                   " NerdTree git plugin
Plug 'tpope/vim-commentary'                                          " Comment out blocks
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'
Plug 'tmhedberg/matchit'
Plug 'hashivim/vim-terraform'
Plug 'andrewstuart/vim-kubernetes'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jiangmiao/auto-pairs'

call plug#end()

" NERDTree
map <C-n> :NERDTreeTabsToggle<CR>
map <C-f> :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeChDirMode=2
let g:NERDTreeDirArrowExpandable = '├'
let g:NERDTreeDirArrowCollapsible = '└'
let g:NERDTreeMapActivateNode = '<tab>'
set mouse=a

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetsDir="/Users/hsulindroos/.vim/plugged/vim-snippets/snippets"

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_python_binary_path = '/usr/bin/python'

" golang config
let g:go_fmt_command = "goimports"

