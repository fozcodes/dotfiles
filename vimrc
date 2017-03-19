" Setup {{{
set shell=/bin/sh
set nocompatible
filetype off
set encoding=utf-8
set title                   " Put title in terminal window 
set exrc
set secure
" }}}
" Plugins {{{
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'AutoClose'
Plugin 'KeitaNakamura/neodark.vim'
Plugin 'Shougo/neocomplete.vim.git'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'altercation/vim-colors-solarized'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'mbbill/undotree'
Plugin 'mxw/vim-jsx'
Plugin 'roman/golden-ratio'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree.git'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0ng/vim-hybrid'
Plugin 'w0rp/ale'
Plugin 'wesQ3/vim-windowswap'
Plugin 'tomasr/molokai'
call vundle#end()
" }}}
" Misc {{{
set ttyfast                     " faster redraw
set backspace=indent,eol,start
" }}}
" Undo / Swap shit {{{
" http://stackoverflow.com/questions/4331776/change-vim-swap-backup-undo-file-name/9528322#9528322
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif
" }}}
" Mouse Shit {{{
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing<Paste>
" }}}
" Tab and Space Shit {{{
" Set tabs to be not stupid "
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

set nojoinspaces            " Prevents inserting two spaces after punctuation on a join (J)
" }}}
" Commands {{{
command! MakeTags !ctags -R .
set tags=tags;/
" }}}
" Leader Shortcuts {{{
let g:mapleader=','
noremap <leader>bg :call ToggleBG()<CR>
nnoremap <leader>rtw :%s/\s\+$//e<CR> 
inoremap jk <esc>
" }}}
" Folding {{{
set foldenable
set foldmethod=indent   
set foldnestmax=10      " 10 nested fold max
set foldlevelstart=10   " open most folds by default
" space open/closes folds
nnoremap <space> za
" }}} 
" Custom Functions {{{
function! ToggleBG()        " Allow to trigger background
  let s:tbg = &background
  if s:tbg == "dark"
    set background=light
  else
    set background=dark
  endif
endfunction

function! StripTrailingWhitespace()
    " Preparation save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! Clevertab()
  if pumvisible()
    return "\<c-n>"
  endif
  let substr = strpart(getline('.'), 0, col('.') - 1)
  let substr = matchstr(substr, '[^ \t]*$')
  if strlen(substr) == 0
    " nothing to match on empty string
    return "\<tab>"
  else
    " existing text matching
    if neosnippet#expandable_or_jumpable()
      return "\<plug>(neosnippet_expand_or_jump)"
    else
      return neocomplete#start_manual_complete()
    endif
  endif
endfunction

function! CleverCr()
  if pumvisible()
    return "\<esc>a"
  else
    return "\<Enter>"
  endif
endfunction
" }}} 
" Formatting {{{
set nowrap                      " Do not wrap long lines
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,css,java,go,php,javascript,jsx,json,puppet,python,rust,ruby,elixir,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
"autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd FileType haskell,puppet,ruby,yml,javascript,elixir setlocal expandtab shiftwidth=2 softtabstop=2
" preceding line best in a plugin but here for now.

autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd BufNewFile,BufRead *.scerb set filetype=scss.erb
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufRead,BufNewFile Appraisals set filetype=ruby

" Workaround vim-commentary for Haskell
autocmd FileType haskell setlocal commentstring=--\ %s
" Workaround broken colour highlighting in Haskell
autocmd FileType haskell,rust setlocal nospell

"Wrap for Markdown files
au BufRead,BufNewFile *.md setlocal textwidth=80

let g:rubycomplete_buffer_loading = 1

if did_filetype()
    finish
endif
if getline(1) =~# '^#!.*/bin/env\s\+[babel\-]?node\>'
    setfiletype javascript
endif

let g:jsx_ext_required = 0
" }}} 
" Turn off spell check cause I spel gud {{{
set nospell
highlight ColorColumn ctermbg=17 ctermfg=white guibg=#CCCCCC
set colorcolumn=80
autocmd BufRead,BufNewFile *.md setlocal spell " Except MD files...can't spell
" }}} 
" UI Related Shit {{{
set splitright              " Puts new vsplit windows to the right of the current
set splitbelow              " Puts new split windows to the bottom of the current

set number                  " Set de nubmers
set relativenumber          " Set de relnubmers
set list listchars=tab:»·,trail:·

set laststatus=2

syntax enable
filetype plugin indent on   " Automatically detect file types.
set t_Co=256
set background=dark         " Assume a dark background
"colorscheme molokai
colorscheme hybrid_reverse
"colorscheme neodark
"colorscheme solarized
set cursorline
let g:airline_theme = "hybrid"
" }}} 
" Clipboard stuff {{{
" ------- Do some stupid shit w/ clipboard that 
"  ------ I can't live without cause I suck
if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif
" }}}
" Autoclose {{{
" Force newline and put cursor in center
inoremap {<CR> {<CR>}<C-o>==<C-o>O
inoremap (<CR> (<CR>)<C-o>==<C-o>O
inoremap [<CR> [<CR>]<C-o>==<C-o>O
" }}}
" Ctrl P {{{ 
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|_build\|\~$'
" }}}
" EasyMotion {{{
let g:EasyMotion_keys ='abcdefghijklmnopqrstuvwxyz;'
" }}}
" NERDtree {{{
let g:NERDShutUp=1 
nnoremap <C-e> :NERDTreeToggle<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeMouseMode=0
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
" }}}
" NeoComplete {{{
let g:neocomplete#enable_at_startup = 1
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
        \if &omnifunc == "" |
        \setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif

let g:acp_enableatstartup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#max_list = 15
let g:neocomplete#force_overwrite_completefunc = 1

imap <expr> <tab> Clevertab()
" <cr> close popup and save indent or expand snippet
imap <expr> <CR> CleverCr()

" <c-k> complete snippet
" <c-k> jump to next snippet point
imap <silent><expr><c-k> neosnippet#expandable() ?
      \ "\<plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
      \ "\<c-e>" : "\<plug>(neosnippet_expand_or_jump)")
" }}}
" Ale {{{
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_format = '%linter% says %s'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
" }}}
" Window Swap {{{
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ew :call WindowSwap#EasyWindowSwap()<CR>
" }}}
set modelines=1
" vim:foldmethod=marker:foldlevel=0
