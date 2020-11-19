"Toggle stuff
let s:hidden_all = 0

function custom_utils#toggleHiddenAll()
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
