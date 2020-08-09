local api = vim.api
local M = {}

-- Nvimux configuration
local keymap = {
    n = {
            [ "rs" ]    = "<Plug>(iron-send-motion)",
            [ "rr" ]    = "<Plug>(iron-repeat-cmd)",
            [ "rl" ]    = "<Plug>(iron-send-lines)",
            [ "rt" ]    = ":IronRepl<CR>",
            [ "r<CR>" ] = "<Plug>(iron-cr)",
            [ "ri" ]    = "<Plug>(iron-interrupt)",
            [ "rq" ]    = "<Plug>(iron-exit)",
            [ "rc" ]    = "<Plug>(iron-clear)",
            [ "rR" ]    = ":IronRestart<CR>",
        },
        v = {
            [ "rs" ] = "<Plug>(iron-visual-send)"
        }
}

function M.attach_to_buffer()
    for mode,map in pairs(keymap) do
        for k,v in pairs(map) do
            api.nvim_buf_set_keymap(0, mode ,'<leader>'..k, v,{})
        end
    end
end

function M.setup()
    local iron = require("iron")
    local view = require("iron.view")
    iron.core.set_config {
        preferred = {
            python = "ipython",
        },
        repl_open_cmd = function (buff)
            local lines = vim.o.lines
            local columns = vim.o.columns
            local command = (columns>lines*2.5) and 'botright vertical '..(columns*0.4)..' split' or 'botright '..(lines*0.4)..' split'
            return view.openwin(command,buff)
        end
    }
end
return M
