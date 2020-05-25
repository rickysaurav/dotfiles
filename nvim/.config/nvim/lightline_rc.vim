function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
    if exists('*FugitiveHead')
        let branch = FugitiveHead()
        return branch !=# '' ? ''.branch : ''
    endif
    return ''
endfunction


let g:lightline = {
            \ 'colorscheme': 'one',
            \ 'component': {
            \   'lineinfo': ' %3l:%-2v',
            \   'currenttime':'%{strftime("%H:%M")}'
            \ },
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified','cocstatus']],
            \   'right': [['filetype'], ['currenttime'], ['fileformat', 'fileencoding']]
            \ },
            \ 'component_function': {
            \   'readonly': 'LightlineReadonly',
            \   'cocstatus': 'coc#status',
            \   'currentfunction': 'CocCurrentFunction',
            \   'gitbranch':'LightlineFugitive'
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' }
            \ }
