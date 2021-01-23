setlocal signcolumn=no
nnoremap <buffer> <2-LeftMouse> :lua require"nvim-tree".on_keypress("edit")<cr>
nnoremap <buffer> <2-RightMouse> :lua require"nvim-tree".on_keypress("cd")<cr>
nnoremap <buffer> <CR> :lua require"nvim-tree".on_keypress("edit")<cr>
nnoremap <buffer> <Tab> :lua require"nvim-tree".on_keypress("edit")<cr>
nnoremap <buffer> <C-v> :lua require"nvim-tree".on_keypress("vsplit")<cr>
nnoremap <buffer> <C-s> :lua require"nvim-tree".on_keypress("split")<cr>
nnoremap <buffer> <C-t> :lua require"nvim-tree".on_keypress("tabnew")<cr>
nnoremap <buffer> <C-]> :lua require"nvim-tree".on_keypress("cd")<cr>
nnoremap <buffer> N :lua require"nvim-tree".on_keypress("create")<cr>
nnoremap <buffer> D :lua require"nvim-tree".on_keypress("remove")<cr>
nnoremap <buffer> R :lua require"nvim-tree".on_keypress("rename")<cr>
nnoremap <buffer> T :lua require"nvim-tree".on_keypress("preview")<cr>
nnoremap <buffer> Y :lua require"nvim-tree".on_keypress("copy")<cr>
nnoremap <buffer> P :lua require"nvim-tree".on_keypress("paste")<cr>
nnoremap <buffer> X :lua require"nvim-tree".on_keypress("cut")<cr>
nnoremap <buffer> q :NvimTreeClose
nnoremap <buffer> gx :lua require"nvim-tree".xdg_open()<cr>
