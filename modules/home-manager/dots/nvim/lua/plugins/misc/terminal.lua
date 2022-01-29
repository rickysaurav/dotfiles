local nvimux = {
    "Vigemus/nvimux",
    cmd = {"NvimuxVerticalSplit", "NvimuxHorizontalSplit", "NvimuxToggleTerm"},
    keys = {"<leader>t"},
    config = function()
        local nvimux = require("nvimux")
        nvimux.setup{
          config = {
            prefix = "<leader>t",
            new_window = "term",
            quickterm_scope = "t"
          },
          bindings = {
            {{"n", "v", "i", "t"}, "-", nvimux.commands.horizontal_split},
            {{"n", "v", "i", "t"}, "\\|", nvimux.commands.vertical_split},
          }
        }
    end
}

local iron_repl = {
    "Vigemus/iron.nvim",
    cmd = {
        "IronRepl", "IronReplHere", "IronRestart", "IronSend", "IronFocus",
        "IronWatchCurrentFile", "IronUnwatchCurrentFile"
    },
    keys = {"<Plug>(iron"},
    setup = function()
        local utils = require "config.utils"
        vim.g.iron_map_defaults = 0
        vim.g.iron_map_extended = 0
        local keymap = {
            n = {
                ["rs"] = "<Plug>(iron-send-motion)",
                ["rr"] = "<Plug>(iron-repeat-cmd)",
                ["rl"] = "<Plug>(iron-send-lines)",
                ["rt"] = "<Cmd>IronRepl<CR>",
                ["r<CR>"] = "<Plug>(iron-cr)",
                ["ri"] = "<Plug>(iron-interrupt)",
                ["rq"] = "<Plug>(iron-exit)",
                ["rc"] = "<Plug>(iron-clear)",
                ["rR"] = "<Cmd>IronRestart<CR>"
            },
            v = {["rs"] = "<Plug>(iron-visual-send)"}
        }
        function IronAttachBuffer()
            utils.set_buf_keymap(keymap, utils.leader_key_mapper, nil, false, {})
        end
        function IronSetupRepl(fts)
            fts = fts or
                      {"python", "lua", "zsh", "sh", "javascript", "typescript"}
            vim.cmd [[augroup IronRepl]]
            vim.cmd [[autocmd!]]
            for _, value in ipairs(fts) do
                vim.cmd(string.format(
                            [[autocmd FileType %s call v:lua.IronAttachBuffer()]],
                            value))
            end
            vim.cmd [[augroup END]]
        end
        IronSetupRepl()
    end,
    config = function()
        local iron = require("iron")
        local view = require("iron.view")
        local fts = require "iron.fts"
        IronSetupRepl(vim.tbl_keys(fts))
        iron.core.set_config {
            preferred = {python = "ipython"},
            repl_open_cmd = function(buff)
                local lines = vim.o.lines
                local columns = vim.o.columns
                local command =
                    (columns > lines * 2.5) and "botright vertical " ..
                        (columns * 0.4) .. " split" or "botright " ..
                        (lines * 0.4) .. " split"
                return view.openwin(command, buff)
            end
        }
    end
}
return {nvimux, iron_repl}
