" Setting some decent VIM settings for programming
" This source file comes from git-for-windows build-extra repository (git-extra/vimrc)
ru! defaults.vim                " Use Enhanced Vim defaults
aug vimStartup | au! | aug END  " Revert last positioned jump, as it is defined below
let g:skip_defaults_vim = 1     " Do not source defaults.vim again (after loading this system vimrc)

set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set showmode                    " show the current mode
" set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
set wildmode=list:longest,longest:full   " Better command line completion
" enable mouse support
set mouse=a
language en_US


" Show EOL type and last modified timestamp, right after the filename
" Set the statusline
" set statusline=%f               " filename relative to current $PWD
" set statusline+=%h              " help file flag
" set statusline+=%m              " modified flag
" set statusline+=%r              " readonly flag
" set statusline+=\ [%{&ff}]      " Fileformat [unix]/[dos] etc...
" set statusline+=\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})  " last modified timestamp
" set statusline+=%=              " Rest: right align
" set statusline+=%l,%c%V         " Position in buffer: linenumber, column, virtual column
" set statusline+=\ %P            " Position in buffer: Percentage

if &term =~ 'xterm-256color'    " mintty identifies itself as xterm-compatible
  if &t_Co == 8
    set t_Co = 256              " Use at least 256 colors
  endif
  set termguicolors           " Uncomment to allow truecolors on mintty
endif
"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,MERGE_MSG,git-rebase-todo setlocal fileencodings=utf-8

    " Remember the positions in files with some git-specific exceptions"
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
endif " has("autocmd")

let g:python3_host_prog = '/usr/bin/python3'


" "Vim Plug" Start
call plug#begin(stdpath('data') . '/plugged')

" Themes
" colorscheme
Plug 'joshdick/onedark.vim'
" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'kien/rainbow_parentheses.vim'  " color pairs

" plugins
Plug 'ryanoasis/vim-devicons'  " pretty icons
Plug 'tpope/vim-surround'      " quotes edition
Plug 'tpope/vim-commentary'    " gcc comment
Plug 'tpope/vim-repeat'        " plugin repeat
Plug 'terryma/vim-multiple-cursors'  " multi selection
Plug 'junegunn/vim-easy-align'       " simple align
Plug 'mattn/emmet-vim'


" Language support
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'     " Markdown
Plug 'dag/vim-fish'                " Fish shell
Plug 'neovimhaskell/haskell-vim'   " Haskell
Plug 'metakirby5/codi.vim'
Plug 'octol/vim-cpp-enhanced-highlight'

" CoC (Conquer of Completion)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vim Plug End
call plug#end()

" Coc
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Theme Settings
colorscheme onedark

" remove background color
hi Normal ctermbg=none guibg=none

" change leader key
let mapleader = ","

" 默认编码
set encoding=utf-8

" 设置当文件被改动时自动载入
set autoread    
"从不备份  
set nobackup
"自动保存
set autowrite
set ruler                   " 打开状态栏标尺
set cursorline              " 突出显示当前行
set magic                   " 设置魔术
" 去掉输入错误的提示声音
set noeb
" 禁止自动折叠
set nofoldenable
" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=2
" 统一缩进为2
set softtabstop=2
set shiftwidth=2
" 用空格代替制表符
set expandtab
" 在行和段开始处使用制表符
set smarttab
" 显示行号
set number
" 显示相对行号
set relativenumber
" 普通模式显示相对行号，插入模式绝对行号
autocmd! InsertEnter * :set norelativenumber
autocmd! InsertLeave * :set relativenumber
" 禁止生成临时文件
set nobackup
set noswapfile
" 搜索忽略大小写
set ignorecase
" 搜索逐字符高亮 
set hlsearch
set incsearch
" 行内替换
set gdefault
" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 字符间插入的像素行数目
set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 为C程序提供自动缩进
set smartindent


" Shotcuts
" Go to home and end using capitalized directions
noremap H ^
noremap L $

" EasyAlign: plugin settings
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

" RainbowParentheses:
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

" VimMultiCursor: plugin settings
let g:multi_cursor_use_default_mapping=1
map <M-n> <Nop>

" Default mapping
let g:multi_cursor_start_word_key      = '<M-n>'
let g:multi_cursor_select_all_word_key = '<C-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<M-n>'
let g:multi_cursor_next_key            = '<M-n>'
let g:multi_cursor_prev_key            = '<M-p>'
let g:multi_cursor_skip_key            = '<M-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" vimairline 主题与字体
" let g:airline_theme='minimalist'
let g:airline_theme='owo'
let g:airline_powerline_fonts = 1

" CoC settings
" Use :CocConfig to edit settings.json file for configuring CoC extensions

