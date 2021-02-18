local easymotion = {
    "easymotion/vim-easymotion",
    keys = {"<Plug>(easymotion"},
    setup = function()
        local utils = require "config.utils"
        local easymotion_keymap = {
            n = {
                ["<leader>m"] = "<Plug>(easymotion_prefix)",
                ["/"] = "<Plug>(easymotion-sn)"
            },
            o = {["/"] = "<Plug>(easymotion-tn)"}
        }
        vim.g.EasyMotion_smartcase = 1
        utils.set_keymap(easymotion_keymap, nil, nil, false)
    end
}
return {easymotion}
