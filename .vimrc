"set <leader>
let mapleader=";"
"allow file type
filetype on
filetype plugin on

"define head and end
nmap <Leader>lb 0
nmap <Leader>le $
"set copy to system clip
vnoremap <Leader>y "+y
"set paste
nmap <Leader>p "+p
"set quit
nmap <Leader>q :q<CR>
"set write
nmap <Leader>w :w<CR>
"exit
nmap <Leader>WQ :wa<CR>:q<CR>
"exit without save
nmap <Leader>Q :qa!<CR>
"explore sub window
nnoremap nw <C-W><C-W>
"to right window
nnoremap <Leader>lw <C-W>l
"to left window
nnoremap <Leader>hw <C-W>h
"to top window
nnoremap <Leader>kw <C-W>k
"to bottom window
nnoremap <Leader>jw <C-W>j
"define pair
nmap <Leader>pa %

"instant search
set incsearch
"case insensitive when search
set ignorecase
"stop compatible
set nocompatible
"command auto complete
set wildmenu


"set pathogen
runtime bundle/pathogen/autoload/pathogen.vim
"run pathogen
execute pathogen#infect()


"color, three choices
set background=dark
"colorscheme solarized
"colorscheme molokai
colorscheme phd

"no blink
set gcr=a:block-blinkon0
"no roll
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
"no menue and tools
set guioptions-=m
set guioptions-=T

"full screen
fun! ToggleFullscreen()
    call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
"full screen switch key
map <silent> <F11> :call ToggleFullscreen()<CR>
"start vim with full screen
"autocmd VimEnter * call ToggleFullscreen()


"display statue
set laststatus=2
"display current mouse position
set ruler
"display line number
set number
"highlight current line
set cursorline
set cursorcolumn
"highlight search results
set hlsearch

"set gvim font
set guifont=YaHei\ Consolas\ Hybrid\ 11.5
"no wrap
set nowrap

"code analysis
"syntax highlight
syntax enable
syntax on
"inteligient indentation
filetype indent on
"transform tab to space
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
"start with vim
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle

"code fold
"set foldmethod=indent
set foldmethod=syntax
"start vim without folding
"za open/close all folding, zM close all folding, zR open folding
set nofoldenable

"explore tag forward direction
nmap <Leader>tn :tnext<CR>
"explore tag backward direction
nmap <Leader>tp :tprevious<CR>
"config indexer and ctags parameters
"let g:indexer_ctagsCommandLineOptions="--c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q"

"config a.vim used to change between interface and implementation, e.g., my_class.h and my_class.cpp
nmap <Leader>ch :A<CR>
nmap <Leader>sch :AS<CR>

"config code navi
nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
"only already open or include files
nnoremap <leader>je :YcmCompleter GoToDefinition<CR>

"config tagbar
"set sub window position
let tagbar_left=1
nnoremap <Leader>tl :TagbarToggle<CR>
"set sub window width
let tagbar_width=32
"no redundant info
let g:tagbar_compact=1
"set tags
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:1',
        \ 'g:enums',
        \ 't:typedefs:0:0',
        \ 'e:enumerators:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:global:0:0',
        \ 'x:external:0:0',
        \ 'l:local:0:0'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

"search in project
nnoremap <Leader>sp :CtrlSF<CR>


" replace function 
" confirm : whether to confirm before replacing
" wholeword : whether match whole word
" replace : word to replace
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" no confirm, no whole word
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" no confirm, whole word
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" confirm, no whole word
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" confirm, whole word
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>

" reset tab for snips
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"

"auto code complete
let OmniCpp_DefaultNamespaces=["_GLIBCXX_STD"]
set tags+=/usr/include/c++/4.8/stdcpp.tags
set tags+=/usr/include/sys.tags


"set youcomplete
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"ycm auto complete menu color
highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
"selected content
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
"in comments
let g:ycm_complete_in_comments=1
"allow vim load .ycm_extra_conf.py
let g:ycm_confirm_extra_conf=0
"ycm tag auto complete occupy to much memory
"let g:ycm_collect_identifiers_from_tags_files=1
"ycm include OmniCppComplete
inoremap <Leader>; <C-x><C-o>
"auto preview
set completeopt-=preview
"list match contents
let g:ycm_min_num_of_chars_for_completion=1
"no cache match
let g:ycm_cache_omnifunc=0
"syntax keyword autocomplete
let g:ycm_seed_identifiers_with_syntax=1

"config man
"allow man
source $VIMRUNTIME/ftplugin/man.vim
"define key
nmap <Leader>man :Man 3 <cword><CR>

"config project with nerdtree
"set short key
nmap <Leader>fl :NERDTreeToggle<CR>
"set tree window size
let NERDTreeWinSize=32
"set tree window position
let NERDTreeWinPos="right"
"display hide file
let NERDTreeShowHidden=1
"no redundancy in NERDTree window
let NERDTreeMinimalUI=1
"delete buffer
let NERDTreeAutoDeleteBuffer=1

"config multi buffer
map <Leader>bl :MBEToggle<cr>
"buffer exchange
map <C-Tab> :MBEbn<CR>
map <C-S-Tab> :MBEbp<CR>
"rememeber last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


