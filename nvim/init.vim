set nocompatible

if has('nvim')
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync
  endif

  call plug#begin('~/.config/nvim/plugins')
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync
  endif

  call plug#begin('~/.vim/bundle')
endif
  " Apperance:
  Plug 'vim-airline/vim-airline'                                    " Statusbar
  Plug 'vim-airline/vim-airline-themes'                             " Theming for statusbar
  Plug 'lifepillar/vim-solarized8'                                  " Solarized color scheme
  Plug 'mhinz/vim-signify'                                          " git gutter
  Plug 'majutsushi/tagbar'                                          " Show tags in statusbar and navigate them

  " Syntax:
  Plug 'StanAngeloff/php.vim', {'for': 'php'}                       " Better PHP support
  Plug 'fatih/vim-go'                                               " Golang support
  Plug 'pangloss/vim-javascript'                                    " Improved js syntax
  Plug 'mechatroner/rainbow_csv'                                    " Better CSV support
  Plug 'lilydjwg/colorizer'                                         " Show colors in css
  Plug 'w0rp/ale'                                                   " Async linter

  " Navigation:
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Install fzf
  Plug 'junegunn/fzf.vim'                                           " FZF vim plugin
  Plug 'moll/vim-bbye'                                              " Easier buffer handling <leader>b
  Plug 'easymotion/vim-easymotion'                                  " Faster moving in files <leader><leader>w|b
  Plug 'wellle/targets.vim'                                         " More targets to make actions on; eg. inq (in quotes), seperators (specialchars), inb (in blocks (, [, {, etc.)
  Plug 'svermeulen/vim-easyclip'                                    " Better clipboard handling

  " Misc:
  Plug 'tpope/vim-eunuch'                                           " Enables filecontrols directly within vim; :Move, :Delete, :Rename, etc.
  Plug 'tpope/vim-fugitive'                                         " Git for vim, :G... to use
  Plug 'tpope/vim-repeat'                                           " Enables repeat for some plugins
  Plug 'tpope/vim-surround'                                         " Quick surrounding with eg. ys<motion> (remember with 'you surround')
  Plug 'raimondi/delimitmate'                                       " Added support for autocomplete quotes and brackets
  Plug 'ludovicchabant/vim-gutentags'                               " Setup ctags file
  Plug 'tomtom/tcomment_vim'                                        " Comments
  Plug 'junegunn/vim-easy-align'                                    " Align text

call plug#end()

"--------------------------
"|      Initialize        |
"--------------------------

let mapleader = ","

" Make an undo, backup and swapfiles directory if it does not exist
if has('nvim')
  silent !mkdir -p $HOME/.config/nvim/{.swap,.backup,.undo}
else
  silent !mkdir -p $HOME/.vim/{.swap,.backup,.undo}
endif

"--------------------------
"|      Color scheme      |
"--------------------------

syntax enable
set background=dark
if has('termguicolors')
  set termguicolors
endif

try
  let g:solarized_visibility="nowmal"
  let g:solarized_diffmode="normal"
  let g:solarized_termtrans=0
  let g:solarized_statusline="normal"
  let g:solarized_italics=1
  let g:solarized_old_cursor_style=0
  let g:solarized_use16=0
  let g:solarized_extra_hi_groups=1
  colorscheme solarized8
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry

let g:airline#extensions#tabline#enabled=1
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#ignore_bufadd_pat = '!|defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'

filetype indent on    " Use filetype indentation
filetype plugin indent on " Allow plugins to use filetype indentation


"--------------------------
"|        Settings        |
"--------------------------

if has('nvim')
  set directory=$HOME/.config/nvim/.swap//
  set backupdir=$HOME/.config/nvim/.backup//
  set undodir=~/.config/nvim/.undo// " Set the undo directory
else
  set directory=$HOME/.vim/.swap//
  set backupdir=$HOME/.vim/.backup//
  set undodir=~/.vim/.undo// " Set the undo directory
endif

