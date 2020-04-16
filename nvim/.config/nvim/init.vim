let mapleader = "\<Space>"
set mouse=a
set shiftwidth=4 tabstop=4 expandtab
set termguicolors
set autoread
set incsearch
set nohlsearch
set scrolloff=10
set showmatch
set noswapfile
set autowriteall
set relativenumber
set number
set background=dark
set splitright
set clipboard+=unnamedplus
set formatoptions-=cro
set inccommand=nosplit

" python host prog handling
let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python'

" Dein bootstrap
function s:SID()
      return matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\zeSID$')
endfun
let s:dein_path = glob('~/.cache/dein/repos/github.com/Shougo/dein.vim')
if  empty(s:dein_path)
    silent !curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh|sh -s ~/.cache/dein
endif

" Dein plugin config
if &compatible
    set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    "Plugin manager
    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    "Colorschemes
    call dein#add('liuchengxu/space-vim-theme')

    "UI
    call dein#add('mhinz/vim-startify',{
                \'hook_add':join([
                \'let g:startify_change_to_dir=0',
                \'let g:startify_change_to_vcs_root=1'],"\n")})
    call dein#add('itchyny/lightline.vim',
                \{'hook_add':'source ~/.config/nvim/lightline_rc.vim'})

    "Plugins
    "Interface
    call dein#add('Shougo/denite.nvim',
                \{ 'on_cmd': ['Denite', 'DeniteBufferDir','DeniteCursorWord','DeniteProjectDir'],
                \'hook_source':'source ~/.config/nvim/denite_rc.vim'})
    call dein#add('uiiaoo/java-syntax.vim',{'on_ft':'java'})
    call dein#add('wsdjeg/dein-ui.vim',
                \{'on_cmd':'DeinUpdate'})
    call dein#add('liuchengxu/vim-which-key', {'on_cmd':['WhichKey', 'WhichKey!'],'hook_add':'nnoremap <silent> <leader> :WhichKey "<Space>"<CR>'})
    "file explorer
    call dein#add('Shougo/defx.nvim',{
                \'on_cmd':'Defx',
                \'hook_source':'source ~/.config/nvim/defx_rc.vim'})
    "Generic Programming
    call dein#add('sheerun/vim-polyglot')
    call dein#add('preservim/nerdcommenter',
                \{'on_map': ['<Plug>','<leader>c']})
    call dein#add('tpope/vim-repeat',
                \{'on_map' : '.'})
    call dein#add('tpope/vim-surround',
                \{'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'},
                \'depends' : 'vim-repeat'})
    call dein#add('jiangmiao/auto-pairs',
                \{'on_map' : { 'i' : ['(', '[', '{','<','"',"'"] },
                \'hook_post_source':'call AutoPairsTryInit()'})
    "Terminal UI
    call dein#add('rickysaurav/nvimux',{
                \'on_cmd':['NvimuxVerticalSplit','NvimuxHorizontalSplit','NvimuxToggleTerm'],
                \'on_map':{'n':['<leader>t']},
                \'hook_source': 'call ' . s:SID() . 'nvimux_setup()'})
    "call dein#add('Vigemus/nvimux',{
                "\'on_cmd':['NvimuxVerticalSplit','NvimuxHorizontalSplit','NvimuxToggleTerm'],
                "\'on_map':{'n':['<leader>t']},
                "\'hook_source': 'call ' . s:SID() . 'nvimux_setup()'})
    call dein#add('kassio/neoterm',{
                \'on_cmd':['<Plug>','T','Tmap','TREPLSendFile','TREPLSendLine','TREPLSendSelection','Texec','Tnew','Topen','Ttoggle'],
                \'on_ft':['python','java'],
                \'hook_add':'let g:neoterm_default_mod = "botright"',
                \'augroup':'set_repl_cmd'
                \})
    "Navigation
    call dein#add('easymotion/vim-easymotion',{
                \'on_map': {'n': '<Plug>'},
                \'hook_add' : join(['map <Leader>m <Plug>(easymotion-prefix)',
                \'map  / <Plug>(easymotion-sn)',
                \'omap / <Plug>(easymotion-tn)'],"\n"),
                \'hook_source' : 'let g:EasyMotion_smartcase = 1'})
    "Language
    call dein#add('neoclide/coc.nvim', {
                \'merged':0,
                \'rev': 'release',
                \'on_event':'InsertEnter',
                \'on_func' :'coc#config',
                \'on_cmd' : ['CocConfig','CocAction','CocCommand'],
                \'on_ft':['python','java','cpp','c','lua'],
                \'hook_add':'let g:coc_global_extensions = ["coc-python","coc-java"]',
                \'hook_source':'call ' . s:SID() . 'coc_nvim_setup()'
                \})
    call dein#add('rickysaurav/coc-denite',{
                \'on_source':['coc.nvim','denite.nvim'],
                \   })
    "call dein#add('neoclide/coc-denite',{
                "\'on_source':['coc.nvim','denite.nvim'],
                "\   })
    "Misc
    call dein#add('Shougo/neoyank.vim',
                \{ 'on_event': 'TextYankPost',
                \'on_source':['denite.nvim']})
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable


