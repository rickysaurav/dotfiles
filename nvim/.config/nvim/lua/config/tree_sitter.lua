local config = require'nvim-treesitter.configs'

local M = {}

function M.setup()
    config.setup {
        highlight = {
            enable = true,                    -- false will disable the whole extension
        },
        incremental_selection = {
            enable = true,
            keymaps = {                       -- mappings for incremental selection (visual mappings)
                init_selection = 'gni',         -- maps in normal mode to init the node/scope selection
                node_incremental = "gnn",       -- increment to the upper named parent
                scope_incremental = "gns",      -- increment to the upper scope (as defined in locals.scm)
                node_decremental = "grp",       -- decrement to the previous node
            }
        },
        refactor = {
            highlight_defintions = {
                enable = true
            },
            smart_rename = {
                enable = true,
                smart_rename = "gR"              -- mapping to rename reference under cursor
            },
            navigation = {
                enable = true,
                goto_definition = "gnd",          -- mapping to go to definition of symbol under cursor
                list_definitions = "gnD"          -- mapping to list all definitions in current file
            }
        },
        ensure_installed = {'lua','c','cpp','json','java','python','bash'} -- one of 'all', 'language', or a list of languages
    }
end

return M
