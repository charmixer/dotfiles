vim.opt.compatible = false

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","

require("lazy").setup({
  -- Apperance:
  'vim-airline/vim-airline',                                    -- Statusbar
  'vim-airline/vim-airline-themes',                             -- Theming for statusbar
  'lifepillar/vim-solarized8',                                  -- Solarized color scheme
  'mhinz/vim-signify',                                          -- git gutter
  -- 'majutsushi/tagbar',                                       -- Show tags in statusbar and navigate them

  -- Syntax:
  'sheerun/vim-polyglot',
  'w0rp/ale',                                                   -- Async linter

  -- Navigation:
  { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" }, -- install fzf
  'junegunn/fzf.vim',                                           -- FZF vim plugin
  'moll/vim-bbye',                                              -- Easier buffer handling <leader>b
  'easymotion/vim-easymotion',                                  -- Faster moving in files <leader><leader>w|b
  'wellle/targets.vim',                                         -- More targets to make actions on; eg. inq (in quotes), seperators (specialchars), inb (in blocks (, [, {, etc.)
  'svermeulen/vim-easyclip',                                    -- Better clipboard handling

  -- Text Manipulation:
  'tpope/vim-surround',                                         -- Quick surrounding with eg. ys<motion> (remember with 'you surround')
  'preservim/nerdcommenter',
  'junegunn/vim-easy-align',                                    -- Align text

  -- Misc:
  'tpope/vim-fugitive',                                         -- Git for vim, :G... to use
  'tpope/vim-repeat',                                           -- Enables repeat for some plugins
  'ludovicchabant/vim-gutentags',                               -- Setup ctags file
})




-- --------------------------
-- |      Initialize        |
-- --------------------------


-- Make an undo, backup and swapfiles directory if it does not exist
-- silent !mkdir -p $HOME/.config/nvim/{.swap,.backup,.undo}
vim.fn.mkdir("$HOME/.config/nvim/(.swap,.backup,.undo)", "p", "0700")

-- --------------------------
-- |      Color scheme      |
-- --------------------------

vim.opt.syntax=enable
vim.opt.background=dark
--if has('termguicolors') then
  --vim.opt.termguicolors=true
--end

vim.g['solarized_visibility']="nowmal"
vim.g['solarized_diffmode']="normal"
vim.g['solarized_termtrans']=0
vim.g['solarized_statusline']="normal"
vim.g['solarized_italics']=1
vim.g['solarized_old_cursor_style']=0
vim.g['solarized_use16']=0
vim.g['solarized_extra_hi_groups']=1
vim.cmd [[ colorscheme solarized8 ]]

vim.g['airline#extensions#tabline#enabled']=1
vim.g['airline_theme']='solarized'
vim.g['airline_powerline_fonts ']= 1
vim.g['airline#extensions#tabline#ignore_bufadd_pat ']= '!|defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'
-- old vim-powerline symbols
-- let g:airline_left_alt_sep = '⮁'

vim.cmd('filetype indent off')
vim.cmd('filetype plugin indent off')


-- --------------------------
-- |        Settings        |
-- --------------------------

vim.opt.directory="$HOME/.config/nvim/.swap//"
vim.opt.backupdir="$HOME/.config/nvim/.backup//"
vim.opt.undodir="$HOME/.config/nvim/.undo//" -- Set the undo directory

vim.opt.undofile = true                    -- Turn on persistent undo
vim.opt.undoreload=10000
vim.opt.backspace=indent,eol,start  -- Make backspace behave in a sane manner.
-- vim.opt.number = true
vim.opt.number = relativenumber
vim.opt.visualbell = true
vim.opt.showmatch = true
vim.opt.hidden = true
vim.opt.showmode = false
vim.opt.clipboard = unnamedplus
vim.opt.smartindent = true
vim.opt.autoindent = false        -- Use autoindentation
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.list = true
vim.opt.listchars.tab = ">-"
vim.opt.listchars.extends = ">"
vim.opt.listchars.precedes = "<"
vim.opt.fileencoding="utf-8"
vim.opt.lazyredraw = true
vim.opt.showmatch = true         -- Show matching braces
vim.opt.showcmd = true          -- display incomplete commands
vim.opt.ignorecase = true        -- Ignore case on searches
vim.opt.smartcase = true        -- Use case sensitive search if there is a capital letter in the search
vim.opt.undolevels=1000   -- Set the number of undos that are remembered
vim.opt.splitbelow = true       -- Make horizontal splits below instead of above
vim.opt.splitright = true       -- Make vertical splits on the right
vim.opt.scrolloff=3       -- Start scrolling when the cursor is 3 lines away from the bottom of the window
vim.opt.cursorline = true       -- Highlight the current line
vim.opt.autoread = true         -- Automatically reload the file when it is changed from an outside program
vim.opt.numberwidth=5     -- give gutter a bit more spacing to prevent jumping
vim.opt.mouse=a           -- make mouse interactive
-- vim.opt.formatoptions=-cro
-- highlight ExtraWhitespace ctermbg=red guibg=red
-- match ExtraWhitespace /\s\+$/

vim.cmd [[
:augroup term_specifics
:  autocmd!
:  autocmd TermOpen * startinsert
:  autocmd TermOpen * setlocal norelativenumber bufhidden=hide hidden
:augroup END
]]

-- enter visual mode when selecting text and dont copy line numbers
-- set mouse+=a

-- --------------------------
-- |    Plugin settings     |
-- --------------------------

-- command! -bang FLines call fzf#vim#grep(
--     \ 'grep -vnITr --color=always --exclude-dir=".svn" --exclude-dir=".git" --exclude=tags --exclude=*\.pyc --exclude=*\.exe --exclude=*\.dll --exclude=*\.zip --exclude=*\.gz "^$"',
--     \ 0,
--     \ {'options': '--reverse --prompt "FLines> "'})

-- autocmd BufWritePre * %s/\s\+$//e

-- if !executable('ctags') then
--  let g:gutentags_enabled = 0
-- end

-- vim.g['fzf_action'] = {
   -- ctrl-m = 'e',
   -- ctrl-t = 'tabedit',
   -- ctrl-h = 'botright split',
   -- ctrl-v = 'vertical botright split' 
-- }

-- ALE settings
vim.g['ale_lint_on_text_changed'] = 'never'
vim.g['ale_lint_on_enter'] = 0
vim.g['ale_lint_on_insert_leave'] = 1
vim.g['ale_echo_msg_error_str'] = 'E'
vim.g['ale_echo_msg_warning_str'] = 'W'
vim.g['ale_echo_msg_info_str'] = 'I'
vim.g['ale_echo_msg_format'] = '[%linter%] %s [%severity%]'
vim.g['ale_sign_highlight_linenrs'] = 1
vim.g['ale_open_list'] = 0
vim.g['ale_keep_list_window_open'] = 0
vim.g['ale_sign_column_always'] = 1
vim.g['ale_sign_error'] = "E"
vim.g['ale_sign_info'] = "I"
vim.g['ale_sign_style_error'] = "SE"
vim.g['ale_sign_style_warning'] = "SW"
vim.g['ale_sign_warning'] = "W"
vim.g['ale_change_sign_column_color'] = 0
vim.g['ale_set_loclist'] = 0
vim.g['ale_set_quickfix'] = 1
vim.g['ale_list_window_size'] = 5
vim.g['ale_php_phpcbf_standard'] = 'PSR2'
vim.g['ale_php_phpcs_standard'] = 'phpcs.xml.dist'
vim.g['ale_php_phpmd_ruleset'] = 'phpmd.xml'
vim.g['ale_fix_on_save'] = 1
-- vim.g['ale_fixers'] = { 'go': ['goimports'], '*': ['remove_trailing_lines', 'trim_whitespace'] }

vim.g['php_sql_query'] = 1
vim.g['php_sql_heredoc'] = 1
vim.g['php_sql_nowdoc'] = 1
vim.g['php_html_load'] = 0
vim.g['php_html_in_heredoc'] = 1
vim.g['php_html_in_nowdoc'] = 1
vim.g['php_var_selector_is_identifier'] = 0
-- vim.g['php_syntax_extensions_enabled'] = ["bcmath", "bz2", "core", "curl", "date", "dom", "ereg", "gd", "gettext", "hash", "iconv", "json", "libxml", "mbstring", "mcrypt", "mhash", "mysql", "mysqli", "openssl", "pcre", "pdo", "pgsql", "phar", "reflection", "session", "simplexml", "soap", "sockets", "spl", "sqlite3", "standard", "tokenizer", "wddx", "xml", "xmlreader", "xmlwriter", "zip", "zlib"]

-- git gutter
vim.g['signify_sign_show_text']         = 1
vim.g['signify_sign_show_count']        = 1
vim.g['signify_line_highlight']         = 0
vim.g['signify_sign_add']               = '+'
vim.g['signify_sign_delete']            = '_'
vim.g['signify_sign_delete_first_line'] = '‾'
vim.g['signify_sign_change']            = '!'

vim.cmd [[
:highlight SignColumn                 ctermbg=NONE guibg=NONE
:highlight SignifySignAdd             ctermbg=NONE guibg=NONE ctermfg=green guifg=#4fab4f
:highlight SignifySignChange          ctermbg=NONE guibg=NONE ctermfg=green guifg=#4fab4f
:highlight SignifySignDelete          ctermbg=NONE guibg=NONE ctermfg=red   guifg=#e34b67
:highlight SignifySignDeleteFirstLine ctermbg=NONE guibg=NONE ctermfg=red   guifg=#e34b67
:highlight SignifyLineAdd             ctermbg=NONE guibg=NONE ctermfg=NONE  guifg=NONE
:highlight SignifyLineChange          ctermbg=NONE guibg=NONE ctermfg=NONE  guifg=NONE
:highlight SignifyLineDelete          ctermbg=NONE guibg=NONE ctermfg=NONE  guifg=NONE
:highlight SignifyLineDeleteFirstLine ctermbg=NONE guibg=NONE ctermfg=NONE  guifg=NONE
]]

-- file browser
vim.g['netrw_banner'] = 0
vim.g['netrw_liststyle'] = 3
vim.g['netrw_browse_split'] = 4
vim.g['netrw_altv'] = 1
vim.g['netrw_winsize'] = 15

-- vim-go:
vim.g['go_fmt_command'] = "goimports"
vim.g['go_autodetect_gopath'] = 1
vim.g['go_list_type'] = ""
vim.g['go_fmt_fail_silently'] = 1

vim.g['go_highlight_types'] = 1
vim.g['go_highlight_fields'] = 1
vim.g['go_highlight_functions'] = 1
vim.g['go_highlight_function_calls'] = 1
vim.g['go_highlight_extra_types'] = 0
vim.g['go_highlight_generate_tags'] = 0

-- Open :GoDeclsDir with ctrl-g
-- nmap <C-g> :GoDeclsDir<cr>
-- imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

vim.cmd [[
:augroup go
:  autocmd!
:  " Show by default 2 spaces for a tab
:  autocmd BufNewFile,BufRead *.go setlocal noexpandtab listchars+=tab:\ \  listchars-=tab:>- tabstop=2 shiftwidth=2
:  " :GoTest
:  autocmd FileType go nmap <leader>t <Plug>(go-test)
:  " :GoRun
:  autocmd FileType go nmap <leader>r <Plug>(go-run)
:  " :GoDoc
:  autocmd FileType go nmap <Leader>d <Plug>(go-doc)
:  " :GoInfo
:  autocmd FileType go nmap <Leader>i <Plug>(go-info)
:augroup END
]]

vim.cmd [[
:augroup svelte_syntax
:  au!
:  autocmd BufNewFile,BufRead *.svelte   set vim.g.syntax=html
:augroup END
]]

vim.g['updatetime'] = 500

-- --------------------------
-- |        Mappings        |
-- --------------------------

-- command! WQ wq
-- command! Wq wq
-- command! W w
-- command! Q q
-- tnoremap <Esc> <C-\><C-n>

-- nnoremap <C-f> :Tags<CR>
-- nnoremap <C-p> :FZF<CR>
-- nnoremap <C-s> :w<CR>
-- nnoremap <C-M> :bnext<CR>
-- nnoremap <C-N> :bprev<CR>
-- note capital B to use vim-bbye plugin
-- nnoremap <leader>x :Bdelete<CR>
-- nnoremap * :keepjumps normal! mi*`i<CR>
-- vnoremap // y/<C-R>"<CR>

-- nnoremap <leader>gd :SignifyDiff<cr>
-- nnoremap <leader>gp :SignifyHunkDiff<cr>
-- nnoremap <leader>gu :SignifyHunkUndo<cr>

-- Remap ctrl-c to esc
-- inoremap <C-c> <Esc>
-- nnoremap <C-c> <Esc>

-- Remap j and k to operate on visual lines
-- nnoremap j gj
-- nnoremap k gk

-- Start interactive EasyAlign in visual mode (e.g. vip<leader>a)
-- xmap <leader>a <Plug>(EasyAlign)

-- Start interactive EasyAlign for a motion/text object (e.g. <leader>aip)
-- nmap <leader>a <Plug>(EasyAlign)
