local nvim_dap = {
    "mfussenegger/nvim-dap",
    module = {"dap"},
    setup = function()
        -- vim.cmd [[au FileType dap-repl lua require('dap.ext.autocompl').attach()]]
        local utils = require "config.utils"
        local dap_keymap = {
            n = {
                db = "toggle_breakpoint",
                dc = "continue",
                di = "step_into",
                dn = "step_over",
                dd = "run",
                dq = "stop",
                -- do is a keyword apparently
                ["do"] = "step_out",
                dr = "repl.toggle"
            }
        }
        -- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
        -- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
        utils.set_keymap(dap_keymap, utils.leader_key_mapper, function(value)
            return "<Cmd>lua require 'dap'." .. value .. "()"
        end)
        require("dap")["adapters"] = {
            cpp = {
                type = 'executable',
                name = "cppdbg",
                command = vim.fn.expand(
                    "~/Downloads/extension/debugAdapters/OpenDebugAD7"),
                args = {},
                attach = {pidProperty = "processId", pidSelect = "ask"}
            }
        }
        require("dap")["configurations"] = {
            cpp = {
                {
                    name = "C++ Launch",
                    type = "cpp",
                    request = "launch",
                    program = function()
                        return vim.fn.expand("%:p:r")
                    end,
                    cwd = function()
                        return vim.fn.expand("%:p:h")
                    end,
                    stopAtEntry = true,
                    MIMode = "gdb",
                    setupCommands = {
                        {
                            description = "Enable pretty-printing for gdb",
                            text = "-enable-pretty-printing",
                            ignoreFailures = true
                        }
                    }
                }
            }
        }
    end,
}
-- local nvim_dap_virtual_text = {
--     "theHamsta/nvim-dap-virtual-text",
--     after = {"nvim-dap"},
--     setup = function() vim.g.dap_virtual_text = true end
-- }
-- local nvim_dap_telescope = {
--     "nvim-telescope/telescope-dap.nvim",
--     after = {"nvim-dap", "telescope.nvim"},
--     setup = function()
--         local utils = require "config.utils"
--         local telescope_dap_keymap = {
--             n = {
--                 dlc = "commands",
--                 dls = "configurations",
--                 dlb = "list_breakpoints",
--                 dlv = "variables",
--                 dlf = "frames"
--             }
--         }
--         utils.set_keymap(telescope_dap_keymap, utils.leader_key_mapper,
--                          function(value)
--             return "<Cmd>lua require 'telescope'.extensions.dap." .. value ..
--                        "{}"
--         end)
--     end,
--     config = function() require('telescope').load_extension('dap') end
-- }

-- local nvim_dap_install = {
--     "Pocco81/DAPInstall.nvim",
--     cmd = {"DIInstall", "DIUninstall", "DIList"},
--     ft = {"cpp"},
--     config = function()
--         local dap_install = require("dap-install")
--         dap_install.setup()
--         dap_install.config("ccppr_lldb_dbg", {})
--     end
-- }

local nvim_dap_ui = {
    "rcarriga/nvim-dap-ui",
    wants = {"nvim-dap"},
    module = {"dapui"},
    setup = function()
        local utils = require "config.utils"
        local dap_keymap = {n = {du = "toggle"}}
        -- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
        -- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
        utils.set_keymap(dap_keymap, utils.leader_key_mapper, function(value)
            return "<Cmd>lua require 'dapui'." .. value .. "()"
        end)
    end,
    config = function() require("dapui").setup() end
}
return {nvim_dap, nvim_dap_ui}
-- return {nvim_dap, nvim_dap_virtual_text, nvim_dap_telescope, nvim_dap_install}
