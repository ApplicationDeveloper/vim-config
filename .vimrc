call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'camspiers/lens.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tadaa/vimade' " Breaks fzf on Vim
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } 
Plug 'junegunn/fzf.vim'
call plug#end()

let g:gruvbox_contrast_light='soft'

colorscheme gruvbox
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
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'border': 'sharp' } }
let g:fzf_colors = { 'border':  ['fg', 'FZFBorder'] }
let $FZF_DEFAULT_COMMAND='rg --files'
let $FZF_DEFAULT_OPTS='--layout=reverse'

" === Key Bindings ===
" FZF
nmap <C-P> :Files<CR>

" NERDTree
map <C-F7> :NERDTreeToggle<CR>

" CoC
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
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" === Commands ===
" Disable auto comment 
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=
" FZF Preview
com! -bar -bang Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({}, 'right'), <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --line-number --color=always '.shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview(),
  \ <bang>0)

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
"
" === Color Highlights ===
highlight clear SignColumn
highlight PMenu ctermbg=235 ctermfg=145
" highlight CocFloating ctermbg=235 ctermfg=145
highlight LineNr ctermfg=8
highlight StatusLine ctermbg=White ctermfg=Black
highlight Normal ctermbg=Black
highlight FZFBorder ctermfg=DarkGreen
