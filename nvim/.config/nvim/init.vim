let mapleader = "\<Space>"
set mouse=a
set shiftwidth=4 tabstop=4 expandtab
set termguicolors
set autochdir
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

" python host prog handling
let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python'

" Dein bootstrap 
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
    call dein#add('mhinz/vim-startify')
    call dein#add('itchyny/lightline.vim',
                \{'hook_add':'source ~/.config/nvim/lightline_rc.vim'})

    "Plugins
    "Interface
    call dein#add('Shougo/denite.nvim', 
                \{ 'on_cmd': 'Denite',
                \'hook_source':'source ~/.config/nvim/denite_rc.vim'})
    call dein#add('raghur/fruzzy', 
                \{
                \'on_source':['denite.nvim'],
                \'hook_source':join([
                \ 'let g:fruzzy#sortonempty = 0',
                \ 'let g:fruzzy#usenative = 1',
                \ 'call denite#custom#source("_", "matchers", ["matcher/fruzzy"])'
                \ ],"\n"),
                \'hook_post_update' : 'call fruzzy#install()',
                \})
    call dein#add('wsdjeg/dein-ui.vim',
                \{'on_cmd':'DeinUpdate'})
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
    "Navigation
    call dein#add('easymotion/vim-easymotion',{
                \'on_map': {'n': '<Plug>'},
                \'hook_add' : join(['map <Leader>m <Plug>(easymotion-prefix)',
                \'map  / <Plug>(easymotion-sn)',
                \'omap / <Plug>(easymotion-tn)'],"\n"),
                \'hook_source' : 'let g:EasyMotion_smartcase = 1'})
    "Language 
    call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
    call dein#add('neoclide/coc-denite',{
                \'on_source':['denite.nvim'],
                \   })
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
map <leader>bc :blast<CR>

"Files 
if dein#tap('denite.nvim')
    map <leader>ff :Denite file<CR>
    map <leader>fh :Denite file/old<CR>
    map <leader>fg :Denite file/point<CR>
    map <leader>fd :Denite file/rec<CR>
endif
map <leader>fy :let @" = expand("%")<CR>
map <leader>fv :edit $MYVIMRC<CR>
map <leader>fr :source $MYVIMRC<CR>

"Project
if dein#tap('denite.nvim')
    map <leader>pf :DeniteProjectDir file/rec<CR>
    map <leader>ps :DeniteProjectDir grep<CR>
endif

"Search 
if dein#tap('denite.nvim')
    map <leader>ss :Denite line<CR>
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

if (dein#tap('denite.nvim') && dein#call_hook('neoyank.vim'))
    map <leader>dh :Denite neoyank<CR>
endif

"Window 
map <leader>w <C-w>

"Coc-nvim 
if (dein#tap('coc.nvim'))
    "Coc-changes 
    set hidden
    set nobackup
    set nowritebackup
    set updatetime=300
    set shortmess+=c
    set signcolumn=yes
    let g:coc_snippet_next = '<tab>'
    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    "if has('patch8.1.1068')
    "" Use `complete_info` if your (Neo)Vim version supports it.
    "inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    "else
    "imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    "endif
    if has('patch8.1.1068')
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

    autocmd CursorHold * silent call CocActionAsync('highlight')

    augroup coc_group
        autocmd!
        " Setup formatexpr specified filetype(s).
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature help on jump placeholder.
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

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
        nnoremap <silent> <leader>el  :Denite coc-diagnostic
    else 
        nnoremap <silent> <leader>el  :<C-u>CocList diagnostics<cr>
    endif
    "goto 
    nmap <silent> <leader>lgd <Plug>(coc-definition)
    nmap <silent> <leader>lgt <Plug>(coc-type-definition)
    nmap <silent> <leader>lgi <Plug>(coc-implementation)
    nmap <silent> <leader>lgr <Plug>(coc-references)
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gt <Plug>(coc-type-definition)
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
        nnoremap <silent> <leader>ls  :<C-u>CocList outline<cr>
        nnoremap <silent> <leader>lS  :<C-u>CocList -I symbols<cr>
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
