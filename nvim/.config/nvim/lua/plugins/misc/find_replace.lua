local bqf = {"kevinhwang91/nvim-bqf", ft = {"qf"}}

local spectre = {
    "windwp/nvim-spectre",
    module = {"spectre"},
    requires = {
        {"nvim-lua/popup.nvim", opt = true},
        {"nvim-lua/plenary.nvim", opt = true}
    },
    setup = function()
        vim.api.nvim_set_keymap("n", "<leader>S",
                                "<cmd>lua require('spectre').open()<CR>",
                                {noremap = true})
    end,
    config = function()
        require("packer.load")({"plenary.nvim", "popup.nvim"}, {},
                               _G.packer_plugins)
    end
}

return {bqf, spectre}
