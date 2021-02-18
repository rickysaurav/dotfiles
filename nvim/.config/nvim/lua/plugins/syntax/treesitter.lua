local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    cmd = {
        "TSInstall", "TSBufEnable", "TSEnableAll", "TSModuleInfo", "TSUpdate"
    },
    ft = {
        "cpp", "c", "python", "java", "lua", "json", "markdown", "typescript",
        "bash", "zsh"
    },
    run = function() vim.cmd("TSUpdate") end,
    config = function()
        require"nvim-treesitter.configs".setup {
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
                highlight_definitions = {enable = true},
                -- highlight_current_scope = {
                -- enable = true
                -- },
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
                    swap_next = {["<leader>N"] = "@parameter.inner"},
                    swap_previous = {["<leader>P"] = "@parameter.inner"}
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
            ensure_installed = {
                "lua", "c", "cpp", "json", "java", "python", "bash",
                "typescript"
            } -- one of 'all', 'language', or a list of languages
        }
    end
}
local treesitter_refactor = {
    "nvim-treesitter/nvim-treesitter-refactor",
    after = {"nvim-treesitter"}
}
local treesitter_textobjects = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = {"nvim-treesitter"}
}
return {treesitter, treesitter_refactor, treesitter_textobjects}
