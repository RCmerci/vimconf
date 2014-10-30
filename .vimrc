set number
syntax on
filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
"----------------把hjkl改成ijkl----------------{{{
nnoremap i k
nnoremap k j
nnoremap j h
nnoremap h i
"----------------------------------------------}}}
"--------------0和$太难用了，换成J和L----------{{{
nnoremap J 0
nnoremap L $
nnoremap I H
nnoremap H I
"----------------------------------------------}}}
"---------------定义mapleader="9" -----------{{{
let mapleader = "9"
"---------------------------------------------}}}
"---------------快速修改.vimrc--------------{{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
"---------------------------------------------}}}
"--------------快速esc------------------------{{{
inoremap jk <esc>
vnoremap jk <esc><esc>
"---------------------------------------------}}}
"-----------屏蔽insert模式esc-----------------{{{
inoremap <esc> <nop>
vnoremap <esc> <nop>
map <UP> <NOP>
map <DOWN> <NOP>
map <LEFT> <NOP>
map <RIGHT> <NOP>
inoremap <UP> <NOP>
inoremap <DOWN> <NOP>
inoremap <LEFT> <NOP>
inoremap <RIGHt> <NOP>
"---------------------------------------------}}}
"-------------------设置状态栏----------------{{{
set statusline=%f\ -\ FileType:%y\ -\ %l/%L
"----------------------------------------------}}}
"------------vimscript折叠------------------{{{
augroup filetype_vim
    autocmd!
    autocmd filetype vim setlocal foldmethod=marker
augroup end
"--------------------------------------------}}}
"----------------对括号和引号的设置---------------{{{
inoremap ( <esc>:call <SID>ParFuncL(0)<cr>a
inoremap [ <esc>:call <SID>ParFuncL(1)<cr>a
inoremap { <esc>:call <SID>ParFuncL(2)<cr>a
inoremap < <esc>:call <SID>ParFuncL(3)<cr>a
inoremap ) <esc>:call <SID>ParFuncR(0)<cr>a
inoremap ] <esc>:call <SID>ParFuncR(1)<cr>a
inoremap } <esc>:call <SID>ParFuncR(2)<cr>a
inoremap > <esc>:call <SID>ParFuncR(3)<cr>a
function! s:ParFuncL(type)
    let p = getline('.')[col('.')-2]
    let c = getline('.')[col('.')-1]
    let input = ''
    let r = ""
    if a:type ==# 0 "(
        let input = "("
        let r = ")"
    elseif a:type ==# 1 "[
        let input = "["
        let r = "]"
    elseif a:type ==# 2 "{
        let input = "{"
        let r = "}" 
    elseif a:type ==# 3 "<
        let input = "<"
        let r = ">"
    endif
    if c !=# input
        exe "normal! a". input . r ."\<LEFT>" 
    endif
endfunction
function! s:ParFuncR(type)
    let n = getline('.')[col('.')]
    echom n
    echom "col" . col('.')+1
    let input = ""
    if a:type ==# 0 
        let input = ")"
    elseif a:type ==# 1 
        let input = "]"
    elseif a:type ==# 2 
        let input = "}"
    elseif a:type ==# 3 
        let input = ">"
    endif
    if n ==# input
        exe "normal! \<RIGHT>"
    else
        exe "normal! a" . input
    endif
endfunction
"----------------------------------------------
inoremap " <esc>:call <SID>Quotefunc(0)<cr>a
inoremap ' ''<LEFT>
function! s:Quotefunc(type)
    let curr = getline('.')[col(".")-1]
    if a:type ==# 0
        let c = "\""
    elseif a:type ==# 1
        let c = "'"
    endif
    if curr ==# c
        exe "normal! \<RIGHT>"
    else
        exe "normal! a" . c . c . "\<LEFT>"
    endif
endfunction
"-------------------------------------------}}}
"-----test code
