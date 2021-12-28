local bqf = {"kevinhwang91/nvim-bqf", ft = {"qf"}}

local spectre = {
    "windwp/nvim-spectre",
    module = {"spectre"},
    requires = {
        {"nvim-lua/popup.nvim", opt = true},
        {"nvim-lua/plenary.nvim", opt = true}
    },
    wants = {"popup.nvim","plenary.nvim"},
    setup = function()
        vim.api.nvim_set_keymap("n", "<leader>S",
                                "<cmd>lua require('spectre').open()<CR>",
                                {noremap = true})
    end
}

return {bqf, spectre}
