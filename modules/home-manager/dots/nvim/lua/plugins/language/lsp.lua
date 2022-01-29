local nvim_lsp = {
    "neovim/nvim-lspconfig",
    ft = {
        "cpp", "c", "python", "lua", "vim", "json", "typescript", "rust", "yaml"
    },
    config = function()
        local luv = vim.loop
        local lsp = vim.lsp
        local lspconfig = require "lspconfig"

        local lsp_keymap = {
            n = {
                ["<c-]>"] = "vim.lsp.buf.definition()",
                ["gd"] = "vim.lsp.buf.definition()",
                ["gi"] = "vim.lsp.buf.implementation()",
                ["gD"] = "vim.lsp.buf.declaration()",
                ["gI"] = "vim.lsp.buf.type_definition()",
                ["gr"] = "vim.lsp.buf.references()",
                ["gs"] = "vim.lsp.buf.document_symbol()",
                ["gS"] = "vim.lsp.buf.workspace_symbol()",
                ["K"] = "vim.lsp.buf.hover()",
                ["<c-k>"] = "vim.lsp.buf.signature_help()",
                ["<leader>lR"] = "vim.lsp.buf.rename()",
                ["<leader>lF"] = "vim.lsp.buf.range_formatting()",
                ["<leader>lf"] = "vim.lsp.buf.formatting()",
                ["<leader>l."] = "vim.lsp.buf.code_action()",
                ["<leader>el"] = "vim.diagnostic.setloclist()",
                ["<leader>en"] = "vim.diagnostic.goto_next({wrap=true, severity_limit = 'Error'})",
                ["<leader>ep"] = "vim.diagnostic.goto_prev({wrap=true, severity_limit = 'Error'})"
            },
            v = {["<leader>lf"] = "vim.lsp.buf.range_formatting()"},
            i = {["<c-k>"] = "vim.lsp.buf.signature_help()"}
        }

        local telescope_keymap = {
            n = {
                ["ls"] = "lsp_document_symbols",
                ["lS"] = "lsp_workspace_symbols",
                ["l."] = "lsp_code_actions",
                ["lr"] = "lsp_references"
            }
        }
        function AttachFunctionsLSP(client)
            local utils = require "config.utils"
            utils.set_buf_keymap(lsp_keymap, nil, function(value)
                return "<Cmd>lua " .. value
            end)
            utils.set_buf_keymap(telescope_keymap, utils.leader_key_mapper,
                                 function(value)
                return "<Cmd>call v:lua.Telescope('" .. value .. "')"
            end)
            require"lsp_signature".on_attach()
        end

        local function root_function_generator(root_patterns)
            return function(fname)
                return lspconfig.util.find_git_ancestor(fname) or
                           lspconfig.util.root_pattern(root_patterns)(fname) or
                           vim.fn.getcwd() or luv.os_homedir()
            end
        end

        local function get_client_capabilities()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport =
                true
            return capabilities
        end

        local base_config = {
            -- log_level = 0,
            message_level = lsp.protocol.MessageType.Log,
            on_attach = AttachFunctionsLSP,
            capabilities = get_client_capabilities()
        }
        local server_configs = {
            jsonls = {
                cmd = {"json-languageserver", "--stdio"},
                init_options = {provideFormatter = true}
            },
            yamlls = {settings = {yaml = {format = {enable = true}}}},
            pyright = {
                root_patterns = {
                    "Pipfile", "poetry.toml", "setup.py", "requirements.txt"
                },
                settings = {
                    python = {
                        analysis = {autoSearchPaths = true, logLevel = "Trace"},
                        pyright = {useLibraryCodeForTypes = true}
                    }
                }
            },
            clangd = {
                root_patterns = {
                    "compile_commands.json", ".ccls", "compile_flags.txt"
                },
                cmd = {
                    "clangd", "--background-index", "--header-insertion=never",
                    "--clang-tidy","--function-arg-placeholders=false" , "--all-scopes-completion",
                    "--inlay-hints"
                },
                init_options = {clangdFileStatus = true}
            },
            rust_analyzer = {
                root_patterns = {"Cargo.toml", "rust-project.json"}
            },
            sumneko_lua = function()
                return require("lua-dev").setup({
                    lspconfig = {cmd = {"lua-language-server"}}
                })
            end,
            efm = {
                init_options = {documentFormatting = true},
                filetypes = {"lua"},
                settings = {
                    languages = {
                        lua = {
                            {
                                formatCommand = "lua-format -i",
                                formatStdin = true
                            }
                        }
                    }
                }
            }
        }

        local function setup_server(server)
            local server_config = server_configs[server] or {}
            if vim.is_callable(server_config) then
                server_config = server_config()
            end
            local config = vim.tbl_extend('force', base_config, server_config)
            config.root_dir = root_function_generator(
                                  server_config["root_patterns"] or {})
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
        -- local function setup_diagnostics()
        --     vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        --                                                               vim.lsp
        --                                                                   .diagnostic
        --                                                                   .on_publish_diagnostics,
        --                                                               {
        --             -- Enable underline, use default values
        --             underline = true,
        --             -- Enable virtual text, override spacing to 4
        --             virtual_text = {spacing = 5},
        --             -- Use a function to dynamically turn signs off
        --             -- and on, using buffer local variables
        --             signs = function(bufnr)
        --                 local ok, result =
        --                     pcall(vim.api.nvim_buf_get_var, bufnr, "show_signs")
        --                 -- No buffer local variable set, so just enable by default
        --                 if not ok then return true end
        --                 return result
        --             end,
        --             -- Disable a feature
        --             update_in_insert = false
        --         })
        -- end
        -- setup_diagnostics()
        setup_servers({
            "pyright", "vimls", "clangd", "sumneko_lua", "jsonls", "tsserver",
            "rust_analyzer", "yamlls", "efm"
        })
    end
}
local luadev = {"folke/lua-dev.nvim", module = {"lua-dev"}}
local lsp_signature = {"ray-x/lsp_signature.nvim", module = {"lsp_signature"}}
return {nvim_lsp, luadev, lsp_signature}
