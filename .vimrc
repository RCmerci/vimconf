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
inoremap ' <esc>:call <SID>Quotefunc(1)<cr>a
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
        if col(".") ==# 1
            exe "normal! i" . c . c . "\<LEFT>"
            return
        endif
        exe "normal! a" . c . c . "\<LEFT>"
    endif
endfunction
"-------------括号引号的移动-------------------------------"
inoremap <c-l> <esc>:call <SID>ParMoveR()<cr>
inoremap <c-j> <esc>:call <SID>ParMoveL()<cr>
function! s:ParMoveR() "这里用mark，还不知道怎么获得之前的mark位置,所以会破坏之前设置的mark
    exe "normal! mz"     
    if <SID>GetNextPar([getcurpos()[1], getcurpos()[2]+1]) == 0
        exe "normal! `z"
        call feedkeys("a", 'n')
        return -1
    endif
    let go = input("set')'after:", '')
    exe "normal! x"
    if go !=# '' && search(go, 'We')
        exe "normal! a)\<esc>`z"
        call feedkeys("a", "n")
        return 0
    endif
    exe "normal! i)\<ESC>`z"
    call feedkeys("a", "n")
    return -1
endfunction
function! s:ParMoveL()
    exe "normal! mz"
    if <SID>GetNextPar([getcurpos()[1], getcurpos()[2]+1]) == 0
        exe "normal! `z"
        call feedkeys("a", 'n')
        return -1
    endif
    let go = input("set')'before:", '')
    exe "normal! x"
    if go !=# '' && search(go, 'Wb')
        exe "normal! \<LEFT>a)\<esc>`z"
        call feedkeys("a", "n")
        return 0
    endif
    exe "normal! i)\<ESC>`z"
    call feedkeys("a", "n")
    return -1
endfunction
function! s:GetNextPar(currentpos)
    while 1
        if search('\v\)', 'W')
            let curr = getcurpos()
            let curr = [curr[1], curr[2]]
            exe "normal! %"
            let pair = getcurpos()
            let pair = [pair[1], pair[2]]
            if <SID>CursorCompare(a:currentpos, pair) >= 0
                call cursor(curr)
                return 1
            endif
            exe "normal! %"
        else
            call cursor(a:currentpos)
            return 0
        endif
    endwhile
endfunction
function! s:CursorCompare(a, b) " a = b = [line, col]
    if a:a[0] > a:b[0]
        return 1    "a>b
    endif
    if a:a[0] < a:b[0]
        return -1   "a<b
    endif
    if a:a[1] > a:b[1]
        return 1    
    endif
    if a:a[1] < a:b[1]
        return -1
    endif
    return 0        "a=b
endfunction
"-------------------------------------------}}}
"-----test code
