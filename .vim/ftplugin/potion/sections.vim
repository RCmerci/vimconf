noremap <script> <buffer> <silent> ]]
        \ :call <SID>NextSection(1, 0)<cr>

noremap <script> <buffer> <silent> [[
        \ :call <SID>NextSection(1, 1)<cr>

noremap <script> <buffer> <silent> ][
        \ :call <SID>NextSection(2, 0)<cr>

noremap <script> <buffer> <silent> []
        \ :call <SID>NextSection(2, 1)<cr>

function! s:NextSection(type, backwards)
    if a:type == 1
        let pattern = '\v(\n\n^\S|%^)'
        let flag = 'e'
    elseif a:type == 2
        let pattern = '\v^\S.*\=.*:'
        let flag = ''
    endif
    if a:backwards
        let dir='?'
    else
        let dir='/'
    endif

    exe 'silent normal! ' . dir . pattern . dir . flag . "\<cr>"
endfunction
