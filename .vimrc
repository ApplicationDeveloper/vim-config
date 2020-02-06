call plug#begin()
Plug 'yuttie/comfortable-motion.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tadaa/vimade' " Breaks fzf on Vim
Plug 'joshdick/onedark.vim'
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } 
Plug 'junegunn/fzf.vim'
call plug#end()

let g:gruvbox_contrast_light='soft'
" colorscheme gruvbox
" colorscheme onedark
" colorscheme spacecamp
" === Configurations ===
" set number " Show line number
set guicursor= " Disable cursor shaping neovim
set mouse=a " Use mouse to scroll 
set smartindent
set autoindent
" set nowrap
set background=dark
set title
set hlsearch!
set incsearch " Focus search string while typing
set softtabstop=4 shiftwidth=4 expandtab
set showcmd
set pastetoggle=<F3> " Auto indent when copy & pasting
set backupdir=~/.vim/tmp//,. " Set swap files directory
set directory=~/.vim/tmp//,.

if !has('nvim')
    set clipboard=exclude:.* " Don't connect to X display
endif

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

" Goyo Configurations
let g:goyo_width = 90
let g:goyo_height = 95

" FZF Configurations
" let $FZF_DEFAULT_COMMAND=' (git ls-tree -r --name-only HEAD || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

" Comfortable Scroll Configurations
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 1  " Feel free to increase/decrease this value.
let g:comfortable_motion_friction = 0.0
let g:comfortable_motion_air_drag = 4.0

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

" Remap for Comfortable Scroll
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>

" === Commands ===
" Disable auto comment 
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=
" FZF Preview
com! -bar -bang Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({}, 'right'), <bang>0)
com! -bar -bang Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter=: --nth=4..'}, 'right'), <bang>0)

" " Open NERDTree on startup
" autocmd VimEnter * NERDTree
" " Change focus to next window
" autocmd VimEnter * 2wincmd w

" Close vim if NERDTree is last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Vue Indentation 
au BufRead,BufNewFile *.vue set filetype=vue
autocmd FileType vue setlocal shiftwidth=2 softtabstop=2 expandtab

" Always center cursor
" augroup VCenterCursor
"     au!
"     au BufEnter,WinEnter,WinNew,VimResized *,*.*
"         \ let &scrolloff=winheight(win_getid())/2
" augroup END
" === Color Highlights ===

highlight clear SignColumn
highlight PMenu ctermbg=235 ctermfg=145
highlight CocFloating ctermbg=235 ctermfg=145
highlight LineNr ctermfg=8
