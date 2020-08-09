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
set inccommand=nosplit
set updatetime=300
set completeopt=menuone,noinsert,noselect


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
    "call dein#add('liuchengxu/space-vim-theme',{
                "\'on_event':['FocusLost','CursorHold'],
                "\'hook_source': "colorscheme space_vim_theme\ndoau ColorScheme"
                "\})
    call dein#add('rakr/vim-one',{
                \'on_event':['FocusLost','CursorHold'],
                \'hook_source': "colorscheme one\ndoau ColorScheme"
                \})
    "Profiling
    call dein#add('dstein64/vim-startuptime',{'on_cmd':'StartupTime'})

    "UI
    call dein#add('itchyny/lightline.vim',
                \{'on_event':['FocusLost','CursorHold'],
                \'hook_source':'call lightline#setup#config()'})
    call dein#add('rickysaurav/tmuxline.vim', {'on_cmd':'TmuxLine'})
    call dein#add('dm1try/golden_size', {
                \'on_event':'WinEnter',
                \'hook_source':'lua require "config.golden_size".setup()'})
    "Plugins
    "Interface
    call dein#add('liuchengxu/vim-clap', 
                \{ 'on_cmd':'Clap' ,
                \'augroup':'ClapYanks',
                \'hook_post_update': 'Clap install-binary!' ,
                \'hook_add': join(['let g:clap_provider_grep_opts="-H --no-heading --vimgrep --smart-case --hidden"',
                \'autocmd User ClapOnExit call lightline#update()'],"\n")
                \})
    call dein#add('wsdjeg/dein-ui.vim',
                \{'on_cmd':'DeinUpdate'})
    call dein#add('liuchengxu/vim-which-key', {
                \'on_cmd':['WhichKey', 'WhichKey!'],
                \'hook_add':'nnoremap <silent> <leader> :WhichKey "<Space>"<CR>'
                \})
    "file explorer
    call dein#add('kyazdani42/nvim-tree.lua',{
                \'on_cmd':'LuaTreeToggle',
                \'augroup':'LuaTree',
                \'hook_add':join([
                \'let g:lua_tree_follow = 1',
                \'let g:lua_tree_disable_keybindings = 1',
                \'let g:lua_tree_icons = {"default": ""}'],"\n"),
                \})
    call dein#add('kyazdani42/nvim-web-devicons',{"merged":0}) 
    "Git
    call dein#add('tpope/vim-fugitive', { 
                \'on_cmd': [ 'Git', 'Gstatus', 'Gwrite', 'Glog', 'Gcommit', 'Gblame', 'Ggrep', 'Gdiff', 'G'] 
                \})
    "Syntax
    call dein#add('sheerun/vim-polyglot')
    call dein#add('nvim-treesitter/nvim-treesitter',{
                \'merged':0,
                \'augroup': 'NvimTreesitter',
                \'hook_source':'lua require"config.tree_sitter".setup()',
                \'on_cmd' :['TSInstall','TSBufEnable','TSEnableAll','TSModuleInfo'],
                \'on_ft':['cpp','c','python','java','lua','json','markdown','typescript']})
    call dein#add('nvim-treesitter/nvim-treesitter-refactor',{
                \'merged':0,
                \'on_source': 'nvim-treesitter',
                \})

    call dein#add('nvim-treesitter/nvim-treesitter-textobjects',{
                \'merged':0,
                \'on_source': 'nvim-treesitter',
                \})

    "Generic Programming
    call dein#add('preservim/nerdcommenter',
                \{'on_map': ['<Plug>','<leader>c']})
    call dein#add('tpope/vim-repeat',
                \{'on_map' : '.'})
    call dein#add('tpope/vim-surround',
                \{'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'},
                \'depends' : 'vim-repeat'})
    call dein#add('jiangmiao/auto-pairs',{
                \'on_map' : { 'i' : ['(', '[', '{','<','"',"'"] },
                \'hook_post_source':'call AutoPairsTryInit()'})
    "Terminal UI
    call dein#add('Vigemus/nvimux',{
                \'on_cmd':['NvimuxVerticalSplit','NvimuxHorizontalSplit','NvimuxToggleTerm'],
                \'on_map':{'n':['<leader>t']},
                \'hook_source': 'lua require"config.nvimux".setup()'})
    call dein#add('Vigemus/iron.nvim',{
                \ 'on_cmd':['IronRepl','IronReplHere','IronRestart','IronSend!','IronSend','IronFocus','IronWatchCurrentFile','IronUnwatchCurrentFile'],
                \ 'on_map':{'n':['<Plug>']},
                \ 'hook_add':join(['let g:iron_map_defaults = 0',
                \    'let g:iron_map_extended = 0',
                \],"\n"),
                \ 'hook_source':'lua require "config.iron".setup()',
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
    "call dein#add('~/repos/nvim-lsp',{
    call dein#add('neovim/nvim-lsp',{
                \'on_ft':['cpp','c','python','lua','vim','json','typescript','rust','java'],
                \'merged':0,
                \'hook_source':'lua require"config.lsp".setup()'})
    call dein#add('nvim-lua/diagnostic-nvim',{
                \'merged':0,
                \'on_source':'nvim-lsp',
                \'on_command':['OpenDiagnostic','PrevDiagnosticCycle','NextDiagnosticCycle'],
                \'hook_add':join([
                \'let g:diagnostic_enable_virtual_text = 1',
                \'let g:space_before_virtual_text = 5',
                \'let g:diagnostic_insert_delay = 1'
                \],"\n"),
                \})
    call dein#add('nvim-lua/lsp-status.nvim',{
                \'merged':0,
                \'on_source':'nvim-lsp',
                \})
    "completion
    call dein#add('nvim-lua/completion-nvim',{
                \'on_event':'InsertEnter',
                \'hook_add':join(['let g:completion_auto_change_source = 1','let g:completion_enable_snippet = "vim-vsnip"'],"\n"),
                \'hook_post_source':join([
                \'autocmd BufEnter * lua require"config.completion_nvim".on_attach()',
                \'doautocmd BufEnter'],"\n")})
    call dein#add('steelsojka/completion-buffers',{'on_source':'completion-nvim'})
    call dein#add('hrsh7th/vim-vsnip',{
                \'hook_add':'let g:vsnip_snippet_dir="~/.config/nvim/snippets/"',
                \'on_source':'completion-nvim'})
    call dein#add('hrsh7th/vim-vsnip-integ',{'on_source':'completion-nvim'})
    "Runner
    call dein#add('skywind3000/asyncrun.vim' ,{
                \'hook_add':'let g:asyncrun_open = 6',
                \'on_cmd': ['AsyncRun', 'AsyncStop'] 
                \})
    call dein#add('skywind3000/asynctasks.vim',{
                \'on_cmd': ['AsyncTask', 'AsyncTaskMacro', 'AsyncTaskList', 'AsyncTaskEdit'] 
                \})
    "Markdown
    call dein#add('iamcco/markdown-preview.nvim', {
                \'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
				\ 'build': 'sh -c "cd app & yarn install"' 
                \})
    call dein#end()
    call dein#save_state()
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
endif

