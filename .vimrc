set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
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
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'dracula/vim'
" plugin from http://vim-scripts.org/vim/scripts.html
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
"                                                                                                                                                                       
" Brief help                                                                                                                                                            
" :PluginList       - lists configured plugins                                                                                                                          
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Airline config 
let g:airline_powerline_fonts=1

" AirlineTheme config
let g:airline_theme='wombat'

" Signify config
let g:signify_vcs_list=['git']
let g:signify_line_highlight=1

" Tagbar
let g:tagbar_ctags_bin="/usr/local/bin/ctags"

" Faster CtrlP search
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

set number
set textwidth=99
set colorcolumn=100
set softtabstop=4 shiftwidth=4 expandtab
set background=dark
set title
set hlsearch
set cursorline
set clipboard=unnamed

" NERDCommenter config
let g:NERDSpaceDelims=1
let g:NERDCustomDelimiters={'c':{ 'left': '/**', 'right': '*/'}}
let g:NERDCommentEmptyLines=1

if &term =~ '256color' || &term == 'screen'
    " Disable Background Color Erase (BCE) so that color schemes
    "     " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
    set t_Co=256
endif

if &term == 'linux' || &term == 'screen'
    colorscheme solarized
else
    colorscheme dracula
endif

autocmd FileType html setlocal shiftwidth=2 tabstop=2

syntax on
" colorscheme github
" colorscheme dracula

" Key Bindings 
nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

" Auto Session
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction
au VimEnter * nested :call LoadSession()
au VimLeave * :call MakeSession()
