let mapleader = "\<Space>"
set mouse=a
set shiftwidth=4 tabstop=4 expandtab
set termguicolors
set scrolloff=10
set showmatch
set noswapfile
set autowriteall
set relativenumber
set number
set background=dark
set splitright
set clipboard+=unnamedplus
set nohlsearch
if has('nvim')
    set inccommand=nosplit
endif

if !has('nvim')
    set autoread
    set incsearch
endif

"autosave/load setup
" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa
" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !

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

    "Colorschemes
    "call dein#add('liuchengxu/space-vim-theme',{'hook_add': 'colorscheme space_vim_theme'})
    call dein#add('rakr/vim-one',{'on_event':['FocusLost','CursorHold'],'hook_source': "colorscheme one\ndoau ColorScheme"})
    "Profiling
    call dein#add('dstein64/vim-startuptime',{'on_cmd':'StartupTime'})

    "UI
    "call dein#add('mhinz/vim-startify',{
                "\'hook_add':join([
                "\'let g:startify_change_to_dir=0',
                "\'let g:startify_change_to_vcs_root=1'],"\n")})
    call dein#add('itchyny/lightline.vim',
                \{'on_event':['FocusLost','CursorHold'],
                \'hook_source':'source ~/.config/nvim/lightline_rc.vim'})
    call dein#add('rickysaurav/tmuxline.vim', {'on_cmd':'TmuxLine'})
    "Plugins
    "Interface
    call dein#add('liuchengxu/vim-clap', 
                \{ 'on_cmd':'Clap' ,
                \'augroup':'ClapYanks',
                \'hook_post_update': 'Clap install-binary!' ,
                \'hook_add': join(['let g:clap_provider_grep_opts="-H --no-heading --vimgrep --smart-case --hidden"',
                \'autocmd User ClapOnExit call lightline#update()'],"\n")
                \})
    call dein#add('shougo/denite.nvim',
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
    call dein#add('kristijanhusak/defx-icons', {'on_source':'defx.nvim'})
    call dein#add('kristijanhusak/defx-git', {'on_source':'defx.nvim'})
    "Git
    call dein#add('tpope/vim-fugitive', { 'on_cmd': [ 'Git', 'Gstatus', 'Gwrite', 'Glog', 'Gcommit', 'Gblame', 'Ggrep', 'Gdiff', 'G'] })

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
    call dein#add('Vigemus/nvimux',{
                \'on_cmd':['NvimuxVerticalSplit','NvimuxHorizontalSplit','NvimuxToggleTerm'],
                \'on_map':{'n':['<leader>t']},
                \'hook_source': 'call ' . s:SID() . 'nvimux_setup()'})
    call dein#add('Vigemus/iron.nvim',{
                \ 'on_cmd':['IronRepl','IronReplHere','IronRestart','IronSend!','IronSend','IronFocus','IronWatchCurrentFile','IronUnwatchCurrentFile'],
                \ 'on_map':{'n':['<Plug>']},
                \ 'hook_add':join(['let g:iron_map_defaults = 0',
                \    'let g:iron_map_extended = 0',
                \],"\n"),
                \ 'hook_source':'call ' . s:SID() . 'iron_setup()',
                \ })
    call dein#add('bfredl/nvim-luadev',{
                \'on_cmd':['Luadev'],
                \'on_map':{'n':['<Plug>']}
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
                \'build': 'yarn install --frozen-lockfile',
                \'on_event':'InsertEnter',
                \'on_func' :'coc#config',
                \'on_cmd' : ['CocConfig','CocAction','CocCommand'],
                \'on_ft':['python','java','cpp','c','lua','vim'],
                \'hook_add':'let g:coc_global_extensions = ["coc-python","coc-java","coc-vimlsp","coc-markdownlint","coc-explorer","coc-snippets","coc-clangd"]',
                \'hook_source':'call ' . s:SID() . 'coc_nvim_setup()'
                \})
    call dein#add('neoclide/coc-denite',{
                \'on_source':['coc.nvim','denite.nvim'],
                \   })
    call dein#add('vn-ki/coc-clap',{
                \'on_source':['coc.nvim','vim-clap'],
                \   })
    "Misc
    call dein#add('Shougo/neoyank.vim',
                \{ 'on_event': 'TextYankPost',
                \'on_source':['denite.nvim']})
    "Runner
    call dein#add('skywind3000/asyncrun.vim' ,{'on_cmd': ['AsyncRun', 'AsyncStop'] })
    call dein#add('skywind3000/asynctasks.vim',{'on_cmd': ['AsyncTask', 'AsyncTaskMacro', 'AsyncTaskList', 'AsyncTaskEdit'] })
    "Markdown
    call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
					\ 'build': 'sh -c "cd app & yarn install"' })
    call dein#end()
    call dein#save_state()
endif

if !has('nvim')
    filetype plugin indent on
    syntax enable
endif

if dein#check_install()
    call dein#install()
endif
"Dein hook post source handling
autocmd VimEnter * call dein#call_hook('post_source')




"mappings
"Buffers
if dein#tap('vim-clap')
    noremap <leader>bl :Clap buffers<CR>
    noremap <leader>bb :Clap history<CR>
elseif dein#tap('denite.nvim')
    noremap <leader>bl :Denite buffer<CR>
    noremap <leader>bb :Denite buffer file/old<CR>
endif
noremap <leader>bn :bnext<CR>
noremap <leader>bp :bprevious<CR>
noremap <leader>bd :bdelete<CR>
noremap <leader>bc <C-^><CR>

"Files
if dein#tap('vim-clap')
    noremap <leader>fh :Clap history<CR>
    noremap <leader>fd :Clap files --hidden<CR>
    noremap <leader>ff :Clap filer<CR>
