let mapleader = "\<Space>"
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set mouse=a
set shiftwidth=4 tabstop=4 noexpandtab
"set termguicolors
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


"vim-plug bootstrap
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"wrapper to update remote python plugins
function! DoRemote(arg)
	UpdateRemotePlugins
endfunction


call plug#begin('~/.config/nvim/plugged')
" Make sure you use single quotes
" Group dependencies, vim-snippets depends on ultisnips
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading

" colorscheme plugins start
Plug 'liuchengxu/space-vim-dark'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'whatyouhide/vim-gotham'
Plug 'dylanaraps/wal.vim'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'chriskempson/base16-vim'
Plug 'flazz/vim-colorschemes'
" colorscheme plugins end


Plug 'Raimondi/delimitMate'
Plug 'mhinz/vim-startify'
Plug 'dylanaraps/root.vim'
Plug 'tpope/vim-surround'
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/neosnippet'| Plug 'shougo/neosnippet-snippets'|Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'w0rp/ale'
Plug 'kassio/neoterm'
Plug 'Chiel92/vim-autoformat'
Plug 'takac/vim-hardtime'
Plug 'zchee/deoplete-clang' "dependencies deoplete and libclang python3.
Plug 'zchee/deoplete-go', {'build': {'unix': 'make'}}
Plug 'fatih/vim-go'
Plug 'jodosha/vim-godebug' " Debugger integration via delve
Plug 'shougo/echodoc.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/goyo.vim'
" Add plugins to &runtimepath
call plug#end()
filetype plugin indent on
syntax on


"root.vim
let g:root#patterns += ['.myfile','.mmt','pom.xml','.sass-cache', 'Readme.md', 'gulpfile.coffee']
let g:root#echo = 0
let g:root#auto = 1

"Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme ='wal'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tmuxline#enabled = 0

"Neoterm - terminal functionality
let g:neoterm_default_mod = "vertical"


"deoplete - autocompletion
call deoplete#custom#source('file','min_pattern_length',0)
let g:deoplete#enable_at_startup = 1
inoremap <expr> <C-Space> deoplete#mappings#manual_complete()
set completeopt-=preview

"deoplete-clang setup
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/lib/clang'
let g:deoplete#sources#clang#std = {'cpp':'c++11'}

"golang - settings for vim-go
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_doc_keywordprg_enabled = 0 "important : remove 'K' mapping,lifesaver
let g:go_fmt_fail_silently = 1

"ALE- async linting neomake alternate
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
			\   'cpp': ['clang'],
			\}
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)

"neosnippet - snippet engine

let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
let g:neosnippet#enable_snipmate_compatibility=1
let g:neosnippet#enable_completed_snippet = 1


"startify - start screen and session management
let g:startify_session_dir = '~/.config/nvim/sessions'
"let g:startify_list_order = ['sessions','files', 'dir', 'bookmarks','commands']
let g:startify_list_order = [
			\ ['   sessions:'],
			\ 'sessions',
			\ ['   MRU:   '],
			\ 'files',
			\ ['   MRU directory'],
			\ 'dir',
			\ ['  bookmarks:'],
			\ 'bookmarks',
			\ ['   commands:'],
			\ 'commands',
			\ ]
let g:startify_update_oldfiles = 1
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1
let g:startify_session_sort = 1


"nerdtree
let NERDTreeHijackNetrw = 0


"delimitMate - bracket autocompletion
let delimitMate_expand_cr = 1

"hardtime - vim training
let g:hardtime_default_on = 0

"gutentags - tag management
let g:gutentags_project_root = ['.myfile']


"easymotion -
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

