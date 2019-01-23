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

if empty(glob("~/.vim/colors/codedark.vim"))
  silent !curl -fLo ~/.vim/colors/codedark.vim --create-dirs
        \ https://raw.githubusercontent.com/tomasiser/vim-code-dark/master/colors/codedark.vim
endif

if empty(glob("~/.vim/autoload/airline/codedark.vim"))
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
set backspace=indent,eol,start

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

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

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
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhinz/vim-startify'
" full screen vim
Plug 'junegunn/goyo.vim'
" vim style botton line
Plug 'itchyny/lightline.vim'
" light way to display git branch
Plug 'itchyny/vim-gitbranch'

call plug#end()

" lightline
set laststatus=2
set noshowmode

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

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
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
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

" rust config
let g:rustfmt_autosave = 1

" ctrlp fuzzy finder
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
