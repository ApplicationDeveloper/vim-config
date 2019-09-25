call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tadaa/vimade'
Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
call plug#end()

" === Configurations ===
set number " Show line number
set mouse=a " Use mouse to scroll 
set smartindent
set autoindent
set nowrap
set background=light
set title
set hlsearch
set incsearch " Focus search string while typing
set softtabstop=4 shiftwidth=4 expandtab
set clipboard=exclude:.* " Don't connect to X display
set showcmd
set pastetoggle=<F3> " Auto indent when copy & pasting
set backupdir=~/.vim/tmp//,. " Set swap files directory
set directory=~/.vim/tmp//,.

" Disable Background Color Erase
" Removes color reside on scroll
if &term =~ '256color'
    set t_ut=
endif

" CoC Configurations
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set nobackup
set nowritebackup

" Vimade Configurations
let g:vimade = {}
let g:vimade.fadelevel = 0.4
let g:vimade.enablesigns = 1

" === Key Bindings ===
" FZF
nmap <C-P> :Files<CR>

" NERDTree
map <C-F7> :NERDTreeToggle<CR>

" CoC
" Use K to show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocActionAsync('doHover')
    endif
endfunction

" Use TAB to trigger completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" === Commands ===
" Disable auto comment 
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=
" FZF Preview
com! -bar -bang Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter=: --nth=4..'}, 'right'), <bang>0)

" Open NERDTree on startup
autocmd VimEnter * NERDTree
" Change focus to next window
autocmd VimEnter * 2wincmd w

" Close vim if NERDTree is last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Vue Indentation 
au BufRead,BufNewFile *.vue set filetype=vue
autocmd FileType vue setlocal shiftwidth=2 softtabstop=2 expandtab
" === Color Highlights ===

highlight clear SignColumn
highlight PMenu ctermbg=235 ctermfg=145
highlight CocFloating ctermbg=235 ctermfg=145
highlight LineNr ctermfg=8