"Fuzzy easymotion search
function! s:config_easyfuzzymotion(...) abort
	return extend(copy({
				\   'converters': [incsearch#config#fuzzyword#converter()],
				\   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
				\   'keymap': {"\<CR>": '<Over>(easymotion)'},
				\   'is_expr': 0,
				\   'is_stay': 1
				\ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Leader>/ incsearch#go(<SID>config_easyfuzzymotion())


"neosnippet,deoplete,delimitMate harmony

imap <expr><TAB>
			\ pumvisible() ? "\<C-n>" :
			\ neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><CR> neosnippet#expandable() ?
			\ "\<Plug>(neosnippet_expand)" : "\<Plug>delimitMateCR"
imap <expr><s-TAB>
			\ pumvisible() ? "\<C-p>" : "\<s-TAB>"

"autoformat
au BufWrite *.cpp :Autoformat
au BufWrite *.vim :Autoformat
au BufWrite *.nvim :Autoformat
"let g:autoformat_verbosemode=1
let g:formatdef_clang ="'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=file'"
let g:formatters_cpp = ['clang','clangformat','astyle_cpp']

"echodoc-function signatures in statusbar
set noshowmode
let g:echodoc_enable_at_startup = 1



"maps
"easy clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>P "+P

"terminal easy exit
tnoremap II <C-\><C-n>
nnoremap <Leader>tc :Tclose<CR>

"easy split navigation

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"insert mode bindings for navigation
inoremap <C-h>  <Left>
inoremap <C-j>  <Down>
inoremap <C-k>  <Up>
inoremap <C-l>  <Right>

"easily exit insert mode
inoremap II <Esc>
vnoremap v <Esc>

"filetype based execution
au FileType python :nmap <buffer> <Leader>te w<CR>:execute 'T python '.shellescape(expand('%:p'))<CR>
au FileType go :nmap <buffer> <Leader>te w<CR>:execute 'T go run '.shellescape(expand('%:p'))<CR>
au FileType go :nmap <buffer> <Leader>k  :GoDoc<CR>
au FileType cpp :nmap <buffer> <Leader>te w<CR>:execute 'T g++ '.shellescape(expand('%:p')).' -std=c++11 -D LOCAL_SYS -o '.shellescape(expand('%:p:r')).' && time '.shellescape(expand('%:p:r'))<CR>

"fzf bindings - search
nnoremap <Leader>hf :History<CR>
nnoremap <Leader>fo :FZF<CR>
nnoremap <A-x> :Commands<CR>
nnoremap <Leader>bt :BTags<CR>
nnoremap <Leader>gt :Tags<CR>
nnoremap <Leader>bm :Marks<CR>
nnoremap <Leader>wl :Windows<CR>
nnoremap <Leader>hc :History:<CR>
nnoremap <Leader>hs :History/<CR>
nnoremap <Leader>HH :Helptags<CR>
nnoremap <Leader>fh :FZF $HOME<CR>

"move through tabs easily.
nnoremap J :tabprevious<CR>
nnoremap K :tabnext<CR>

" open file in a new tab
nnoremap <Leader>tn :tabedit % <CR>
" topcoder greed open probem statement using links in new terminal
function Open_statement(filname)
	let a:tempfil = fnameescape(a:filname)
	execute 'tabnew'
	execute 'terminal elinks '.a:tempfil.'.html'
endfunction
nnoremap <Leader>os :call Open_statement(expand('%:p:r'))<CR>


" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa
" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !
map <Leader>r :exe "%s/".expand("<cword>")."/


"colorschemes
"colorscheme gotham
"colorscheme base16-google-dark
colorschem wal

"languageclient-neovim
" 'java': ['jdtls', '-data', getcwd()],
let g:LanguageClient_serverCommands = {
			\'java': ['jdtls'],
			\'python':['pyls']
			\ }
let g:LanguageClient_loggingLevel = 'DEBUG'

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
		set showtabline=2
	endif
endfunction

nnoremap <Leader>T :call ToggleHiddenAll()<CR>

"python virtualenv values
let g:python_host_prog = $HOME.'/.local/share/virtualenvs/neovim2/bin/python'
let g:python3_host_prog = $HOME.'/.local/share/virtualenvs/neovim3/bin/python'