set undofile                    " Turn on persistent undo
set undoreload=10000
set backspace=indent,eol,start  " Make backspace behave in a sane manner.
set number
set number relativenumber
set visualbell
set showmatch
set hidden
set noshowmode
set clipboard=unnamedplus
set smartindent
set autoindent        " Use autoindentation
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab         " Use spaces instead of tabs
set list
set listchars=tab:>-,extends:>,precedes:\<
set fileencoding=utf-8
set lazyredraw
set showmatch         " Show matching braces
set showcmd           " display incomplete commands
set ignorecase        " Ignore case on searches
set smartcase         " Use case sensitive search if there is a capital letter in the search
set undolevels=1000   " Set the number of undos that are remembered
set splitbelow        " Make horizontal splits below instead of above
set splitright        " Make vertical splits on the right
set scrolloff=3       " Start scrolling when the cursor is 3 lines away from the bottom of the window
set cursorline        " Highlight the current line
set autoread          " Automatically reload the file when it is changed from an outside program
set numberwidth=5     " give gutter a bit more spacing to prevent jumping
set mouse=a           " make mouse interactive
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" golang specific
augroup ft_go
  " au BufNewFile,BufRead *.go setlocal listchars=tab\ \ ,trail:*
  " au BufNewFile,BufRead *.go setlocal noet ts=2 sw=2 sts=2

  " au Filetype go setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
  au Filetype go setlocal noexpandtab listchars+=tab:\ \  listchars-=tab:>-
augroup END

augroup term_specifics
  autocmd!
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal norelativenumber bufhidden=hide hidden
augroup END

" enter visual mode when selecting text and dont copy line numbers
" set mouse+=a

"--------------------------
"|    Plugin settings     |
"--------------------------
command! -bang FLines call fzf#vim#grep(
     \ 'grep -vnITr --color=always --exclude-dir=".svn" --exclude-dir=".git" --exclude=tags --exclude=*\.pyc --exclude=*\.exe --exclude=*\.dll --exclude=*\.zip --exclude=*\.gz "^$"',
     \ 0,
     \ {'options': '--reverse --prompt "FLines> "'})

" autocmd BufWritePre * %s/\s\+$//e

if !executable('ctags')
  let g:gutentags_enabled = 0
endif

let g:fzf_action = {
  \ 'ctrl-m': 'e',
  \ 'ctrl-t': 'tabedit',
  \ 'ctrl-h': 'botright split',
  \ 'ctrl-v': 'vertical botright split' }

" ALE settings
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_highlight_linenrs=1
let g:ale_open_list = 0
let g:ale_keep_list_window_open=0
let g:ale_sign_column_always = 1
let g:ale_set_quickfix = 1
let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'
let g:ale_fix_on_save = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }

let g:php_sql_query = 1
let g:php_sql_heredoc = 1
let g:php_sql_nowdoc = 1
let g:php_html_load = 0
let g:php_html_in_heredoc = 1
let g:php_html_in_nowdoc = 1
let g:php_var_selector_is_identifier = 0
let g:php_syntax_extensions_enabled = ["bcmath", "bz2", "core", "curl", "date", "dom", "ereg", "gd", "gettext", "hash", "iconv", "json", "libxml", "mbstring", "mcrypt", "mhash", "mysql", "mysqli", "openssl", "pcre", "pdo", "pgsql", "phar", "reflection", "session", "simplexml", "soap", "sockets", "spl", "sqlite3", "standard", "tokenizer", "wddx", "xml", "xmlreader", "xmlwriter", "zip", "zlib"]


let g:signify_sign_show_text         = 1
let g:signify_line_highlight         = 0
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '!'

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15

set updatetime=500

"--------------------------
"|        Mappings        |
"--------------------------

command! WQ wq
command! Wq wq
command! W w
command! Q q
tnoremap <Esc> <C-\><C-n>
map <C-l> :NERDTreeToggle<CR>
map <C-M-l> :NERDTreeFind<CR>

nnoremap <C-f> :Tags<CR>
nnoremap <C-p> :FZF<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-M> :bnext<CR>
nnoremap <C-N> :bprev<CR>
" note capital B to use vim-bbye plugin
nnoremap <leader>x :Bdelete<CR>
nnoremap * :keepjumps normal! mi*`i<CR>
vnoremap // y/<C-R>"<CR>

nnoremap <leader>gd :SignifyDiff<cr>
nnoremap <leader>gp :SignifyHunkDiff<cr>
nnoremap <leader>gu :SignifyHunkUndo<cr>

" hunk jumping
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

" hunk text object
omap ic <plug>(signify-motion-inner-pending)
xmap ic <plug>(signify-motion-inner-visual)
omap ac <plug>(signify-motion-outer-pending)
xmap ac <plug>(signify-motion-outer-visual)

" nnoremap <up> <C-w>k
" nnoremap <down> <C-w>j
" nnoremap <left> <C-w>h
" nnoremap <right> <C-w>l

" Remap ctrl-c to esc
inoremap <C-c> <Esc>
nnoremap <C-c> <Esc>

" Remap j and k to operate on visual lines
nnoremap j gj
nnoremap k gk

" Start interactive EasyAlign in visual mode (e.g. vip<leader>a)
xmap <leader>a <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <leader>aip)
nmap <leader>a <Plug>(EasyAlign)
