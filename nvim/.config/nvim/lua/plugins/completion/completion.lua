local compe = {
    "hrsh7th/nvim-compe",
    event = {"InsertEnter *"},
    config = function()
        local utils = require "config.utils"
        --- handle after plugins for nvim-compe

        local base_install_dir = require"packer".config.git.default_base_dir
        local plugin_install_path = base_install_dir .. '/opt/nvim-compe'
        for _, file_path in ipairs(vim.fn.globpath(plugin_install_path,
                                                   "after/plugin/**/*.vim", 0, 1)) do
            vim.cmd("source " .. file_path)
        end

        --- handle after plugins for nvim-compe
        require'compe'.setup {
            enabled = true,
            autocomplete = true,
            debug = true,
            min_length = 1,
            preselect = 'enable',
            throttle_time = 80,
            source_timeout = 200,
            incomplete_delay = 400,
            max_abbr_width = 100,
            max_kind_width = 100,
            max_menu_width = 100,
            documentation = true,
            source = {
                path = true,
                buffer = true,
                calc = true,
                vsnip = true,
                nvim_lsp = true,
                nvim_lua = true,
                spell = true
            }
        }
        local compe_keymap = {
            i = {
                -- inoremap <silent><expr> <C-Space> compe#complete()
                ["<C-/>"] = "compe#complete()",
                ["<CR>"] = "compe#confirm('<CR>')",
                ["<C-e>"] = "compe#close('<C-e>')",
                ["<C-f>"] = "compe#scroll({ 'delta': +4 })",
                ["<C-d>"] = "compe#scroll({ 'delta': -4 })"
            }
        }
        vim.cmd [[au User LeximaLoaded ++once inoremap <silent><expr> <CR> compe#confirm(lexima#expand('<LT>CR>','i'))]]
        utils.set_keymap(compe_keymap, nil, nil, false,
                         {expr = true, silent = true, noremap = true})
    end
}
return {compe}