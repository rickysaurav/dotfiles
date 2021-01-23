local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
    if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
        return
    end

    local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

    vim.fn.mkdir(directory, "p")

    local out =
        vim.fn.system(
        string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
    )

    print(out)
    print("Downloading packer.nvim...")

    return
end

vim.cmd [[packadd packer.nvim]]

local packer = require("packer")

packer.startup(
    function(use)
        --missing --
        --tmuxline,which-key,luadev,asyncrun,asynctasks,markdown-preview
        -- Packer can manage itself as an optional plugin
        use {"wbthomason/packer.nvim", opt = true}
        -- Colorschemes
        use {

            "Th3Whit3Wolf/one-nvim",
            branch = "main",
            event = {"FocusLost *", "CursorHold *"},
            config = function()
                vim.cmd [[colorscheme one-nvim]]
            end
        }
        -- SSH Clipboard
        use {
            "ojroques/vim-oscyank",
            event = {"TextYankPost *"},
            config = function()
                if (vim.env.SSH_CLIENT or vim.env.SSH_TTY) then
                    vim.cmd [[augroup IronRepl]]
                    vim.cmd [[autocmd!]]
                    vim.cmd("autocmd TextYankPost * OSCYankReg +<CR>")
                    vim.cmd("OSCYankReg +")
                    vim.cmd [[augroup END]]
                end
            end
        }
        -- UI
        use {
            "glepnir/indent-guides.nvim",
            setup = function()
                vim.defer_fn(
                    function()
                        vim.cmd("doautocmd User LoadIndentGuides")
                    end,
                    1000
                )
            end,
            event = {"User LoadIndentGuides"},
            config = function()
                require("indent_guides").setup(
                    {
                        indent_tab_guides = true
                    }
                )
                vim.cmd("IndentGuidesEnable")
            end
        }
        use {
            "norcalli/nvim-colorizer.lua",
            cmd = {
                "ColorizerDetachFromBuffer",
                "ColorizerReloadAllBuffers",
                "ColorizerToggle",
                "ColorizerAttachToBuffer"
            },
            config = function()
                require "colorizer".setup()
            end
        }
        use {
            "glepnir/galaxyline.nvim",
            branch = "main",
            event = {"FocusLost *", "CursorHold *"},
            -- some optional icons
            requires = {{"kyazdani42/nvim-web-devicons", opt = true}},
            -- your statusline
            config = function()
                require("packer.load")({"nvim-web-devicons"}, {},_G.packer_plugins)
                local gl = require("galaxyline")
                local gls = gl.section
                gl.short_line_list = {"NvimTree", "vista", "dbui"}
                local function is_treesitter_active()
                    return pcall(vim.treesitter.get_parser)
                end
                local function is_lsp_active()
                    return #vim.lsp.buf_get_clients() > 0
                end
                local colors = {
                    bg = "#282c34",
                    line_bg = "#21242b",
                    fg = "#c0c0c0",
                    yellow = "#fabd2f",
                    cyan = "#008080",
                    darkblue = "#081633",
                    green = "#afd700",
                    orange = "#FF8800",
                    purple = "#5d4d7a",
                    magenta = "#c678dd",
                    blue = "#51afef",
                    red = "#ec5f67",
                    pink = "#e4a1b2",
                    lavender = "#bda3e7"
                }

                local buffer_not_empty = function()
                    if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
                        return true
                    end
                    return false
                end

                local function find_git_root()
                    local path = vim.fn.expand("%:p:h")
                    local get_git_dir = require("galaxyline.provider_vcs").get_git_dir
                    return get_git_dir(path)
                end
                local checkwidth = function()
                    local squeeze_width = vim.fn.winwidth(0) / 2
                    if squeeze_width > 40 then
                        return true
                    end
                    return false
                end
                local tabpage_icon_map = {"", "", "", "", "", "", "", "", ""}
                gls.left = {
                    {
                        FirstElement = {
                            provider = function()
                                return "▊ "
                            end,
                            highlight = {colors.blue, colors.line_bg}
                        }
                    },
                    {
                        ViMode = {
                            provider = function()
                                -- auto change color according the vim mode
                                local mode_color = {
                                    n = colors.magenta,
                                    i = colors.green,
                                    v = colors.blue,
                                    [""] = colors.blue,
                                    V = colors.blue,
                                    c = colors.red,
                                    no = colors.magenta,
                                    s = colors.orange,
                                    S = colors.orange,
                                    [""] = colors.orange,
                                    ic = colors.yellow,
                                    R = colors.purple,
                                    Rv = colors.purple,
                                    cv = colors.red,
                                    ce = colors.red,
                                    r = colors.cyan,
                                    rm = colors.cyan,
                                    ["r?"] = colors.cyan,
                                    ["!"] = colors.red,
                                    t = colors.red
                                }
                                vim.cmd("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
                                return "  "
                            end,
                            highlight = {colors.red, colors.line_bg, "bold"}
                        }
                    },
                    {
                        FileIcon = {
                            provider = "FileIcon",
                            condition = buffer_not_empty,
                            highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.line_bg}
                        }
                    },
                    {
                        FileName = {
                            provider = {"FileName"},
                            condition = buffer_not_empty,
                            highlight = {colors.pink, colors.line_bg, "bold"}
                        }
                    },
                    {
                        CurrentFunctionIcon = {
                            provider = function()
                                return "  "
                            end,
                            condition = is_lsp_active,
                            highlight = {colors.blue, colors.line_bg}
                        }
                    },
                    {
                        CurrentFunction = {
                            provider = function()
                                return vim.b.lsp_current_function or ""
                            end,
                            condition = is_lsp_active,
                            highlight = {colors.pink, colors.line_bg}
                        }
                    },
                    {
                        LeftEnd = {
                            provider = function()
                                return ""
                            end,
                            separator = "",
                            separator_highlight = {colors.bg, colors.line_bg},
                            highlight = {colors.line_bg, colors.line_bg}
                        }
                    },
                    {
                        DiagnosticError = {
                            provider = "DiagnosticError",
                            icon = "  ",
                            highlight = {colors.red, colors.bg}
                        }
                    },
                    {
                        Space = {
                            provider = function()
                                return " "
                            end
                        }
                    },
                    {
                        DiagnosticWarn = {
                            provider = "DiagnosticWarn",
                            icon = "  ",
                            highlight = {colors.blue, colors.bg}
                        }
                    },
                    {
                        TreeSitterIcon = {
                            provider = function()
                                return " פּ "
                            end,
                            condition = is_treesitter_active,
                            highlight = {colors.blue, colors.bg}
                        }
                    },
                    {
                        TreeSitter = {
                            provider = function()
                                return require "nvim-treesitter".statusline(30)
                            end,
                            condition = is_treesitter_active,
                            highlight = {colors.lavender, colors.bg}
                        }
                    }
                }
                gls.right = {
                    {
                        FileFormat = {
                            provider = "FileFormat",
                            separator = " ",
                            separator_highlight = {colors.bg, colors.line_bg},
                            highlight = {colors.pink, colors.line_bg}
                        }
                    },
                    {
                        GitIcon = {
                            provider = function()
                                return " "
                            end,
                            separator = " ",
                            condition = find_git_root,
                            separator_highlight = {colors.blue, colors.line_bg},
                            highlight = {colors.blue, colors.line_bg}
                        }
                    },
                    {
                        GitBranch = {
                            provider = "GitBranch",
                            condition = find_git_root,
                            highlight = {colors.lavender, colors.line_bg, "bold"}
                        }
                    },
                    {
                        DiffAdd = {
                            provider = "DiffAdd",
                            condition = checkwidth,
                            icon = " ",
                            highlight = {colors.green, colors.line_bg}
                        }
                    },
                    {
                        DiffModified = {
                            provider = "DiffModified",
                            condition = checkwidth,
                            icon = " ",
                            highlight = {colors.orange, colors.line_bg}
                        }
                    },
                    {
                        DiffRemove = {
                            provider = "DiffRemove",
                            condition = checkwidth,
                            icon = " ",
                            highlight = {colors.red, colors.line_bg}
                        }
                    },
                    {
                        LineInfo = {
                            provider = "LineColumn",
                            separator = "| ",
                            separator_highlight = {colors.blue, colors.line_bg},
                            highlight = {colors.pink, colors.line_bg}
                        }
                    },
                    {
                        Time = {
                            provider = function()
                                return vim.fn.strftime("%H:%M") .. " "
                            end,
                            icon = "  ",
                            separator = " ",
                            separator_highlight = {colors.line_bg, colors.line_bg},
                            highlight = {colors.lavender, colors.darkblue}
                        }
                    },
                    {
                        TabPageIcon = {
                            provider = function()
                                return (tabpage_icon_map[vim.api.nvim_tabpage_get_number(0)] or "") .. " "
                            end,
                            separator = " ",
                            separator_highlight = {colors.blue, colors.purple},
                            highlight = {colors.blue, colors.purple}
                        }
                    }
                    --{
                    --ScrollBar = {
                    --provider = "ScrollBar",
                    --highlight = {colors.blue, colors.purple}
                    --}
                    --}
                }
                gls.short_line_left = {
                    {
                        BufferType = {
                            provider = "FileTypeName",
                            separator = "",
                            separator_highlight = {colors.purple, colors.bg},
                            highlight = {colors.fg, colors.purple}
                        }
                    }
                }

                gls.short_line_right = {
                    {
                        BufferIcon = {
                            provider = "BufferIcon",
                            separator = "",
                            separator_highlight = {colors.purple, colors.bg},
                            highlight = {colors.fg, colors.purple}
                        }
                    }
                }
                vim.cmd [[doautocmd galaxyline BufEnter]]
            end
        }
        -- Profiling
        use {
            "dstein64/vim-startuptime",
            cmd = {"StartupTime"}
        }
        -- Window resizing
        use {
            "dm1try/golden_size",
            event = {"WinEnter *"},
            config = function()
                local golden_size = require("golden_size")

                vim.api.nvim_set_var("golden_size_off", 0)

                local ignored_buftypes = {quickfix = true}
                local ignored_filetypes = {NvimTree = true}

                local function ignore_by_buftype()
                    local buftype = vim.bo.buftype
                    return ignored_buftypes[buftype] and 1 or nil
                end

                local function ignore_by_filetype()
                    local filetype = vim.bo.filetype
                    return ignored_filetypes[filetype] and 1 or nil
                end

                function GoldenSizeToggle()
                    local current_value = vim.api.nvim_get_var("golden_size_off") or 0
                    vim.api.nvim_set_var("golden_size_off", current_value == 1 and 0 or 1)
                end

                local function golden_size_ignore()
                    return vim.api.nvim_get_var("golden_size_off")
                end
                -- set the callbacks, preserve the defaults
                golden_size.set_ignore_callbacks(
                    {
                        {golden_size_ignore},
                        {ignore_by_buftype},
                        {ignore_by_filetype},
                        {golden_size.ignore_float_windows}, -- default one, ignore float windows
                        {golden_size.ignore_by_window_flag} -- default one, ignore windows with w:ignore_gold_size=1
                    }
                )
            end
        }
        use {
            "liuchengxu/vim-clap",
            cmd = {"Clap"},
            run = function()
                vim.cmd [[Clap install-binary!]]
            end,
            setup = function()
                local utils = require "config.utils"
                vim.g.clap_provider_grep_opts = "-H --no-heading --vimgrep --smart-case --hidden"
                local clap_keymap = {
                    n = {
                        ff = "filer",
                        sj = "jumps",
                        se = "lines",
                        yy = "yanks",
                        ["w/"] = "windows"
                    }
                }
                utils.set_keymap(
                    clap_keymap,
                    utils.leader_key_mapper,
                    function(value)
                        return "<Cmd>Clap " .. value
                    end
                )
            end,
            config = function()
                vim.cmd [[doautocmd ClapYanks VimEnter]]
            end
        }
        use {
            "nvim-lua/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim", opt = true},
                {"nvim-lua/plenary.nvim", opt = true},
                {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
            },
            cmd = {"Telescope"},
            setup = function()
                require("packer.load")({"plenary.nvim", "popup.nvim", "telescope-fzy-native.nvim"}, {},_G.packer_plugins)
                local utils = require "config.utils"
                --set_keymap({c = {["<C-R>"] = "<Plug>(TelescopeFuzzyCommandSearch)"}})
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
                utils.set_keymap(
                    telescope_keymap,
                    utils.leader_key_mapper,
                    function(value)
                        return "<Cmd>Telescope " .. value
                    end
                )
            end,
            config = function()
                local actions = require("telescope.actions")
                require("telescope").setup {
                    defaults = {
                        vimgrep_arguments = {
                            "rg",
                            "--color=never",
                            "--no-heading",
                            "--with-filename",
                            "--line-number",
                            "--column",
                            "--smart-case",
                            "--hidden",
                            "-g",
                            "!.git"
                        },
                        mappings = {
                            i = {
                                ["<C-y>"] = function()
                                    local current_entry = actions.get_selected_entry().value
                                    vim.call("setreg", {"+", current_entry})
                                end
                            }
                        }
                    }
                }
                require("telescope").load_extension("fzy_native")
            end
        }
        -- file explorer
        use {
            "kyazdani42/nvim-tree.lua",
            requires = {{"kyazdani42/nvim-web-devicons", opt = true}},
            cmd = {"NvimTreeToggle", "NvimTreeOpen"},
            setup = function()
                vim.g.nvim_tree_follow = 1
                vim.g.nvim_tree_disable_keybindings = 1
                vim.g.nvim_tree_icons = {default = ""}
                vim.g.nvim_tree_git_hl = 1
                local utils = require "config.utils"
                utils.set_keymap({n = {x = "<Cmd>NvimTreeToggle"}}, utils.leader_key_mapper)
            end,
            config = function()
                require("packer.load")({"nvim-web-devicons"}, {},_G.packer_plugins)
            end
        }
        --git
        use {
            "tpope/vim-fugitive",
            cmd = {"Git", "Gstatus", "Gwrite", "Glog", "Gcommit", "Gblame", "Ggrep", "Gdiff", "G"}
        }
        use {
            "f-person/git-blame.nvim",
            cmd = {"GitBlameToggle", "GitBlameEnable", "GitBlameDisable"},
            setup = function()
                -- adjust correct inital state for gitblame enabled
                -- this allows GitBlameToggle enable plugin when lazily loaded
                -- else when lazily loaded the plugin is activated when GitBlameToggle is called
                -- and then the GitBlameToggle disables it
                vim.g.gitblame_enabled = 0
            end
        }
        use {
            "lewis6991/gitsigns.nvim",
            cmd = {"GitSignsEnable"},
            config = function()
                require('gitsigns').setup()
                vim.cmd [[ doautocmd BufEnter ]]
            end
        }
        --syntax
        use {
            "sheerun/vim-polyglot",
            event = {"FocusLost *", "CursorHold *"}
        }
        use {
            "nvim-treesitter/nvim-treesitter",
            cmd = {"TSInstall", "TSBufEnable", "TSEnableAll", "TSModuleInfo", "TSUpdate"},
            ft = {"cpp", "c", "python", "java", "lua", "json", "markdown", "typescript", "bash", "zsh"},
            run = function()
                vim.cmd("TSUpdate")
            end,
            config = function()
                require "nvim-treesitter.configs".setup {
                    highlight = {
                        enable = true -- false will disable the whole extension
                    },
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            -- mappings for incremental selection (visual mappings)
                            init_selection = "gni", -- maps in normal mode to init the node/scope selection
                            node_incremental = "gnn", -- increment to the upper named parent
                            scope_incremental = "gns", -- increment to the upper scope (as defined in locals.scm)
                            node_decremental = "gnp" -- decrement to the previous node
                        }
                    },
                    refactor = {
                        highlight_definitions = {
                            enable = true
                        },
                        --highlight_current_scope = {
                        --enable = true
                        --},
                        smart_rename = {
                            enable = true,
                            keymaps = {
                                smart_rename = "gnr" -- mapping to rename reference under cursor
                            }
                        },
                        navigation = {
                            enable = true,
                            keymaps = {
                                goto_definition = "gnd", -- mapping to go to definition of symbol under cursor
                                list_definitions = "gnD" -- mapping to list all definitions in current file
                            }
                        }
                    },
                    textobjects = {
                        -- syntax-aware textobjects
                        select = {
                            enable = true,
                            disable = {},
                            keymaps = {
                                ["iL"] = {
                                    -- you can define your own textobjects directly here
                                    python = "(function_definition) @function",
                                    cpp = "(function_definition) @function",
                                    c = "(function_definition) @function",
                                    java = "(method_declaration) @function"
                                },
                                -- or you use the queries from supported languages with textobjects.scm
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["aC"] = "@class.outer",
                                ["iC"] = "@class.inner",
                                ["ac"] = "@conditional.outer",
                                ["ic"] = "@conditional.inner",
                                ["ab"] = "@block.outer",
                                ["ib"] = "@block.inner",
                                ["al"] = "@loop.outer",
                                ["il"] = "@loop.inner",
                                ["is"] = "@statement.inner",
                                ["as"] = "@statement.outer",
                                ["ad"] = "@comment.outer",
                                ["am"] = "@call.outer",
                                ["im"] = "@call.inner"
                            }
                        },
                        -- swap parameters (keymap -> textobject query)
                        swap = {
                            enable = true,
                            swap_next = {
                                ["<leader>N"] = "@parameter.inner"
                            },
                            swap_previous = {
                                ["<leader>P"] = "@parameter.inner"
                            }
                        },
                        -- set mappings to go to start/end of adjacent textobjects (keymap -> textobject query)
                        move = {
                            enable = true,
                            goto_previous_start = {
                                ["[m"] = "@function.outer",
                                ["[["] = "@class.outer"
                            },
                            goto_previous_end = {
                                ["[M"] = "@function.outer",
                                ["[]"] = "@class.outer"
                            },
                            goto_next_start = {
                                ["]m"] = "@function.outer",
                                ["]]"] = "@class.outer"
                            },
                            goto_next_end = {
                                ["]M"] = "@function.outer",
                                ["]["] = "@class.outer"
                            }
                        }
                    },
                    ensure_installed = {"lua", "c", "cpp", "json", "java", "python", "bash", "typescript"} -- one of 'all', 'language', or a list of languages
                }
            end
        }
        use {
            "nvim-treesitter/nvim-treesitter-refactor",
            after = {"nvim-treesitter"}
        }
        use {
            "nvim-treesitter/nvim-treesitter-textobjects",
            after = {"nvim-treesitter"}
        }
        --utils
        use {
            "preservim/nerdcommenter",
            keys = {"<Plug>(nerdcommenter","<leader>c"}
        }
        use {
            "tpope/vim-surround",
            keys = {{"n", "cs"}, {"n", "ds"}, {"n", "ys"}, {"x", "S"}}
        }
        use {
            "tpope/vim-repeat",
            keys = {"."}
        }
        use {
            "cohama/lexima.vim",
            --TODO: Fix double quote autoloading
            keys = {{"i", "("}, {"i", "["}, {"i", "<"}, {"i", "'"}, {"i", "{"},{"i",'"'}},
            config = function()
                vim.cmd [[doautocmd lexima-init InsertEnter]]
                vim.cmd [[doautocmd lexima InsertEnter]]
            end
        }
        -- Terminal UI
        use {
            "Vigemus/nvimux",
            cmd = {"NvimuxVerticalSplit", "NvimuxHorizontalSplit", "NvimuxToggleTerm"},
            keys = {"<leader>t"},
            config = function()
                local nvimux = require("nvimux")
                nvimux.config.set_all {
                    prefix = "<leader>t",
                    local_prefix = {
                        n = "<leader>t",
                        v = "<leader>t",
                        i = "<A-Space>t",
                        t = "<A-Space>t"
                    },
                    new_window = "term",
                    quickterm_scope = "t"
                }

                -- Nvimux custom bindings
                nvimux.bindings.bind_all {
                    {"-", "<Cmd>NvimuxHorizontalSplit<CR>", {"n", "v", "i", "t"}},
                    {"\\|", "<Cmd>NvimuxVerticalSplit<CR>", {"n", "v", "i", "t"}}
                }

                -- Required so nvimux sets the mappings correctly
                nvimux.bootstrap()
            end
        }

        use {
            "Vigemus/iron.nvim",
            cmd = {
                "IronRepl",
                "IronReplHere",
                "IronRestart",
                "IronSend",
                "IronFocus",
                "IronWatchCurrentFile",
                "IronUnwatchCurrentFile"
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
                    v = {
                        ["rs"] = "<Plug>(iron-visual-send)"
                    }
                }
                function IronAttachBuffer()
                    utils.set_buf_keymap(keymap, utils.leader_key_mapper, nil, false, {})
                end
                function IronSetupRepl(fts)
                    fts = fts or {"python", "lua", "zsh", "sh", "javascript", "typescript"}
                    vim.cmd [[augroup IronRepl]]
                    vim.cmd [[autocmd!]]
                    for _, value in ipairs(fts) do
                        vim.cmd(string.format([[autocmd FileType %s call v:lua.IronAttachBuffer()]], value))
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
                    preferred = {
                        python = "ipython"
                    },
                    repl_open_cmd = function(buff)
                        local lines = vim.o.lines
                        local columns = vim.o.columns
                        local command =
                            (columns > lines * 2.5) and "botright vertical " .. (columns * 0.4) .. " split" or
                            "botright " .. (lines * 0.4) .. " split"
                        return view.openwin(command, buff)
                    end
                }
            end
        }
        -- navigation
        use {
            "easymotion/vim-easymotion",
            keys = {"<Plug>(easymotion"},
            setup = function()
                local utils = require "config.utils"
                local easymotion_keymap = {
                    n = {
                        ["<leader>m"] = "<Plug>(easymotion_prefix)",
                        ["/"] = "<Plug>(easymotion-sn)"
                    },
                    o = {
                        ["/"] = "<Plug>(easymotion-tn)"
                    }
                }
                vim.g.EasyMotion_smartcase = 1
                utils.set_keymap(easymotion_keymap, nil, nil, false)
            end
        }

        --lsp
        use {
            "rickysaurav/nvim-lsp",
            ft = {"cpp", "c", "python", "lua", "vim", "json", "typescript", "rust", "yaml"},
            requires = {
                {"nvim-lua/lsp-status.nvim", opt = true}
            },
            config = function()
                require("packer.load")({"lsp-status.nvim"}, {},_G.packer_plugins)
                local api = vim.api
                local luv = vim.loop
                local lsp = vim.lsp
                local lspconfig = require "lspconfig"
                local lsp_status = require "lsp-status"
                lsp_status.config({status_symbol = ""})
                lsp_status.register_progress()

                local lsp_keymap = {
                    n = {
                        ["<c-]>"] = "vim.lsp.buf.definition()",
                        ["gd"] = "vim.lsp.buf.definition()",
                        ["gi"] = "vim.lsp.buf.implementation()",
                        ["gD"] = "vim.lsp.buf.declaration()",
                        ["gI"] = "vim.lsp.buf.type_definition()",
                        ["gr"] = "vim.lsp.buf.references()",
                        ["g0"] = "vim.lsp.buf.document_symbol()",
                        ["gW"] = "vim.lsp.buf.workspace_symbol()",
                        ["K"] = "vim.lsp.buf.hover()",
                        ["<c-k>"] = "vim.lsp.buf.signature_help()",
                        ["<leader>lR"] = "vim.lsp.buf.rename()",
                        ["<leader>lf"] = "vim.lsp.buf.range_formatting()",
                        ["<leader>lF"] = "vim.lsp.buf.formatting()",
                        ["<leader>l."] = "vim.lsp.buf.code_action()",
                        ["<leader>el"] = "vim.lsp.diagnostic.set_loclist()",
                        ["<leader>en"] = "vim.lsp.diagnostic.goto_next({wrap=true, severity_limit = 'Error'})",
                        ["<leader>ep"] = "vim.lsp.diagnostic.goto_prev({wrap=true, severity_limit = 'Error'})"
                    },
                    v = {
                        ["<leader>lf"] = "vim.lsp.buf.range_formatting()"
                    },
                    i = {
                        ["<c-k>"] = "vim.lsp.buf.signature_help()"
                    }
                }

                local telescope_keymap = {
                    n = {
                        ["lw"] = "lsp_document_symbols",
                        ["lW"] = "lsp_workspace_symbols",
                        ["l."] = "lsp_code_actions",
                        ["lr"] = "lsp_references"
                    }
                }
                function AttachFunctionsLSP(client)
                    local utils = require "config.utils"
                    utils.set_buf_keymap(
                        lsp_keymap,
                        nil,
                        function(value)
                            return "<Cmd>lua " .. value
                        end
                    )
                    utils.set_buf_keymap(
                        telescope_keymap,
                        utils.leader_key_mapper,
                        function(value)
                            return "<Cmd>Telescope " .. value
                        end
                    )
                    lsp_status.on_attach(client)
                end

                local function root_function_generator(root_patterns)
                    return function(fname)
                        return lspconfig.util.find_git_ancestor(fname) or
                            lspconfig.util.root_pattern(root_patterns)(fname) or
                            vim.call("getcwd") or
                            luv.os_homedir()
                    end
                end

                local function get_client_capabilities()
                    local capabilities = lsp_status.capabilities
                    if vim.g.completion_enable_snippet then
                        capabilities.textDocument.completion.completionItem.snippetSupport = true
                    end
                    return capabilities
                end

                local base_config = {
                    log_level = lsp.protocol.MessageType.Log,
                    message_level = lsp.protocol.MessageType.Log,
                    on_attach = AttachFunctionsLSP,
                    capabilities = get_client_capabilities()
                }
                local server_configs = {
                    jsonls = {
                        init_options = {
                            provideFormatter = true
                        }
                    },
                    yamlls = {
                        settings = {
                            yaml = {
                                format = {
                                    enable = true
                                }
                            }
                        }
                    },
                    pyls_ms = {
                        root_patterns = {"Pipfile", "poetry.toml", "setup.py", "requirements.txt"},
                        handlers = lsp_status.extensions.pyls_ms.setup(),
                        settings = {
                            python = {
                                workspaceSymbols = {enabled = true},
                                analysis = {memory = {keepLibraryAst = true, keepLibraryLocalVariables = true}}
                            }
                        }
                    },
                    pyright_ls = {
                        root_patterns = {"Pipfile", "poetry.toml", "setup.py", "requirements.txt"},
                        handlers = {
                            -- pyright ignores dynamicRegistration settings
                            ["client/registerCapability"] = function(_, _, _, _)
                                return {
                                    result = nil,
                                    error = nil
                                }
                            end
                        },
                        settings = {
                            python = {
                                analysis = {autoSearchPaths = true},
                                pyright = {useLibraryCodeForTypes = true}
                            }
                        }
                    },
                    clangd = {
                        root_patterns = {"compile_commands.json", ".ccls", "compile_flags.txt"},
                        handlers = lsp_status.extensions.clangd.setup(),
                        cmd = {"clangd"},
                        args = {"--background-index", "-header-insertion=never", "--clang-tidy", "--cross-file-rename"},
                        init_options = {
                            clangdFileStatus = true
                        }
                    },
                    rust_analyzer = {
                        root_patterns = {"Cargo.toml", "rust-project.json"}
                    },
                    sumneko_lua = {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = {
                                        "vim",
                                    }
                                },
                                runtime = {
                                    version = "LuaJIT",
                                    path = {
                                        {
                                            "?.lua",
                                            "?/init.lua",
                                            "?/?.lua",
                                            vim.env.VIMRUNTIME .. "/lua/?.lua"
                                        }
                                    }
                                }
                            }
                        }
                    },
                    efm = {
                        filetypes = {"lua", "markdown"}
                    }
                }

                local function ensure_installed(servers)
                    for _, server in ipairs(servers) do
                        local server_module = lspconfig[server]
                        if server_module then
                            if server_module.install_info then
                                local install_info = server_module.install_info()
                                if not install_info.is_installed then
                                    print(server .. " not installed . Starting installation. ")
                                    api.nvim_command("LspInstall " .. server)
                                end
                            end
                        else
                            error("invalid server name " .. server)
                        end
                    end
                end

                local function setup_server(server)
                    local config = {}
                    for key, value in pairs(base_config) do
                        config[key] = value
                    end
                    local server_config = server_configs[server] or {}
                    for key, value in pairs(server_config) do
                        config[key] = value
                    end
                    config.root_dir = root_function_generator(server_config["root_patterns"] or {})
                    lspconfig[server].setup(config)
                end

                local function setup_servers(servers)
                    for _, server in ipairs(servers) do
                        local server_module = lspconfig[server]
                        if not server_module then
                            error("invalid server name " .. server)
                        end
                        setup_server(server)
                    end
                end
                local function setup_diagnostics()
                    vim.lsp.handlers["textDocument/publishDiagnostics"] =
                        vim.lsp.with(
                        vim.lsp.diagnostic.on_publish_diagnostics,
                        {
                            -- Enable underline, use default values
                            underline = true,
                            -- Enable virtual text, override spacing to 4
                            virtual_text = {
                                spacing = 5
                            },
                            -- Use a function to dynamically turn signs off
                            -- and on, using buffer local variables
                            signs = function(bufnr)
                                local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, "show_signs")
                                -- No buffer local variable set, so just enable by default
                                if not ok then
                                    return true
                                end

                                return result
                            end,
                            -- Disable a feature
                            update_in_insert = false
                        }
                    )
                end
                setup_diagnostics()
                ensure_installed(
                    {"pyright_ls", "vimls", "clangd", "sumneko_lua", "jsonls", "tsserver", "jdtls", "yamlls"}
                )
                setup_servers(
                    {
                        "pyright_ls",
                        "vimls",
                        "clangd",
                        "sumneko_lua",
                        "jsonls",
                        "tsserver",
                        "rust_analyzer",
                        "yamlls",
                        "efm"
                    }
                )
            end
        }
        use {
            "mfussenegger/nvim-jdtls",
            ft = {"java"},
            requires = {{"rickysaurav/nvim-lsp", opt = true}},
            config = function()
                require("packer.load")({"nvim-lsp"}, {},_G.packer_plugins)
                local utils = require "config.utils"
                local java_lsp_keymap = {
                    n = {
                        ["l."] = "code_action()",
                        ["ljr"] = "code_action(false,'refactor')",
                        ["ljo"] = "organize_imports()",
                        ["ljv"] = "extract_variable()"
                    },
                    v = {
                        ["l."] = "code_action(true)",
                        ["ljv"] = "extract_variable(true)",
                        ["ljm"] = "extract_method(true)"
                    }
                }
                local function lsp_java_attach_function(client)
                    AttachFunctionsLSP(client)
                    utils.set_buf_keymap(
                        java_lsp_keymap,
                        utils.leader_key_mapper,
                        function(value)
                            return "<Cmd>lua require'jdtls'." .. value
                        end
                    )
                    require('jdtls').setup_dap()
                    require("jdtls.setup").add_commands()
                end
                local function get_config()
                    local document_config = require "lspconfig".jdtls.document_config
                    local config = document_config.default_config
                    document_config.on_new_config(config)
                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    if vim.g.completion_enable_snippet then
                        capabilities.textDocument.completion.completionItem.snippetSupport = true
                    end
                    return {
                        cmd = config.cmd,
                        handlers = config.handlers,
                        on_attach = lsp_java_attach_function,
                        capabilities = capabilities,
                        --TODO: Automate Installation of jdtls bundles
                        bundles = vim.split(vim.fn.glob("~/lsp_servers/jdt-language-server-latest/bundles/*.jar"), "\n")
                    }
                end
                function JavaLspSetup()
                    local config = get_config()
                    require "jdtls".start_or_attach(config)
                end
                JavaLspSetup()
                vim.cmd [[augroup lsp_java]]
                vim.cmd [[autocmd!]]
                vim.cmd [[autocmd FileType java  call v:lua.JavaLspSetup()]]
                vim.cmd [[augroup end]]
            end
        }
        use {"mfussenegger/nvim-dap", ft = {"cpp", "python"}}
        -- completion
        use {
            "nvim-lua/completion-nvim",
            event = {"InsertEnter *"},
            setup = function()
                vim.g.completion_enable_snippet = "vim-vsnip"
                vim.g.completion_auto_change_source = 1
            end,
            config = function()
                local chain_complete_list = {
                    default = {
                        default = {
                            {complete_items = {"lsp", "snippet"}},
                            {complete_items = {"buffers"}}
                        },
                        string = {
                            {complete_items = {"path"}},
                            {complete_items = {"buffers"}}
                        }
                    }
                }

                local disabled_file_types = {clap_input = true, TelescopePrompt = true}

                function CompletionAttachFunction()
                    local ft = vim.bo.filetype
                    if not disabled_file_types[ft] then
                        local completion_options_table = {
                            chain_complete_list = chain_complete_list,
                            enable_auto_paren = true,
                            matching_strategy_list = {"exact", "substring", "fuzzy"}
                        }
                        if pcall(vim.treesitter.get_parser) then
                            completion_options_table.syntax_at_point = function()
                                local node = require("nvim-treesitter/ts_utils").get_node_at_cursor()
                                return node:type()
                            end
                        end
                        require "completion".on_attach(completion_options_table)
                    end
                end
                vim.api.nvim_set_keymap("i", "<C-k>", "<Plug>(completion_prev_source)", {})
                vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(completion_next_source)", {})
                vim.cmd [[augroup CompletionAttach]]
                vim.cmd [[autocmd!]]
                vim.cmd [[autocmd BufEnter * call v:lua.CompletionAttachFunction()]]
                vim.cmd [[augroup end]]
                vim.cmd [[ doautocmd BufEnter ]]
            end
        }
        use {
            "steelsojka/completion-buffers",
            after = {"completion-nvim"},
            config = function()
                require "completion_buffers".add_sources()
            end
        }
        use {
            "hrsh7th/vim-vsnip",
            after = {"completion-nvim"},
            setup = function()
                vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets/"
            end,
            config = function()
                vim.api.nvim_set_keymap(
                    "i",
                    "<Tab>",
                    "vsnip#available(1)  ? '<Plug>(vsnip-jump-next)': '<Tab>'",
                    {expr = true}
                )
                vim.api.nvim_set_keymap(
                    "s",
                    "<Tab>",
                    "vsnip#available(1)  ? '<Plug>(vsnip-jump-next)': '<Tab>'",
                    {expr = true}
                )
                vim.api.nvim_set_keymap(
                    "i",
                    "<S-Tab>",
                    "vsnip#available(-1)  ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'",
                    {expr = true}
                )
                vim.api.nvim_set_keymap(
                    "i",
                    "<S-Tab>",
                    "vsnip#available(-1)  ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'",
                    {expr = true}
                )
            end
        }
        use {
            "hrsh7th/vim-vsnip-integ",
            after = {"completion-nvim", "vim-vsnip"}
        }
    end
)
