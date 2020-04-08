let s:denite_options = {
        \ "start_filter": v:true,
        \ "split": 'floating',
        \ "prompt" : ">",
        \ "floating-preview": v:true,
        \ "vertical-preview": v:true
      \}
call denite#custom#option("default", s:denite_options)
augroup user_plugin_denite
	autocmd!
	autocmd FileType denite call s:denite_settings()
	autocmd FileType denite-filter call s:denite_filter_settings()
augroup END

" Denite main window settings
function! s:denite_settings() abort
	" Denite selection window key mappings
	nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	nnoremap <silent><buffer><expr> i    denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> /    denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> d   denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p    denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> t   denite#do_map('do_action', 'tabopen')
	nnoremap <silent><buffer><expr> v   denite#do_map('do_action', 'vsplit')
	nnoremap <silent><buffer><expr> s   denite#do_map('do_action', 'split')
	nnoremap <silent><buffer><expr> '    denite#do_map('quick_move')
	nnoremap <silent><buffer><expr> q    denite#do_map('quit')
	nnoremap <silent><buffer><expr> r    denite#do_map('redraw')
	nnoremap <silent><buffer><expr> y   denite#do_map('do_action', 'yank')
	nnoremap <silent><buffer><expr> <Esc>   denite#do_map('quit')
	nnoremap <silent><buffer><expr> <Tab>   denite#do_map('choose_action')
	nnoremap <silent><buffer><expr><nowait> <Space> denite#do_map('toggle_select').'j'
endfunction

" Denite-filter window settings
function! s:denite_filter_settings() abort
	" Denite Filter window key mappings
	nmap <silent><buffer> <Esc>       <Plug>(denite_filter_quit)
	imap <silent><buffer> <Esc>       <Plug>(denite_filter_quit)
	nmap <silent><buffer> <C-c>       <Plug>(denite_filter_quit)
	imap <silent><buffer> <C-c>       <Plug>(denite_filter_quit)
	imap <silent><buffer><expr> <Tab>   denite#do_map('choose_action')
	inoremap <silent><buffer><expr> <C-t> denite#do_map('do_action', 'tabopen')
    inoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
    inoremap <silent><buffer><expr> <C-s> denite#do_map('do_action', 'split')
	inoremap <silent><buffer><expr> <C-y>   denite#do_map('do_action', 'yank')
	inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    inoremap <silent><buffer> <C-n>
            \ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
	inoremap <silent><buffer> <C-p>
		\ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction
