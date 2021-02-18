local telescope = {
    "nvim-lua/telescope.nvim",
    requires = {
        {"nvim-lua/popup.nvim", opt = true},
        {"nvim-lua/plenary.nvim", opt = true},
        {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
    },
    cmd = {"Telescope"},
    setup = function()
        require("packer.load")({
            "plenary.nvim", "popup.nvim", "telescope-fzy-native.nvim"
        }, {}, _G.packer_plugins)
        local utils = require "config.utils"
        -- set_keymap({c = {["<C-R>"] = "<Plug>(TelescopeFuzzyCommandSearch)"}})
        local telescope_keymap = {
            n = {
                bl = "buffers",
                bb = "oldfiles",
                fh = "oldfiles",
                fd = "find_files files find_command=rg,-i,--hidden,--files,-g,!.git",
                pf = "find_files find_command=rg,-i,--hidden,--files,-g,!.git",
                ps = "live_grep",
                hh = "help_tags",
                ss = "current_buffer_fuzzy_find",
                so = "treesitter",
                sM = "marks",
                sm = "maps",
                sq = "quickfix",
                sl = "loclist",
                lc = "command_history",
                lh = "command_history",
                lx = "commands",
                ll = "builtin"
            }
        }
        utils.set_keymap(telescope_keymap, utils.leader_key_mapper,
                         function(value)
            return "<Cmd>Telescope " .. value
        end)
    end,
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup {
            defaults = {
                vimgrep_arguments = {
                    "rg", "--color=never", "--no-heading", "--with-filename",
                    "--line-number", "--column", "--smart-case", "--hidden",
                    "-g", "!.git"
                },
                mappings = {
                    i = {
                        ["<C-y>"] = function()
                            local current_entry =
                                actions.get_selected_entry().value
                            vim.call("setreg", {"+", current_entry})
                        end
                    }
                }
            }
        }
        require("telescope").load_extension("fzy_native")
    end
}
return {telescope}