noremap <leader>fy :let @+ = expand('%')<CR>
noremap <leader>fv :edit $MYVIMRC<CR>
noremap <leader>fr :source $MYVIMRC<CR>

if dein#tap('nvim-tree.lua')
    noremap <leader>x :LuaTreeToggle<CR>
endif

if dein#tap('vim-clap')
"Project
    noremap <leader>pf :Clap files --hidden<CR>
    noremap <leader>ps :Clap grep<CR>
"Search
    noremap <leader>ss :Clap blines<CR>
    noremap <leader>sj :Clap jumps<CR>
    noremap <leader>se :Clap lines<CR>
    noremap <leader>sm :Clap maps<CR>
    noremap <leader>sM :Clap marks<CR>
    noremap <leader>so :Clap tags<CR>
"commands
    noremap <leader>lc :Clap command_history<CR>
    noremap <leader>ll :Clap command<CR>
    noremap <leader>lh :Clap command_history<CR>
"help
    noremap <leader>hh :Clap help_tags<CR>
"sources
    noremap <leader>ll :Clap providers<CR>
"yanks
    noremap <leader>yy :Clap yanks<CR>
"windows
    noremap <leader>w/ :Clap windows<CR>
endif

"Window
noremap <leader>w <C-w>

"Commandline mode emacs-mapings
" start of line
inoremap <C-a>  <Home>
cnoremap <C-a>  <Home>
" back one character
inoremap <C-b>  <Left>
cnoremap <C-b>  <Left>
" delete character under cursor
inoremap <C-c> <Del>
cnoremap <C-c> <Del>
" end of line
inoremap <C-d> <End>
cnoremap <C-d> <End>
" forward one character
inoremap <C-f> <Right>
cnoremap <C-f> <Right>
" recall newer command-line
inoremap <C-n> <Down>
cnoremap <C-n> <Down>
" recall previous (older) command-line
inoremap <C-p> <Up>
cnoremap <C-p> <Up>

" back one word
inoremap <A-b>  <S-Left>
cnoremap <A-b>  <S-Left>
" forward one word
inoremap <A-f>  <S-Right>
cnoremap <A-f>  <S-Right>

" recall previous (older) command-line
inoremap <A-BS> <C-w>
cnoremap <A-BS> <C-w>

nnoremap <Leader>T :call custom_utils#toggleHiddenAll()<CR>


"snippet mappings
imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'


imap <c-k> <Plug>(completion_prev_source) "use <c-k> to switch to next completion
imap <c-j> <Plug>(completion_next_source) "use <c-j> to switch to previous completion
