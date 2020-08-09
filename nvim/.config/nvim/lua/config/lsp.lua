local M = {}
local api = vim.api
local luv = vim.loop
local lsp = vim.lsp
local nvim_lsp = require'nvim_lsp'
local diagnostic = require'diagnostic'
local lsp_status = require('lsp-status')
lsp_status.config({status_symbol = ''})
lsp_status.register_progress()

local lsp_keymap = {
    n = {
        [ "<c-]>" ] = "vim.lsp.buf.definition()",
        [ "gd" ] = "vim.lsp.buf.definition()",
        [ "gi" ]    = "vim.lsp.buf.implementation()",
        [ "gD" ]    = "vim.lsp.buf.declaration()",
        [ "gI" ]   = "vim.lsp.buf.type_definition()",
        [ "gr" ]    = "vim.lsp.buf.references()",
        [ "g0" ]    = "vim.lsp.buf.document_symbol()",
        [ "gW" ]    = "vim.lsp.buf.workspace_symbol()",
        [ "<c-k>" ] = "vim.lsp.buf.signature_help()",
        [ "K" ]     = "vim.lsp.buf.hover()",
        ["<leader>lr"] = "vim.lsp.buf.rename()",
        ["<leader>lf"] = "vim.lsp.buf.range_formatting()",
        ["<leader>lF"] = "vim.lsp.buf.formatting()",
        ["<leader>l."] = "vim.lsp.buf.code_action()"
    },
    v = {
        ["<leader>lf"] = "vim.lsp.buf.range_formatting()",
    }
}

local diagnostic_keymap = {
    n = {
        ["<leader>el"] = ":OpenDiagnostic",
        ["<leader>en"] = ":PrevDiagnosticCycle",
        ["<leader>ep"] = ":NextDiagnosticCycle"
    }
}


local function set_lsp_keymap()
    for mode,map in pairs(lsp_keymap) do
        for k,v in pairs(map) do
            api.nvim_buf_set_keymap(0, mode , k, '<cmd>lua '..v..'<CR>', {
                    nowait = true, noremap = true, silent = true
                })
        end
    end
end

local function set_diagnostic_keymap()
    for mode,map in pairs(diagnostic_keymap) do
        for k,v in pairs(map) do
            api.nvim_buf_set_keymap(0, mode , k, v..'<CR>', {
                    nowait = true, noremap = true, silent = true
                })
        end
    end
end


local function attach_functions(client)
    set_lsp_keymap()
    set_diagnostic_keymap()
    diagnostic.on_attach()
    lsp_status.on_attach(client)
end

local function root_function_generator(root_patterns)
    return function(fname)
        return nvim_lsp.util.find_git_ancestor(fname) or nvim_lsp.util.root_pattern(root_patterns)(fname)  or luv.os_homedir()
    end
end

local base_config = {
    log_level = lsp.protocol.MessageType.Log;
    message_level = lsp.protocol.MessageType.Log;
    on_attach = attach_functions,
    capabilities = lsp_status.capabilities
}

local server_configs = {
    pyls_ms = {
        root_patterns = {"Pipfile","poetry.toml","setup.py","requirements.txt"};
        callbacks = lsp_status.extensions.pyls_ms.setup(),
        settings = { python = { workspaceSymbols = { enabled = true }, analysis = {memory = { keepLibraryAst = true, keepLibraryLocalVariables = true }} }},
    };
    clangd = {
        root_patterns = {"compile_commands.json",".ccls"};
        callbacks = lsp_status.extensions.clangd.setup(),
        args = {"--background-index","-header-insertion=never"},
        init_options = {
            clangdFileStatus = true
        },
    },
    rust_analyzer = {
        root_patterns = {"Cargo.toml", "rust-project.json"};
    },
    jdtls = {
        root_patterns = {"pom.xml","build.xml"};
    }
}


local function ensure_installed(servers)
    for _,server in ipairs(servers) do
        local server_module = nvim_lsp[server]
        if server_module then
            if server_module.install_info then
                local install_info = server_module.install_info()
                if not install_info.is_installed then
                    print(server.." not installed . Starting installation. ")
                    nvim_err_writeln(server.." not installed . Starting installation. ")
                    api.nvim_command("LspInstall "..server)
                end
            end
        else
            error("invalid server name "..server)
        end
    end
end


local function setup_server(server)
    local config = {}
    for key, value in pairs(base_config) do
        config[key]=value
    end
    local server_config = server_configs[server] or {}
    for key,value in pairs(server_config) do
        config[key]=value
    end
    config.root_dir = root_function_generator(server_config['root_patterns'] or {})
    nvim_lsp[server].setup(config)
end

local function setup_servers(servers)
    for _,server in ipairs(servers) do
        local server_module = nvim_lsp[server]
        if not server_module then
            error("invalid server name "..server)
        end
        setup_server(server)
    end
end

function M.setup()
    ensure_installed({"pyls_ms","vimls","clangd","sumneko_lua","jsonls","tsserver","jdtls"})
    setup_servers({"pyls_ms","vimls","clangd","sumneko_lua","jsonls","tsserver","rust_analyzer","jdtls"})
end
return M
