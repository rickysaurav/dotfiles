setlocal makeprg=python\ %:p
lua require "config.iron".attach_to_buffer()
