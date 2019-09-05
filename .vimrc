set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.  " plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'dracula/vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'acoustichero/simple_dark'
Plugin 'junegunn/goyo.vim'
Plugin 'tomasr/molokai'
Plugin 'lifepillar/vim-mucomplete'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
" plugin from http://vm-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
" All of your Plugins must be added before the following line
call vundle#end()            " required      
filetype plugin indent on    " required       
" To ignore plugin indent changes, instead use:
"filetype plugin on
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set number "relativenumber
set textwidth=99
set autoindent
"set colorcolumn=101
set nowrap
set softtabstop=4 shiftwidth=4 expandtab
set background=dark
set title
set hlsearch
set incsearch
set clipboard=unnamed
set showcmd
" Auto indent when copy pasting
set pastetoggle=<F3>
" Fuzzy file built-in
set path+=**
set wildmenu
set wildignore+=*/min/*,*/vendor/*,*/node_modules/*,*/bower_components/*,*/storage/*
set backupdir=~/.vim/tmp//,.
set directory=~/.vim/tmp//,.

" Airline config 
let g:airline_powerline_fonts=1

" AirlineTheme config
let g:airline_theme='luna'

" Signify config
let g:signify_vcs_list=['git']
let g:signify_line_highlight=1

" Tagbar
let g:tagbar_ctags_bin="/usr/local/bin/ctags"

" Faster CtrlP search
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

"let g:solarized_termcolors=256

" MuComplete
set completeopt+=menuone,noselect
let g:mucomplete#enable_auto_at_startup=1

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
let $FZF_DEFAULT_COMMAND=' (git ls-tree -r --name-only HEAD || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" let dimension=&colorcolumn + 5
" 
" " Indent config
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" 
" "Goyo config
" let g:goyo_width=dimension
" let g:goyo_height=95
" let g:goyo_linenr=1

" NERDCommenter config
let g:NERDSpaceDelims=1
let g:NERDCustomDelimiters={'c':{ 'left': '/**', 'right': '*/'}}
let g:NERDCommentEmptyLines=1

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

if &term =~ '256color' || &term == 'screen'
   " Disable Background Color Erase (BCE) so that color schemes
   "     " work properly when Vim is used inside tmux and GNU screen.
   set t_ut=
   set t_Co=256
endif

if &term == 'linux' || &term == 'screen'
    " colorscheme solarized
else
    " colorscheme dracula
endif

au BufRead,BufNewFile *.vue set filetype=html
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType vue setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType js setlocal shiftwidth=4 softtabstop=4 expandtab
"Allow transparent bg
"autocmd ColorScheme * highlight Normal ctermbg=None

"autocmd ColorScheme * highlight Comment cterm=italic

"let g:mucomplete#enable_auto_at_startup = 0 
syntax enable
" colorscheme github
" colorscheme gruvbox
" colorscheme solarized
colorscheme simple_dark

" FZF Key Bindings
nmap <C-P> :Files<CR>
nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <C-S-F> :Ag<CR>

" Auto Session
" function! MakeSession()
  " let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  " if (filewritable(b:sessiondir) != 2)
    " exe 'silent !mkdir -p ' b:sessiondir
    " redraw!
  " endif
  " let b:filename = b:sessiondir . '/session.vim'
  " exe "mksession! " . b:filename
" endfunction
" 
" function! LoadSession()
  " let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  " let b:sessionfile = b:sessiondir . "/session.vim"
  " if (filereadable(b:sessionfile))
    " exe 'source ' b:sessionfile
  " else
    " echo "No session loaded."
  " endif
" endfunction

" if (argc() == 0)
  " au VimEnter * nested :call LoadSession()
" endif

augroup VCenterCursor
    au!
    au BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2
augroup END

" au VimLeave * :call MakeSession()
" au BufRead,BufEnter,BufNewFile * IndentLinesReset
" au VimEnter * Goyo
com! -bar -bang Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter=: --nth=4..'}, 'right'), <bang>0)
