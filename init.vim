" Basic settings
ru! defaults.vim                " Use Enhanced Vim defaults
aug vimStartup | au! | aug END  " Revert last positioned jump
let g:skip_defaults_vim = 1     " Do not source defaults.vim again

" General settings
set ai                          " Enable auto-indenting
set showmatch                   " Show matching brackets
set vb                          " Enable visual bell
set laststatus=2                " Always show status line
set showmode                    " Show current mode
set wildmode=list:longest,longest:full   " Better command line completion
set mouse=a                     " Enable mouse support
language en_US                  " Set language to English

" Encoding settings
set encoding=utf-8              " Set default encoding to UTF-8
set fileencodings=utf-8         " Set file encodings

" Appearance settings
if &term =~ 'xterm-256color'
  if &t_Co == 8
    set t_Co=256                " Use at least 256 colors
  endif
  set termguicolors             " Enable true colors
endif
set cursorline                  " Highlight current line
set number                      " Show line numbers
set relativenumber              " Show relative line numbers
autocmd! InsertEnter * :set norelativenumber
autocmd! InsertLeave * :set relativenumber

" Indentation settings
set tabstop=2                   " Set tab width
set softtabstop=2               " Set soft tab width
set shiftwidth=2                " Set shift width
set expandtab                   " Use spaces instead of tabs
set smarttab                    " Smart tab settings
set autoindent                  " Enable auto-indenting
set cindent                     " Enable C-style indentation
set smartindent                 " Enable smart indentation

" Search settings
set ignorecase                  " Ignore case in search
set hlsearch                    " Highlight search results
set incsearch                   " Incremental search

" Misc settings
set autoread                    " Automatically reload files changed outside of Vim
set nobackup                    " Disable backup files
set autowrite                   " Automatically save files
set noswapfile                  " Disable swap files
set iskeyword+=_,$,@,%,#,-      " Don't break words at these characters
set linespace=0                 " Set line spacing
set wildmenu                    " Enable wild menu
set backspace=indent,eol,start  " Enable backspace in various modes
set showmatch                   " Highlight matching brackets
set matchtime=1                 " Set matching bracket highlight time
set scrolloff=3                 " Set scroll offset
set viminfo+=!                  " Save global variables

" Shortcuts
noremap H ^                     " Go to start of line
noremap L $                     " Go to end of line

" Plugin settings
" Vim Plug
call plug#begin(stdpath('data') . '/plugged')

" Themes
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plugins
Plug 'kien/rainbow_parentheses.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'dag/vim-fish'
Plug 'neovimhaskell/haskell-vim'
Plug 'metakirby5/codi.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mhinz/vim-signify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Theme settings
colorscheme onedark
hi Normal ctermbg=none guibg=none

" vim-airline
let g:airline_theme='owo'
let g:airline_powerline_fonts = 1

" Leader key
let mapleader = ','

" Plugin configurations
" EasyAlign
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

" RainbowParentheses
let g:rbpt_colorpairs = [
  \ ['brown',       'RoyalBlue3'],
  \ ['Darkblue',    'SeaGreen3'],
  \ ['darkgray',    'DarkOrchid3'],
  \ ['darkgreen',   'firebrick3'],
  \ ['darkcyan',    'RoyalBlue3'],
  \ ['darkred',     'SeaGreen3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['brown',       'firebrick3'],
  \ ['gray',        'RoyalBlue3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['Darkblue',    'firebrick3'],
  \ ['darkgreen',   'RoyalBlue3'],
  \ ['darkcyan',    'SeaGreen3'],
  \ ['darkred',     'DarkOrchid3'],
  \ ['red',         'firebrick3'],
  \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<A-n>'
let g:multi_cursor_select_all_word_key = '<C-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<A-n>'
let g:multi_cursor_prev_key            = '<A-p>'
let g:multi_cursor_skip_key            = '<A-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" CoC
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Language support
let g:python3_host_prog = '/usr/bin/python3'

" Autocommands
if has("autocmd")
  autocmd BufReadPre COMMIT_EDITMSG,MERGE_MSG,git-rebase-todo setlocal fileencodings=utf-8

  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$")
    \           && &filetype !~# 'commit\|gitrebase'
    \           && expand("%") !~ "ADD_EDIT.patch"
    \           && expand("%") !~ "addp-hunk-edit.diff" |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufNewFile,BufRead *.patch set filetype=diff

  autocmd Filetype diff
    \ highlight WhiteSpaceEOL ctermbg=red |
    \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/
endif

