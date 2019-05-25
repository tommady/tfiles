" auto highlight current word under cursor
set updatetime=10 " Short updatetime so the CursorHold event fires fairly often
function! HighlightWordUnderCursor()
  if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
    exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
  else
    match none
  endif
endfunction
autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs 
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if !isdirectory($HOME . "/.local/share/nvim/site/undodir")
  call mkdir($HOME . "/.local/share/nvim/site/undodir", "p")
endif

" if empty(glob("~/.local/share/nvim/site/colors/codedark.vim"))
"   silent !curl -fLo ~/.local/share/nvim/site/colors/codedark.vim --create-dirs
"         \ https://raw.githubusercontent.com/tomasiser/vim-code-dark/master/colors/codedark.vim
" endif

" if empty(glob("~/.local/share/nvim/site/autoload/airline/codedark.vim"))
"   silent !curl -fLo ~/.local/share/nvim/site/autoload/airline/codedark.vim --create-dirs
"         \ https://raw.githubusercontent.com/tomasiser/vim-code-dark/master/autoload/airline/themes/codedark.vim
" endif

if empty(glob("~/.local/share/nvim/site/colors/one.vim"))
  silent !curl -fLo ~/.local/share/nvim/site/colors/one.vim --create-dirs
  	\ https://raw.githubusercontent.com/rakr/vim-one/master/colors/one.vim
endif

if empty(glob("~/.local/share/nvim/site/autoload/airline/one.vim"))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/airline/one.vim --create-dirs
  	\ https://raw.githubusercontent.com/rakr/vim-one/master/autoload/airline/themes/one.vim
endif

" Pared with .tmux.conf config for navigation in tmux and vim
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

" theme settings
" colorscheme codedark
" let g:airline_theme = 'codedark'
colorscheme one
let g:airline_theme='one'
set background=dark
let g:one_allow_italics = 1


syntax on
set number relativenumber
set nowrap
set undofile
set undodir=~/.local/share/nvim/site/undodir
set clipboard=unnamed
set backspace=indent,eol,start
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
set ignorecase
set incsearch
set smartcase
set hlsearch!
set wildmode=longest,list,full
set completeopt=longest,menuone
set exrc
set secure
set autoread
set termguicolors

" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa

" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !

" When switching panes in tmux, an escape sequence is printed. Redrawing gets
" rid of it. See https://gist.github.com/mislav/5189704#comment-951447
au FocusLost * :redraw!

" each language using different tab settings
" ts = 'number of spaces that <Tab> in file uses' 
" sts = 'number of spaces that <Tab> uses while editing' 
" sw = 'number of spaces to use for (auto)indent step'
autocmd FileType go setlocal ts=8 sts=8 sw=8
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType tf setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType py setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab

call plug#begin("~/.local/share/nvim/site/plugged")
filetype plugin indent on

Plug 'tpope/vim-sensible'
Plug 'neomake/neomake'
Plug 'scrooloose/nerdtree'                                           " File tree browser
Plug 'jistr/vim-nerdtree-tabs'                                       " NerdTree independent of tabs
Plug 'Xuyuanp/nerdtree-git-plugin'                                   " NerdTree git plugin
Plug 'hashivim/vim-terraform'
Plug 'andrewstuart/vim-kubernetes'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jiangmiao/auto-pairs'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" vim style botton line
Plug 'itchyny/lightline.vim'
" light way to display git branch
Plug 'itchyny/vim-gitbranch'
Plug 'airblade/vim-gitgutter'
" python autopep8
Plug 'tell-k/vim-autopep8' 
" markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" markdown preview
Plug 'JamshedVesuna/vim-markdown-preview'
" comment out in visual mode
Plug 'tpope/vim-commentary'
" dark power completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" golang auto completion with deoplete
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.local/share/nvim/site/plugged/gocode/nvim/symlink.sh' }
" Adds file type glyphs/icons to popular
Plug 'ryanoasis/vim-devicons'
" tags
Plug 'ludovicchabant/vim-gutentags'
" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plug 'junegunn/fzf.vim'

call plug#end()

" ultisnips config
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

" deoplete config
let g:deoplete#enable_at_startup = 1
set completeopt+=noselect
let g:deoplete#disable_auto_complete = 0 " set to 1 if you want to disable autocomplete
let g:deoplete#ignore_sources = {}

" deoplete go config
let g:deoplete#sources#go#gocode_binary = '~/go/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" neomake config
" Run NeoMake on read and write operations
autocmd! BufReadPost,BufWritePost * Neomake

" Disable inherited syntastic
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }

let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1

" gitgutter
set updatetime=100
let g:gitgutter_max_signs = 500
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0

if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

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
      \   'gitbranch': 'gitbranch#name',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'gitbranch_path'), ':h:h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" NERDTree
map <C-n> :NERDTreeTabsToggle<CR>
map <C-f> :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeChDirMode=2
let g:NERDTreeDirArrowExpandable = '├'
let g:NERDTreeDirArrowCollapsible = '└'
let g:NERDTreeMapActivateNode = '<tab>'
set mouse=a

" vim go config
let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_gocode_propose_source = 0
let g:go_template_autocreate = 0
let g:go_def_mode = 'godef'

" rust config
let g:rustfmt_autosave = 1
au FileType rust let b:AutoPairs = AutoPairsDefine({'\w\zs<': '>'})

" python config
let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1

" auto pair config
let g:AutoPairsWildClosedPair = ''
let g:AutoPairsFlyMode = 0
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutBackInsert = '<c-b>'

" markdown config
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1

" markdown preview config
let vim_markdown_preview_toggle=1
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_temp_file=1
let vim_markdown_preview_github=1

" json format
au FileType json autocmd BufWritePost *.json execute '%!python -m json.tool' | w

" gutentags config
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" fzf config
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_buffers_jump = 1
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
nnoremap <silent> <c-p> :FzfFiles<CR>
nnoremap <silent> <c-g> :FzfBTags<CR>
nnoremap <silent> <c-G> :FzfTags<CR>
nnoremap <silent> <c-r> :FzfRg<CR> 
