nnoremap <buffer> <2-LeftMouse> :lua require"tree".on_keypress("edit")<cr>
nnoremap <buffer> <2-RightMouse> :lua require"tree".on_keypress("cd")<cr>
nnoremap <buffer> <CR> :lua require"tree".on_keypress("edit")<cr>
nnoremap <buffer> <Tab> :lua require"tree".on_keypress("edit")<cr>
nnoremap <buffer> <C-v> :lua require"tree".on_keypress("vsplit")<cr>
nnoremap <buffer> <C-s> :lua require"tree".on_keypress("split")<cr>
nnoremap <buffer> <C-t> :lua require"tree".on_keypress("tabnew")<cr>
nnoremap <buffer> <C-]> :lua require"tree".on_keypress("cd")<cr>
nnoremap <buffer> N :lua require"tree".on_keypress("create")<cr>
nnoremap <buffer> D :lua require"tree".on_keypress("remove")<cr>
nnoremap <buffer> R :lua require"tree".on_keypress("rename")<cr>
nnoremap <buffer> T :lua require"tree".on_keypress("preview")<cr>
nnoremap <buffer> Y :lua require"tree".on_keypress("copy")<cr>
nnoremap <buffer> P :lua require"tree".on_keypress("paste")<cr>
nnoremap <buffer> X :lua require"tree".on_keypress("cut")<cr>
nnoremap <buffer> q :LuaTreeClose
nnoremap <buffer> gx :lua require"tree".xdg_open()<cr>
