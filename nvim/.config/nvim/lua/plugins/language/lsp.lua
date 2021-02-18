local nvim_lsp = {
    "rickysaurav/nvim-lsp",
    ft = {
        "cpp", "c", "python", "lua", "vim", "json", "typescript", "rust", "yaml"
    },
    requires = {{"nvim-lua/lsp-status.nvim", opt = true}},
    config = function()
        require("packer.load")({"lsp-status.nvim"}, {}, _G.packer_plugins)
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
            v = {["<leader>lf"] = "vim.lsp.buf.range_formatting()"},
            i = {["<c-k>"] = "vim.lsp.buf.signature_help()"}
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
            utils.set_buf_keymap(lsp_keymap, nil, function(value)
                return "<Cmd>lua " .. value
            end)
            utils.set_buf_keymap(telescope_keymap, utils.leader_key_mapper,
                                 function(value)
                return "<Cmd>Telescope " .. value
            end)
            lsp_status.on_attach(client)
        end

        local function root_function_generator(root_patterns)
            return function(fname)
                return lspconfig.util.find_git_ancestor(fname) or
                           lspconfig.util.root_pattern(root_patterns)(fname) or
                           vim.call("getcwd") or luv.os_homedir()
            end
        end

        local function get_client_capabilities()
            local capabilities = lsp_status.capabilities
            capabilities.textDocument.completion.completionItem.snippetSupport =
                true
            return capabilities
        end

        local base_config = {
            log_level = lsp.protocol.MessageType.Log,
            message_level = lsp.protocol.MessageType.Log,
            on_attach = AttachFunctionsLSP,
            capabilities = get_client_capabilities()
        }
        local server_configs = {
            jsonls = {init_options = {provideFormatter = true}},
            yamlls = {settings = {yaml = {format = {enable = true}}}},
            pyls_ms = {
                root_patterns = {
                    "Pipfile", "poetry.toml", "setup.py", "requirements.txt"
                },
                handlers = lsp_status.extensions.pyls_ms.setup(),
                settings = {
                    python = {
                        workspaceSymbols = {enabled = true},
                        analysis = {
                            memory = {
                                keepLibraryAst = true,
                                keepLibraryLocalVariables = true
                            }
                        }
                    }
                }
            },
            pyright_ls = {
                root_patterns = {
                    "Pipfile", "poetry.toml", "setup.py", "requirements.txt"
                },
                handlers = {
                    -- pyright ignores dynamicRegistration settings
                    ["client/registerCapability"] = function(_, _, _, _)
                        return {result = nil, error = nil}
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
                root_patterns = {
                    "compile_commands.json", ".ccls", "compile_flags.txt"
                },
                handlers = lsp_status.extensions.clangd.setup(),
                cmd = {"clangd"},
                args = {
                    "--background-index", "-header-insertion=never",
                    "--clang-tidy", "--cross-file-rename"
                },
                init_options = {clangdFileStatus = true}
            },
            rust_analyzer = {
                root_patterns = {"Cargo.toml", "rust-project.json"}
            },
            sumneko_lua = {
                settings = {
                    Lua = {
                        diagnostics = {globals = {"vim"}},
                        runtime = {
                            version = "LuaJIT",
                            path = {
                                {
                                    "?.lua", "?/init.lua", "?/?.lua",
                                    vim.env.VIMRUNTIME .. "/lua/?.lua"
                                }
                            }
                        }
                    }
                }
            },
            efm = {filetypes = {"lua", "markdown"}}
        }

        local function ensure_installed(servers)
            for _, server in ipairs(servers) do
                local server_module = lspconfig[server]
                if server_module then
                    if server_module.install_info then
                        local install_info = server_module.install_info()
                        if not install_info.is_installed then
                            print(server ..
                                      " not installed . Starting installation. ")
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
        local function setup_diagnostics()
            vim.lsp.handlers["textDocument/publishDiagnostics"] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    -- Enable underline, use default values
                    underline = true,
                    -- Enable virtual text, override spacing to 4
                    virtual_text = {spacing = 5},
                    -- Use a function to dynamically turn signs off
                    -- and on, using buffer local variables
                    signs = function(bufnr)
                        local ok, result =
                            pcall(vim.api.nvim_buf_get_var, bufnr, "show_signs")
                        -- No buffer local variable set, so just enable by default
                        if not ok then return true end

                        return result
                    end,
                    -- Disable a feature
                    update_in_insert = false
                })
        end
        setup_diagnostics()
        ensure_installed({
            "pyright_ls", "vimls", "clangd", "sumneko_lua", "jsonls",
            "tsserver", "jdtls", "yamlls"
        })
        setup_servers({
            "pyright_ls", "vimls", "clangd", "sumneko_lua", "jsonls",
            "tsserver", "rust_analyzer", "yamlls", "efm"
        })
    end
}
return {nvim_lsp}
