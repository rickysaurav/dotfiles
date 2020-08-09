setlocal makeprg=g\+\+\ %:p\ -g\ -std\=c\+\+17\ -D\ LOCAL_SYS\ -o\ %:p:r\ &&\ time\ %:p:r
lua require "config.nvim_dap".on_attach()
