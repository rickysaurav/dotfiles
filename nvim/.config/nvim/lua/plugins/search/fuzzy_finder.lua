local telescope = {
    "nvim-lua/telescope.nvim",
    requires = {
        {"nvim-lua/popup.nvim", opt = true},
        {"nvim-lua/plenary.nvim", opt = true},
        {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
    },
    wants = {"popup.nvim", "plenary.nvim", "telescope-fzy-native.nvim"},
    cmd = {"Telescope"},
    module = {"telescope"},
    setup = function()
        local function get_current_buffer_fuzzy_find_args()
            local finders = require('telescope.finders')
            local previewers = require "telescope.previewers"

            local function get_lines_with_numbers()
                local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                local lines_with_numbers = {}
                for k, v in ipairs(lines) do
                    table.insert(lines_with_numbers, {k, v})
                end
                return lines_with_numbers
            end

            return {
                finder = finders.new_table {
                    results = get_lines_with_numbers(),
                    entry_maker = function(enumerated_line)
                        return {
                            bufnr = vim.api.nvim_get_current_buf(),
                            display = enumerated_line[2],
                            ordinal = enumerated_line[2],
                            path = vim.api.nvim_buf_get_name(0),
                            lnum = enumerated_line[1],
                            text = enumerated_line[2]
                        }
                    end
                },
                previewer = previewers.vim_buffer_vimgrep.new({})
            }
        end

        local source_args = {
            find_files = {
                find_command = {
                    "rg", "-i", "--hidden", "--files", "-g", "!.git"
                }
            },
            current_buffer_fuzzy_find = get_current_buffer_fuzzy_find_args
        }

        local function get_source_args(source)
            local ret = source_args[source] or {}
            if vim.is_callable(ret) then ret = ret() end
            return ret
        end

        function Telescope(source)
            local telescope_source = require("telescope.builtin")[source]
            if (telescope_source == nil) then
                print("Invalid source " .. source)
                telescope_source = require("telescope.builtin")["builtin"]
            end
            require("telescope.builtin")[source](get_source_args(source))
        end
        local utils = require "config.utils"
        -- set_keymap({c = {["<C-R>"] = "<Plug>(TelescopeFuzzyCommandSearch)"}})
        local telescope_keymap = {
            n = {
                bl = "buffers",
                bb = "oldfiles",
                ff = "file_browser",
                fh = "oldfiles",
                fd = "find_files",
                pf = "find_files",
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
        utils.set_keymap(telescope_keymap, utils.leader_key_mapper, function(
            value) return "<Cmd>call v:lua.Telescope('" .. value .. "')" end)
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
