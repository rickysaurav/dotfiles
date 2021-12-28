local nvim_jdtls = {
    "mfussenegger/nvim-jdtls",
    ft = {"java"},
    requires = {{"neovim/nvim-lspconfig", opt = true}},
    wants = {"nvim-lspconfig"},
    config = function()
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
            utils.set_buf_keymap(java_lsp_keymap, utils.leader_key_mapper,
                                 function(value)
                return "<Cmd>lua require'jdtls'." .. value
            end)
            require('jdtls').setup_dap()
            require("jdtls.setup").add_commands()
        end
        local function get_config()
            local config = require"lspconfig".jdtls.document_config
                               .default_config
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport =
                true
            return {
                cmd = {"jdtls","-data",vim.fn.expand("~/.cache/nvim/jdtls_ws")},
                handlers = config.handlers,
                on_attach = lsp_java_attach_function,
                capabilities = capabilities,
                -- TODO: Automate Installation of jdtls bundles
                init_options = {
                    bundles = vim.split(vim.fn.glob(
                                            "~/lsp_servers/jdt-language-server-latest/bundles/*.jar"),
                                        "\n")
                },
                settings = {
                    java = {
                        signatureHelp = {enabled = true},
                        contentProvider = {preferred = "fernflower"},
                        completion = {favoriteStaticMembers = {}},
                        sources = {
                            organizeImports = {
                                starThreshold = 9999,
                                staticStarThreshold = 9999
                            }
                        }
                    }
                }
            }
        end
        function JavaLspSetup()
            local config = get_config()
            require"jdtls".start_or_attach(config)
        end
        JavaLspSetup()
        vim.cmd [[augroup lsp_java]]
        vim.cmd [[autocmd!]]
        vim.cmd [[autocmd FileType java  call v:lua.JavaLspSetup()]]
        vim.cmd [[augroup end]]
    end
}
return {nvim_jdtls}
