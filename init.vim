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

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
" if (empty($TMUX))
if (has("nvim"))
"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
" endif

scriptencoding utf-8
syntax enable
set number
set fileencodings=utf-8
set encoding=utf-8
set nocompatible
set autoindent
set nobackup
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
set exrc
set secure
set autoread
set rtp+=~/.fzf
set shortmess+=c

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
autocmd FileType proto setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType markdown setlocal ts=4 sts=4 sw=4
autocmd FileType sh setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType make setlocal ts=2 sts=2 sw=2 expandtab
" set justfile syntax
autocmd BufNewFile,BufRead Justfile setf make

call plug#begin("~/.local/share/nvim/site/plugged")
filetype plugin indent on

Plug 'tpope/vim-sensible'
Plug 'hashivim/vim-terraform'
Plug 'andrewstuart/vim-kubernetes'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'jiangmiao/auto-pairs'
" rust lang
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
" markdown
Plug 'plasticboy/vim-markdown'
" vim-one theme
Plug 'rakr/vim-one'
" multi cursor ctrl d
Plug 'terryma/vim-multiple-cursors'
" toml syntax
Plug 'cespare/vim-toml'
" git in nvim https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt
Plug 'tpope/vim-fugitive'
" nvim 5.0 only goes below
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

" theme settings
colorscheme one
let g:airline_theme='one'
set background=dark
let g:one_allow_italics = 1

" vim-multiple-cursors
" doing this for more easy to checkback
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-P>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" gitgutter
set updatetime=100
let g:gitgutter_max_signs = 500
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
set signcolumn=yes

" vim-go config
let g:go_fmt_command = "goimports"
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'varcheck', 'deadcode', 'staticcheck', 'unused']
let g:syntastic_go_checkers = ['golangci_lint', 'golint', 'govet', 'errcheck']
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_structs = 1 
let g:go_highlight_methods = 1
let g:go_highlight_build_constraints = 1
let g:go_gocode_propose_source = 0
let g:go_template_autocreate = 0
let g:go_def_mode='gopls'
let g:go_referrers_mode='gopls'
let g:go_info_mode='gopls'
let g:go_def_mapping_enabled = 1
let g:go_fmt_fail_silently = 1
let g:go_term_enabled = 1
let g:go_gopls_deep_completion = v:false
let g:go_gopls_temp_modfile = 1
let g:go_gopls_use_placeholders = 1
let g:go_addtags_transform = 'camelcase'

" rust config
let g:rustfmt_autosave = 1
au FileType rust let b:AutoPairs = AutoPairsDefine({'\w\zs<': '>'})

" auto pair config
let g:AutoPairsWildClosedPair = ''
let g:AutoPairsFlyMode = 0
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutBackInsert = '<c-b>'

" markdown config
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1

" json format
au FileType json autocmd BufWritePost *.json execute '%!python3 -m json.tool' | w

" nvim-lua/completion-nvim
set completeopt=menuone,noinsert,noselect
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" lspsaga settings
" nnoremap <silent> <C-i> <cmd>Lspsaga hover_doc<cr>
nnoremap <silent> <C-f> <cmd>Lspsaga show_line_diagnostics<cr>

" telescope settings
nnoremap <silent> <C-p> <cmd>Telescope find_files<cr>
nnoremap <silent> <C-r> <cmd>Telescope live_grep<cr>

" nvim 5.0 lua settings
lua << EOF
local nvim_lsp = require('lspconfig')
local protocol = require'vim.lsp.protocol'

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', '<C-i>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts) 
  buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)

  protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  }
end

local servers = { 
  "rls", -- can use rustup rust_analyzer instead
  "gopls",
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { 
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local status, lualine = pcall(require, "lualine")
if (not status) then return end
lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'codedark',
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      { 'diagnostics', sources = {"nvim_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

local saga = require 'lspsaga'
saga.init_lsp_saga {
  use_saga_diagnostic_sign = true,
  dianostic_header_icon = '  ',
  code_action_icon = '',
  finder_definition_icon = ' ',
  finder_reference_icon = ' ',
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '', 
  definition_preview_icon = ' ',
  border_style = "single",
}
EOF

" for monorepo golang memo
"
" local nvim_lsp = require('lspconfig')
" local root_pattern = nvim_lsp.util.root_pattern(".git", "go.mod")
" 
" -- try not to use gopls on gophers/go
" function root_dir(fname)
"   local root = fname:match ".*/gophers/go/.-/"
"   return root ~= nil and root or root_pattern(fname) 
" end
" 
" nvim_lsp['gopls'].setup {
"   root_dir = root_dir,
"   ...
" }
