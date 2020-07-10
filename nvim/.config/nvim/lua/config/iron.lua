local M = {}
-- Nvimux configuration
function M.setup()
    local iron = require('iron')
    iron.core.set_config {
        preferred = {
            python = "ipython",
        },
        repl_open_cmd = function(buff) vim.api.nvim_command('botright vertical 100 split' .. '| ' .. buff .. ' | set wfw') end
    }
end
return M
