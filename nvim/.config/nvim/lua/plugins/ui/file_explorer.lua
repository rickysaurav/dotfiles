local nvim_tree =  {
    "kyazdani42/nvim-tree.lua",
    requires = {{"kyazdani42/nvim-web-devicons", opt = true}},
    cmd = {"NvimTreeToggle", "NvimTreeOpen"},
    setup = function()
        vim.g.nvim_tree_follow = 1
        vim.g.nvim_tree_disable_keybindings = 1
        vim.g.nvim_tree_icons = {default = ""}
        vim.g.nvim_tree_git_hl = 1
        local utils = require "config.utils"
        utils.set_keymap({n = {ft = "<Cmd>NvimTreeToggle"}},
                         utils.leader_key_mapper)
    end,
    config = function()
        require("packer.load")({"nvim-web-devicons"}, {}, _G.packer_plugins)
    end
}
return {nvim_tree}
