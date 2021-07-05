set noloadplugins
let mapleader = "\<Space>"
set mouse=a
set clipboard+=unnamedplus
set shiftwidth=4 tabstop=4 expandtab

let g:loaded_python_provider = 0
let g:python3_host_prog = '~/.pyenv/shims/python'



" Dein bootstrap
function s:SID()
    return matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\zeSID$')
endfun
let s:dein_path = glob('~/.cache/vscode/dein/repos/github.com/Shougo/dein.vim')
if  empty(s:dein_path)
    silent !curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh|sh -s ~/.cache/vscode/dein
endif

" Dein plugin config
if &compatible
    set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/vscode/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/vscode/dein')
    call dein#begin('~/.cache/vscode/dein')

    "Plugin manager
    call dein#add('~/.cache/vscode/dein/repos/github.com/Shougo/dein.vim')

    "Syntax
    call dein#add('nvim-treesitter/nvim-treesitter',{
                \'merged':0,
                \'augroup': 'NvimTreesitter',
                \'hook_source':'lua require"config.tree_sitter".setup()',
                \'on_cmd' :['TSInstall','TSBufEnable','TSEnableAll','TSModuleInfo'],
                \'on_ft':['cpp','c','python','java','lua','json','markdown','typescript']})
    call dein#add('nvim-treesitter/nvim-treesitter-textobjects',{
                \'on_source':['nvim-treesitter'],
                \})

    "Generic Programming
    call dein#add('tpope/vim-repeat',
                \{'on_map' : '.'})
    call dein#add('tpope/vim-surround',
                \{'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'},
                \'depends' : 'vim-repeat'})
    "Navigation
    call dein#add('asvetliakov/vim-easymotion',{
                \'merged':0,
                \'on_map': {'n': '<Plug>'},
                \'hook_add' : join(['map \ <Plug>(easymotion-prefix)',
                \'map  <Plug>(easymotion-prefix)/ <Plug>(easymotion-sn)',
                \'omap <Plug>(easymotion-prefix)/ <Plug>(easymotion-tn)'],"\n"),
                \'hook_source' : join(['let g:EasyMotion_smartcase = 1',
                \'let g:EasyMotion_verbose = 1'],"\n")})
    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif
"Dein hook post source handling
autocmd VimEnter * call dein#call_hook('post_source')

function! s:openVSCodeCommandsInVisualMode(cmd)
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange(a:cmd, startLine, endLine, 1)
    else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos(a:cmd, startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
endfunction

xnoremap u <Undo>
" VSCode easymotion-sn hack, without this easymotion-sn triggers a new line
nmap <CR> <nop>
vmap <CR> <nop>
nnoremap <space> <CMD>call VSCodeNotify('vspacecode.space')<CR>
xnoremap <space> <Cmd>call <SID>openVSCodeCommandsInVisualMode('vspacecode.space')<CR>
nnoremap <C-W>o <Cmd>call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')<CR>
