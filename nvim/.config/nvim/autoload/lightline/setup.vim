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

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return ''
endfunction

function lightline#setup#config() abort
    let g:lightline = {
                \ 'colorscheme': 'one',
                \ 'component': {
                \   'lineinfo': ' %3l:%-2v',
                \   'currenttime':'%{strftime("%H:%M")}'
                \ },
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'gitbranch', 'readonly', 'filename', 'modified','lsp_status']],
                \   'right': [['filetype'], ['currenttime'], ['fileformat', 'fileencoding']]
                \ },
                \ 'component_function': {
                \   'readonly': 'LightlineReadonly',
                \   'lsp_status': 'LspStatus',
                \   'currentfunction': 'CocCurrentFunction',
                \   'gitbranch':'LightlineFugitive'
                \ },
                \ 'separator': { 'left': '', 'right': '' },
                \ 'subseparator': { 'left': '', 'right': '' }
                \ }
endfunction
