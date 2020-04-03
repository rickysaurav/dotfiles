function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction
function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction
let g:lightline = {
            \ 'colorscheme': 'darcula',
            \ 'component': {
            \   'lineinfo': ' %3l:%-2v',
            \ },
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'readonly': 'LightlineReadonly',
            \   'cocstatus': 'coc#status',
            \   'currentfunction': 'CocCurrentFunction'
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' }
            \ }
