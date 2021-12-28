local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    module = {"nvim-treesitter"},
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
                    node_incremental = "gn", -- increment to the upper named parent
                    scope_incremental = "gs", -- increment to the upper scope (as defined in locals.scm)
                    node_decremental = "gp" -- decrement to the previous node
                }
            },
            indent = {enable = true},
            ensure_installed = {
                "bash", "c", "cpp", "dockerfile", "go", "html", "java", "json",
                "jsonc", "lua", "python", "rust", "toml", "tsx",
                "typescript", "yaml"
            } -- one of 'all', 'language', or a list of languages
        }
    end
}
local treesitter_refactor = {
    "nvim-treesitter/nvim-treesitter-refactor",
    after = {"nvim-treesitter"},
    config = function()
        require"nvim-treesitter.configs".setup {
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
            }
        }
    end
}
local treesitter_textobjects = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = {"nvim-treesitter"},
    config = function()
        require"nvim-treesitter.configs".setup {
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
                        ["[b"] = "@block.outer",
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer"
                    },
                    goto_previous_end = {
                        ["[B"] = "@block.outer",
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer"
                    },
                    goto_next_start = {
                        ["]b"] = "@block.outer",
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer"
                    },
                    goto_next_end = {
                        ["]B"] = "@block.outer",
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer"
                    }
                }
            }
        }
    end
}

local spellsitter = {
    "lewis6991/spellsitter.nvim",
    after = {"nvim-treesitter"},
    config = function() require('spellsitter').setup {hl = 'error'} end
}

local treesitter_subjects = {
    "RRethy/nvim-treesitter-textsubjects",
    after = {"nvim-treesitter"},
    config = function()
        require'nvim-treesitter.configs'.setup {
            textsubjects = {
                enable = true,
                keymaps = {
                    ['.'] = 'textsubjects-smart',
                    [';'] = 'textsubjects-big'
                }
            }
        }
    end
}

return {
    treesitter, treesitter_refactor, treesitter_textobjects, spellsitter,
    treesitter_subjects
}
