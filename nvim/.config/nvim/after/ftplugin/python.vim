setlocal makeprg=python\ %:p
lua require "config.iron".attach_to_buffer()
lua require "config.nvim_dap".on_attach()