if dein#check_install()
    call dein#install()
endif
"Dein hook post source handling
autocmd VimEnter * call dein#call_hook('post_source')


"colorschemes
colorscheme space_vim_theme


"mappings
"Buffers
if dein#tap('denite.nvim')
    map <leader>bl :Denite buffer<CR>
    map <leader>bb :Denite buffer file/old<CR>
endif
map <leader>bn :bnext<CR>
map <leader>bp :bprevious<CR>
map <leader>bd :bdelete<CR>
map <leader>bc <C-^><CR>

"Files
if dein#tap('denite.nvim')
    map <leader>ff :DeniteBufferDir file<CR>
    map <leader>fh :Denite file/old<CR>
    map <leader>fg :Denite file/point<CR>
    map <leader>fd :DeniteBufferDir file/rec<CR>
endif
map <leader>fy :let @+ = expand('%')<CR>
map <leader>fv :edit $MYVIMRC<CR>
map <leader>fr :source $MYVIMRC<CR>
if dein#tap('defx.nvim')
    "open defx tree with pointer to current file
    map <leader>ft :Defx `getcwd()` -search=`expand('%:p')`<CR>
endif

"Project
if dein#tap('denite.nvim')
    map <leader>pf :DeniteProjectDir file/rec<CR>
    map <leader>ps :DeniteProjectDir grep:::!<CR>
endif

"Search
if dein#tap('denite.nvim')
    map <leader>ss :Denite line<CR>
    map <leader>sj :Denite jump<CR>
    map <leader>se :Denite line/external<CR>
    map <leader>sm :Denite mark<CR>
    map <leader>so :Denite outline<CR>
endif

"Denite
if dein#tap('denite.nvim')
    map <leader>dd :Denite source<CR>
    map <leader>dc :Denite command_history command<CR>
    map <leader>dh :Denite help<CR>
endif

if (dein#tap('denite.nvim') && dein#tap('neoyank.vim'))
    map <leader>dy :Denite neoyank<CR>
endif

"Window
map <leader>w <C-w>

"Coc-nvim
function! s:coc_nvim_setup() abort
    autocmd CursorHold * silent call CocActionAsync("highlight")
    augroup coc_group
        autocmd!
        autocmd FileType typescript,json setl formatexpr=CocAction("formatSelected")
        autocmd User CocJumpPlaceholder call CocActionAsync("showSignatureHelp")
    augroup end
    let lua_lsp = glob('~/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server')
    if !empty(lua_lsp)
        call coc#config('languageserver', {
            \ 'lua-language-server': {
            \     'cwd': lua_lsp,
            \     'command': lua_lsp . '/bin/Linux/lua-language-server',
            \     'args': ['-E', '-e', 'LANG="en"', lua_lsp . '/main.lua'],
            \     'filetypes': ['lua'],
            \ }
        \ })
    endif
