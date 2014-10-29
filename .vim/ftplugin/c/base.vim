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
