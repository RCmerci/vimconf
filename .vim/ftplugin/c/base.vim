function! s:Nextstp()
    let now = getpos(".")
    let next = [now[0], now[1]+1, now[2], now[3]]
    cursor(next)
endfunction
function! s:Prevstp()
    let now = getpos(".")
    let next = [now[0], now[1]-1, now[2], now[3]]
    cursor(next)
endfunction
"-----------------------关于注释-------------------------"
nnoremap <leader>q :call ToAnno()<cr>
function! ToAnno()
    let curr = getcurpos()
    let curr = [curr[1], curr[2]]
    if getline('.')[0:1] ==# "//"
        exe "normal! 0xx"
        call cursor(curr)
        return
    endif
    exe "normal! 0i//"
    call cursor(curr)
endfunction
