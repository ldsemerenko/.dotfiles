"
" General configs
"
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set shell=/bin/bash " http://stackoverflow.com/a/12231417
set diffopt+=iwhite,vertical
set pastetoggle=<F8>
set scrolloff=3
set switchbuf+=usetab,split
set startofline
set splitbelow
set nobackup
if !has('nvim') && &compatible
  set nocompatible
endif
set nofoldenable
set noshowmode
set noswapfile
set nowrap

" History
if has("persistent_undo")
  " mkdir -p ~/.vim/undodir
  let vimdir = '$HOME/.vim'
  let vimundodir = expand(vimdir . '/undodir')
  call system('mkdir ' . vimdir)
  call system('mkdir ' . vimundodir)

  let &undodir = vimundodir
  set undofile
endif

" Indentation
set cindent
set autoindent
set smartindent

" Tab
set softtabstop=2
set shiftwidth=2
set expandtab

" Searching
set incsearch
set ignorecase
set smartcase
set hlsearch | nohlsearch
set nowrapscan

" Line number column
set number
set cursorline
" 80th column color
set textwidth=80
set formatoptions-=t
if v:version >= 703
  set colorcolumn=+1,+2,+3
endif
" Listchars
set list
" Pair matching
set matchpairs+=<:>
set showmatch
" Wildmenu
set wildmode=longest,full

" gVim (win32) only configs
if has('gui_win32')
  set clipboard=unnamed
  set guioptions=
  set guifont=Consolas:h12:cANSI:qDRAFT
  set renderoptions=type:directx
endif


"
" Key mappings
"
let g:mapleader = ","

" Easy command-line mode
nnoremap ; :
" Easy home/end
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A
nnoremap <C-a> ^
nnoremap <C-e> $
vnoremap <C-a> ^
vnoremap <C-e> $
" Easy delete key
vnoremap <backspace> "_d
" Easy newline insert
nnoremap <CR> o<Esc>
" Easy file save
nnoremap <silent> <C-s>      :update<CR>
inoremap <silent> <C-s> <ESC>:update<CR>
vnoremap <silent> <C-s> <ESC>:update<CR>
" Easy indentation
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Easy splitting & resizing
nnoremap <silent> <C-_> :split<CR>
nnoremap <silent> <C-\> :vertical split<CR>
nnoremap <silent> <C-h> :vertical resize -5<CR>
nnoremap <silent> <C-j> :resize -3<CR>
nnoremap <silent> <C-k> :resize +3<CR>
nnoremap <silent> <C-l> :vertical resize +5<CR>
" Tab navigations
nnoremap <esc>t :tabnew<CR>
nnoremap <esc>T :-tabnew<CR>
nnoremap <esc>1 1gt
nnoremap <esc>2 2gt
nnoremap <esc>3 3gt
nnoremap <esc>4 4gt
nnoremap <esc>5 5gt
nnoremap <esc>6 6gt
nnoremap <esc>7 7gt
nnoremap <esc>8 8gt
nnoremap <esc>9 9gt
" Tab navigations
nnoremap <a-t> :tabnew<CR>
nnoremap <a-T> :-tabnew<CR>
nnoremap <a-1> 1gt
nnoremap <a-2> 2gt
nnoremap <a-3> 3gt
nnoremap <a-4> 4gt
nnoremap <a-5> 5gt
nnoremap <a-6> 6gt
nnoremap <a-7> 7gt
nnoremap <a-8> 8gt
nnoremap <a-9> 9gt


"
" Vim Plugins
"
function! s:handle_gvim(msys2_rootdir)
  " Proceed only if it's gVim and msys2 is present
  if !has('gui_win32') || !isdirectory(a:msys2_rootdir) | return | endif

  " For gVim, use msys2 configs if does exist
  let $PATH           = a:msys2_rootdir . '\usr\bin;' . $PATH
  let &runtimepath    = a:msys2_rootdir . '\home\' . $USERNAME . '\.vim,' . &runtimepath
  let s:dein_basedir  = a:msys2_rootdir . '\home\' . $USERNAME . '\.vim\p'
endfunction

let s:dein_basedir = expand('~/.vim/p')
call s:handle_gvim('C:\msys64')
let s:dein_self = expand(s:dein_basedir . '/repos/github.com/Shougo/dein.vim')
let s:dein_enabled = 0

