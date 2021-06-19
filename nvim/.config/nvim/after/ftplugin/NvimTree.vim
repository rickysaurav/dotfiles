setlocal signcolumn=no
nnoremap <buffer> <2-LeftMouse> <cmd>lua require"nvim-tree".on_keypress("edit")<cr>
nnoremap <buffer> <2-RightMouse> <cmd>lua require"nvim-tree".on_keypress("cd")<cr>
nnoremap <buffer> <CR> <cmd>lua require"nvim-tree".on_keypress("edit")<cr>
nnoremap <buffer> <Tab> <cmd>lua require"nvim-tree".on_keypress("edit")<cr>
nnoremap <buffer> <C-v> <cmd>lua require"nvim-tree".on_keypress("vsplit")<cr>
nnoremap <buffer> <C-s> <cmd>lua require"nvim-tree".on_keypress("split")<cr>
nnoremap <buffer> <C-t> <cmd>lua require"nvim-tree".on_keypress("tabnew")<cr>
nnoremap <buffer> <C-]> <cmd>lua require"nvim-tree".on_keypress("cd")<cr>
nnoremap <buffer> N <cmd>lua require"nvim-tree".on_keypress("create")<cr>
nnoremap <buffer> D <cmd>lua require"nvim-tree".on_keypress("remove")<cr>
nnoremap <buffer> R <cmd>lua require"nvim-tree".on_keypress("rename")<cr>
nnoremap <buffer> T <cmd>lua require"nvim-tree".on_keypress("preview")<cr>
nnoremap <buffer> Y <cmd>lua require"nvim-tree".on_keypress("copy")<cr>
nnoremap <buffer> P <cmd>lua require"nvim-tree".on_keypress("paste")<cr>
nnoremap <buffer> X <cmd>lua require"nvim-tree".on_keypress("cut")<cr>
nnoremap <buffer> q <cmd>NvimTreeClose
nnoremap <buffer> gx <cmd>lua require"nvim-tree".xdg_open()<cr>
