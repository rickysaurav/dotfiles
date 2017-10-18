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
autocmd BufEnter * silent! lcd %:p:h "change working directory to filename's directory
call plug#begin('~/.config/nvim/plugged')
" Make sure you use single quotes
" Group dependencies, vim-snippets depends on ultisnips
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading
Plug  'Shougo/neosnippet'| Plug 'shougo/neosnippet-snippets'|Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
function! DoRemote(arg)
	UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'zchee/deoplete-clang' "dependencies deoplete and libclang python3.
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'whatyouhide/vim-gotham'
Plug 'dylanaraps/wal.vim'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'chriskempson/base16-vim'
Plug 'flazz/vim-colorschemes'
Plug 'benekastah/neomake'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'Raimondi/delimitMate'
Plug 'vim-airline/vim-airline-themes'
Plug 'kassio/neoterm'
Plug 'shougo/echodoc.vim'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'Chiel92/vim-autoformat'
"Plug 'takac/vim-hardtime'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'arakashic/chromatica.nvim'
Plug 'tpope/vim-surround'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
Plug 'floobits/floobits-neovim', { 'do': function('DoRemote') }
Plug 'zchee/deoplete-jedi'
" Add plugins to &runtimepath
call plug#end()
filetype plugin indent on
syntax on

"Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme ='wal'
let g:airline_left_sep =  ""
let g:airline_right_sep = ""
let g:airline_left_alt_sep = ""
let g:airline_right_alt_sep = ""
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tmuxline#enabled = 0

"Tmuxline
let g:tmuxline_separators = {
			\ 'left' : '',
			\ 'left_alt': '>',
			\ 'right' : '',
			\ 'right_alt' : '<',
			\ 'space' : ' '}

"deoplete
call deoplete#custom#source('clang','max_pattern_length',0)
call deoplete#custom#source('file','min_pattern_length',0)
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/lib/clang'
let g:deoplete#sources#clang#std = {'cpp':'c++11'}
let g:deoplete#enable_at_startup = 1
set completeopt-=preview
"autocmd CompleteDone * pclose!
inoremap <expr> <C-Space> deoplete#mappings#manual_complete()

"chromatica

let g:chromatica#enable_at_startup = 1
"let g:chromatica#highlight_feature_level = 1
let g:chromatica#libclang_path = '/usr/lib'

"neomake

let g:neomake_cpp_enabled_makers=['clang']
let g:neomake_cpp_clang_args = ["-std=c++11"]
autocmd! BufWritePost * Neomake

"neosnippet

let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
let g:neosnippet#enable_snipmate_compatibility=1
let g:neosnippet#enable_completed_snippet =1

"session

let g:session_directory = '~/.config/nvim/sessions'
let g:session_autosave = 'yes'
let g:session_autoload ='yes'
let g:session_autosave_periodic = 1
let g:session_autosave_silent =1

"delimitMate
let delimitMate_expand_cr = 1

"hardtime

let g:hardtime_default_on = 1

"gutentags

let g:gutentags_project_root = ['.myfile']


"easymotion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
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
"let g:formatdef_clang ="'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=file'"
"let g:formatters_cpp = ['clang','clangformat','astyle_cpp']

"echodoc
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

"execute c++ program
nnoremap <Leader>te w<CR>:execute 'T g++ '.shellescape(expand('%:p')).' -std=c++11 -D LOCAL_SYS -o '.shellescape(expand('%:p:r')).' && time '.shellescape(expand('%:p:r'))
"fzf bindings
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

" topcoder greed open probem statement using links in new terminal
function Open_statement(filname)
	let a:tempfil = fnameescape(a:filname)
	execute 'tabnew'
	execute 'terminal links2 '.a:tempfil.'.html'
endfunction
nnoremap <Leader>os :call Open_statement(expand('%:p:r'))<CR>


" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa
" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !
map <Leader>r :exe "%s/".expand("<cword>")."/
"colorscheme gotham
"colorscheme base16-google-dark
colorschem wal