function! s:plugins()
  " Proceed only when dein.vim exists
  if !isdirectory(s:dein_basedir) | return | endif

  let s:dein_enabled = 1
  let &runtimepath .= ',' . s:dein_self

  if !dein#load_state(s:dein_basedir) | return | endif
  call dein#begin(s:dein_basedir)

  call dein#add(s:dein_self)
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  if !has('win32') && !has('win64') && !has('win32unix')
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  endif
  call dein#add('junegunn/goyo.vim')
  call dein#add('junegunn/limelight.vim')
  call dein#add('simnalamburt/vim-mundo')
  call dein#add('tpope/vim-git')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-sensible')
  call dein#add('tpope/vim-obsession')
  call dein#add('mhinz/vim-startify')
  call dein#add('godlygeek/tabular')
  call dein#add('vim-utils/vim-interruptless')
  call dein#add('junegunn/gv.vim')
  call dein#add('justinmk/vim-dirvish')

  " Haskell
  call dein#add('eagletmt/neco-ghc')
  call dein#add('neovimhaskell/haskell-vim')

  " Visual
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('chr4/sslsecure.vim')
  function! s:is_editorconfig_supported()
    if has('python3')
      return 1
    elseif has('python')
      python <<EOF
import vim
import sys
vim.command('return %d' % int(sys.version_info >= (2, 5)))
EOF
    endif
    return 0
  endfunction
  if s:is_editorconfig_supported()
    call dein#add('editorconfig/editorconfig-vim')
  endif
  call dein#add('junegunn/seoul256.vim')

  " Syntax
  call dein#add('vim-scripts/applescript.vim')
  call dein#add('simnalamburt/k-.vim')
  call dein#add('wlangstroth/vim-racket')
  call dein#add('tfnico/vim-gradle')
  call dein#add('wavded/vim-stylus')
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('idris-hackers/idris-vim')
  call dein#add('Matt-Deacalion/vim-systemd-syntax')
  call dein#add('fatih/vim-go')
  call dein#add('sheerun/vim-polyglot')

  " Blink
  call dein#add('rhysd/clever-f.vim')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('haya14busa/incsearch-fuzzy.vim')
  call dein#add('haya14busa/incsearch-easymotion.vim')

  call dein#end()
  call dein#save_state()
  filetype plugin indent on
endfunction
call s:plugins()