elseif dein#tap('denite.nvim')
    noremap <leader>ff :DeniteBufferDir file<CR>
    noremap <leader>fh :Denite file/old<CR>
    noremap <leader>fg :Denite file/point<CR>
    noremap <leader>fd :DeniteBufferDir file/rec<CR>
endif

noremap <leader>fy :let @+ = expand('%')<CR>
noremap <leader>fv :edit $MYVIMRC<CR>
noremap <leader>fr :source $MYVIMRC<CR>
if dein#tap('defx.nvim')
    "open defx tree with pointer to current file
    noremap <leader>ft :Defx `getcwd()` -search=`expand('%:p')`<CR>
endif

if dein#tap('coc.nvim')
    noremap <leader>x :CocCommand explorer<CR>
endif

"Project
if dein#tap('vim-clap')
    noremap <leader>pf :Clap files --hidden<CR>
    noremap <leader>ps :Clap grep<CR>
elseif dein#tap('denite.nvim')
    noremap <leader>pf :DeniteProjectDir file/rec<CR>
    noremap <leader>ps :DeniteProjectDir grep:::!<CR>
endif

"Search
if dein#tap('vim-clap')
    noremap <leader>ss :Clap blines<CR>
    noremap <leader>sj :Clap jumps<CR>
    noremap <leader>se :Clap lines<CR>
    noremap <leader>sm :Clap maps<CR>
    noremap <leader>sM :Clap marks<CR>
    noremap <leader>so :Clap tags<CR>
elseif dein#tap('denite.nvim')
    noremap <leader>ss :Denite line<CR>
    noremap <leader>sj :Denite jump<CR>
    noremap <leader>se :Denite line/external<CR>
    noremap <leader>sm :Denite mark<CR>
    noremap <leader>so :Denite outline<CR>
endif

"commands
if dein#tap('vim-clap')
    noremap <leader>cc :Clap command_history<CR>
    noremap <leader>cl :Clap command<CR>
    noremap <leader>ch :Clap command_history<CR>
elseif dein#tap('denite.nvim')
    noremap <leader>cc :Denite command_history command<CR>
    noremap <leader>cl :Denite command<CR>
    noremap <leader>ch :Denite command_history<CR>
endif

"help
if dein#tap('vim-clap')
    noremap <leader>hh :Clap help_tags<CR>
elseif dein#tap('denite.nvim')
    noremap <leader>hh :Denite help<CR>
endif

"sources
if dein#tap('vim-clap')
    noremap <leader>ll :Clap providers<CR>
elseif dein#tap('denite.nvim')
    noremap <leader>ll :Denite source<CR>
endif

if dein#tap('vim-clap')
    noremap <leader>yy :Clap yanks<CR>
elseif (dein#tap('denite.nvim') && dein#tap('neoyank.vim'))
    noremap <leader>yy :Denite neoyank<CR>
endif

"Window
noremap <leader>w <C-w>

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
    if dein#tap('coc-clap') && dein#tap('vim-clap')
        nnoremap <silent> <leader>el  :Clap coc_diagnostics<CR>
    elseif dein#tap('coc-denite') && dein#tap('denite.nvim')
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
    if dein#tap('coc-clap') && dein#tap('vim-clap')
        nnoremap <leader>l.  :Clap coc_actions
    else 
        nnoremap <silent> <leader>l.  :<C-u>CocList action<cr>
    endif
    "symbols
    if dein#tap('coc-clap') && dein#tap('vim-clap')
        nnoremap <silent> <leader>ls  :Clap coc_outline<cr>
        nnoremap <silent> <leader>lS  :Clap coc_symbols<cr>
    elseif dein#tap('coc-denite') && dein#tap('denite.nvim')
        nnoremap <silent> <leader>ls  :Denite coc-symbols <cr>
        nnoremap <silent> <leader>lS  :Denite coc-workspace<cr>
    else
        nnoremap <silent> <leader>ls  :<C-u>CocList outline<cr>
        nnoremap <silent> <leader>lS  :<C-u>CocList -I symbols<cr>
    endif
    "coc-jumps
    if dein#tap('coc-clap') && dein#tap('vim-clap')
        nnoremap <silent> <leader>lj  :Clap coc_location<cr>
    elseif dein#tap('coc-denite') && dein#tap('denite.nvim')
        nnoremap <silent> <leader>lj  :Denite coc-jump-locations<cr>
    else
        nnoremap <silent> <leader>lj  :<C-u>CocList location<cr>
    endif

    "function text objects
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)
endif

"iron.nvim
function! Iron_init() abort
    nmap <buffer> <leader>rs    <Plug>(iron-send-motion)
    vmap <buffer> <leader>rs    <Plug>(iron-visual-send)
    nmap <buffer> <leader>rr    <Plug>(iron-repeat-cmd)
    nmap <buffer> <leader>rl    <Plug>(iron-send-lines)
    nmap <buffer> <leader>rt    :IronRepl<CR>
    nmap <buffer> <leader>r<CR> <Plug>(iron-cr)
    nmap <buffer> <leader>ri    <plug>(iron-interrupt)
    nmap <buffer> <leader>rq    <Plug>(iron-exit)
    nmap <buffer> <leader>rc    <Plug>(iron-clear)
    nmap <buffer> <leader>rR    :IronRestart<CR>
endfunction

function s:iron_setup() abort
lua << EOF
    local iron = require('iron')
    iron.core.set_config {
        preferred = {
            python = "ipython",
        },
        repl_open_cmd = function(buff) vim.api.nvim_command('botright vertical 100 split' .. '| ' .. buff .. ' | set wfw') end
    }
EOF
endfunction

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