endfunction
if (dein#tap('coc.nvim'))
    "Coc-changes
    set hidden
    set nobackup
    set nowritebackup
    set updatetime=300
    set shortmess+=c
    set signcolumn=yes
    if exists("&tagfunc")
        set tagfunc=CocTagFunc
    endif
    let g:coc_snippet_next = '<tab>'
    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    "if has('patch8.1.1068')
    "" Use `complete_info` if your (Neo)Vim version supports it.
    "inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    "else
    "imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    "endif
    if exists('*complete_info')
        " Use `complete_info` if your (Neo)Vim version supports it.
        inoremap <expr> <cr> complete_info()["selected"] != "-1" ? coc#_select_confirm() :
                    \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    else
        imap <expr> <cr> pumvisible() ? coc#_select_confirm() :
                    \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    endif

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction


    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    "Coc mappings
    "error navigation
    nmap <silent> <leader>ep <Plug>(coc-diagnostic-prev-error)
    nmap <silent> <leader>en <Plug>(coc-diagnostic-next-error)
    nmap <silent> <leader>eP <Plug>(coc-diagnostic-prev)
    nmap <silent> <leader>eN <Plug>(coc-diagnostic-next)
    nmap <silent> <leader>ei <Plug>(coc-diagnostic-info)
    if dein#tap('coc-denite') && dein#tap('denite.nvim')
        nnoremap <silent> <leader>el  :Denite coc-diagnostic<CR>
    else
        nnoremap <silent> <leader>el  :<C-u>CocList diagnostics<cr>
    endif
    "goto
    nmap <silent> <leader>lgd <Plug>(coc-definition)
    nmap <silent> <leader>lgt <Plug>(coc-type-definition)
    nmap <silent> <leader>lgi <Plug>(coc-implementation)
    nmap <silent> <leader>lgr <Plug>(coc-references)
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    "refactor
    xmap <leader>lf  <Plug>(coc-format-selected)
    nmap <leader>lf  <Plug>(coc-format-selected)
    "rename
    nmap <leader>lR <Plug>(coc-rename)
    "code-action
    xmap <leader>la  <Plug>(coc-codeaction-selected)
    nmap <leader>la  <Plug>(coc-codeaction-selected)
    nmap <leader>l.  <Plug>(coc-codeaction)
    "symbols
    if dein#tap('coc-denite') && dein#tap('denite.nvim')
        nnoremap <silent> <leader>ls  :Denite coc-symbols <cr>
        nnoremap <silent> <leader>lS  :Denite coc-workspace<cr>
    else
        nnoremap <silent> <leader>ls  :<C-u>CocList outline<cr>
        nnoremap <silent> <leader>lS  :<C-u>CocList -I symbols<cr>
    endif
    "function text objects
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)
endif
"nvimux
"
function! s:nvimux_setup() abort
lua << EOF
local nvimux = require('nvimux')

-- Nvimux configuration
nvimux.config.set_all{
  prefix = '<leader>t',
  local_prefix = {
    n = '<leader>t',
    v = '<leader>t',
    i = '<A-Space>t',
    t = '<A-Space>t',
  },
  --TODO:Find a way to wrap lua commands under dein#tap
  new_window = 'enew|term',
  new_window_buffer = 'single',
  quickterm_command='enew|term',
  quickterm_direction = 'botright',
  quickterm_orientation = 'vertical',
  quickterm_scope = 't',
}

-- Nvimux custom bindings
nvimux.bindings.bind_all{
  {'-', ':NvimuxHorizontalSplit', {'n', 'v', 'i', 't'}},
  {'\\|', ':NvimuxVerticalSplit', {'n', 'v', 'i', 't'}},
}

-- Required so nvimux sets the mappings correctly
nvimux.bootstrap()
EOF
endfunction

"Commandline mode emacs-mapings
" start of line
cnoremap <C-a>  <Home>
" back one character
cnoremap <C-b>  <Left>
" delete character under cursor
cnoremap <C-c> <Del>
" end of line
cnoremap <C-d> <End>
" forward one character
cnoremap <C-f> <Right>
" recall newer command-line
cnoremap <C-n> <Down>
" recall previous (older) command-line
cnoremap <C-p> <Up>

if !has('nvim')
    " back one word
    cnoremap <Esc><C-B> <S-Left>
    " forward one word
    cnoremap <Esc><C-F> <S-Right>
else
    " back one word
    cnoremap <A-b>  <S-Left>
    " forward one word
    cnoremap <A-f>  <S-Right>
endif

"Toggle stuff 
let s:hidden_all = 0
function! ToggleHiddenAll()
	if s:hidden_all  == 0
		let s:hidden_all = 1
		set laststatus=0
		set noshowcmd
		set showtabline=0
	else
		let s:hidden_all = 0
		set laststatus=2
		set showcmd
		set showtabline=1
	endif
endfunction

nnoremap <Leader>T :call ToggleHiddenAll()<CR>

"autosave/load setup
" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa
" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !
"filetype setup

"cpp
au FileType cpp setlocal makeprg=g\+\+\ %:p\ -g\ -std\=c\+\+11\ -D\ LOCAL_SYS\ -o\ %:p:r\ &&\ time\ %:p:r

"python
au FileType python setlocal makeprg=python\ %:p
au FileType python map <buffer> <leader>rf :TREPLSendFile<CR>
au FileType python map <buffer> <leader>rl :TREPLSendLine<CR>
au FileType python map <buffer> <leader>rr :TREPLSendSelection<CR>
au FileType python map <buffer> <leader>rt :Ttoggle<CR>