"
" Configs for plugins
"
if s:dein_enabled
  " vim-airline
  let g:airline_powerline_fonts = 1

  " goyo.vim
  function! s:goyo_enter()
    silent !tmux set status off
    set noshowmode
    set noshowcmd
    set scrolloff=999
    Limelight
  endfunction
  autocmd! User GoyoEnter nested call s:goyo_enter()

  function! s:goyo_leave()
    silent !tmux set status on
    set showmode
    set showcmd
    set scrolloff=3
    Limelight!
    call s:beauty()
  endfunction
  autocmd! User GoyoLeave nested call s:goyo_leave()

  " limelight.vim
  let g:limelight_conceal_ctermfg = 240

  " vim-indent-guides
  nmap <leader>i <Plug>IndentGuidesToggle
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_start_level = 2
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_exclude_filetypes = ['help', 'startify']
  let g:indent_guides_default_mapping = 0

  " vim-better-whitespace
  let g:strip_whitespace_on_save = 1

  " mundo.vim
  let g:mundo_right = 1
  nnoremap <leader>g :MundoToggle<CR>

  " vim-polyglot
  let g:polyglot_disabled = ['systemd']

  " clever-f.vim
  let g:clever_f_across_no_line = 1
  let g:clever_f_smart_case = 1

  "
  " Configs for incsearch-family plugins
  "

  " incsearch.vim
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  let g:incsearch#auto_nohlsearch = 1
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)

  " incsearch-fuzzy.vim
  map z/ <Plug>(incsearch-fuzzy-/)
  map z? <Plug>(incsearch-fuzzy-?)
  map zg/ <Plug>(incsearch-fuzzy-stay)

  " incsearch-easymotion.vim
  function! s:config_easyfuzzymotion(...) abort
    return extend(copy({
    \   'converters': [incsearch#config#fuzzy#converter()],
    \   'modules': [incsearch#config#easymotion#module()],
    \   'keymap': {"\<CR>": '<Over>(easymotion)'},
    \   'is_expr': 0,
    \   'is_stay': 1
    \ }), get(a:, 1, {}))
  endfunction
  noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
endif


"
" Beutiful vim
"
let g:seoul256_background = 233
try
  colorscheme seoul256
catch /^Vim\%((\a\+)\)\=:E185/
  " Fallback
  colorscheme elflord
endtry
let s:back_color          = 234

" Reference: https://github.com/junegunn/seoul256.vim/blob/master/colors/seoul256.vim
if !exists('s:rgb_map')
  let s:rgb_map = {
  \ 'NONE': 'NONE',
  \ 'white': '#FFFFFF', 'black': '#191919',
  \ 'darkblue': '#0000BF', 'darkgray': '#6C6C6C',
  \  16: '#000000',
  \  22: '#006F00', 23: '#007173', 24: '#007299', 25: '#0074BE', 30: '#009799',
  \  31: '#0099BD', 38: '#00BDDF', 52: '#730B00', 58: '#727100', 59: '#727272',
  \  65: '#719872', 66: '#719899', 67: '#7299BC', 68: '#719CDF', 73: '#6FBCBD',
  \  74: '#70BDDF', 88: '#9B1300', 89: '#9B1D72', 94: '#9A7200', 95: '#9A7372',
  \  96: '#9A7599', 101: '#999872', 103: '#999ABD', 108: '#98BC99', 109: '#98BCBD',
  \ 110: '#98BEDE', 116: '#97DDDF', 125: '#BF2172', 131: '#BE7572', 137: '#BE9873',
  \ 143: '#BDBB72', 144: '#BDBC98', 145: '#BDBDBD', 151: '#BCDDBD', 152: '#BCDEDE',
  \ 153: '#BCE0FF', 160: '#D70000',
  \ 161: '#E12672', 168: '#E17899', 173: '#E19972', 174: '#E09B99',
  \ 179: '#DFBC72', 181: '#E0BEBC', 184: '#DEDC00', 186: '#DEDD99', 187: '#DFDEBD',
  \ 189: '#DFDFFF', 216: '#FFBD98', 217: '#FFBFBD', 218: '#FFC0DE', 220: '#FFDD00',
  \ 222: '#FFDE99', 224: '#FFDFDF', 226: '#FFFF00',
  \ 230: '#FFFFDF', 231: '#FFFFFF', 232: '#060606',
  \ 233: '#171717', 234: '#252525', 235: '#333233', 236: '#3F3F3F', 237: '#4B4B4B',
  \ 238: '#565656', 239: '#616161', 240: '#6B6B6B', 241: '#757575', 249: '#BFBFBF',
  \ 250: '#C8C8C8', 251: '#D1D0D1', 252: '#D9D9D9', 253: '#E1E1E1', 254: '#E9E9E9',
  \ 255: '#F1F1F1' }
endif
function! s:rs(item)
  execute printf("highlight %s cterm=NONE gui=NONE", a:item)
endfunction
function! s:fg(item, color)
  execute printf("highlight %s ctermfg=%s guifg=%s", a:item, a:color, get(s:rgb_map, a:color))
endfunction
function! s:bg(item, color)
  execute printf("highlight %s ctermbg=%s guibg=%s", a:item, a:color, get(s:rgb_map, a:color))
endfunction

function! s:beauty()
  syntax enable

  call s:rs('CursorLine')
  call s:bg('CursorLine',   'NONE')
  call s:bg('CursorLineNr', s:back_color)
  call s:bg('LineNr',       s:back_color)
  call s:bg('ColorColumn',  s:back_color)
  call s:fg('VertSplit',    s:back_color)
  call s:bg('VertSplit',    s:back_color)

  " Status line, Tab line
  call s:fg('StatusLine',   s:back_color)
  call s:bg('StatusLine',   'darkgray')
  call s:fg('WildMenu',     'white')
  call s:bg('WildMenu',     s:back_color)
  call s:rs('TabLine')
  call s:fg('TabLine',      'darkgray')
  call s:bg('TabLine',      s:back_color)
  call s:rs('TabLineSel')
  call s:fg('TabLineSel',   'white')
  call s:bg('TabLineSel',   s:back_color)
  call s:fg('TabLineFill',  s:back_color)
  call s:bg('TabLineFill',  s:back_color)

  " Beauty vimdiff colorscheme
  call s:bg('DiffChange',   'NONE')
  call s:bg('DiffText',     22)
  call s:bg('DiffAdd',      22)
  call s:fg('DiffDelete',   235)
  call s:bg('DiffDelete',   'NONE')

  " Listchars for whitespaces
  call s:fg('NonText',      'darkblue')
  call s:fg('SpecialKey',   'darkblue')

  " Pair matching
  call s:fg('MatchParen',   226)
  call s:bg('MatchParen',   16)

  " Indentation
  if &softtabstop < 4 || !&expandtab
    call s:bg('IndentGuidesOdd', 'NONE')
  else
    let g:indent_guides_guide_size = 1
    call s:bg('IndentGuidesOdd', s:back_color)
  endif
  call s:bg('IndentGuidesEven', s:back_color)

  " Do not decorate tab with '›' when tabstop is small
  if &tabstop <= 4
    let &listchars = "tab:\ \ ,extends:\u00BB,precedes:\u00AB"
  else
    let &listchars = "tab:\u203A\ ,extends:\u00BB,precedes:\u00AB"
  endif

  " Extra whitespaces
  call s:bg('ExtraWhitespace', 160)
endfunction


"
" Define a 'vimrc' augroup
"
augroup vimrc
  autocmd!

  " Indentation setting for Golang
  autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
  " Treat .eslintrc .babelrc as json
  autocmd BufRead,BufNewFile .{eslintrc,babelrc} setf json

  autocmd VimEnter,ColorScheme * call s:beauty()
augroup END
