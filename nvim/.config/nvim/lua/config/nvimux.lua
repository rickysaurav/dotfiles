local nvimux = require('nvimux')

local M = {}
-- Nvimux configuration
function M.setup()
    nvimux.config.set_all{
        prefix = '<leader>t',
        local_prefix = {
            n = '<leader>t',
            v = '<leader>t',
            i = '<A-Space>t',
            t = '<A-Space>t',
        },
        --TODO:Find a way to wrap lua commands under dein#tap
        new_window = 'enew|term',
        new_window_buffer = 'single',
        quickterm_command='enew|term',
        quickterm_direction = 'botright',
        quickterm_orientation = 'vertical',
        quickterm_scope = 't',
    }

    -- Nvimux custom bindings
    nvimux.bindings.bind_all{
        {'-', ':NvimuxHorizontalSplit', {'n', 'v', 'i', 't'}},
        {'\\|', ':NvimuxVerticalSplit', {'n', 'v', 'i', 't'}},
    }

    -- Required so nvimux sets the mappings correctly
    nvimux.bootstrap()
end
return M
