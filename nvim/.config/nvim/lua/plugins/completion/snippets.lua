local vim_vsnip = {
    "hrsh7th/vim-vsnip",
    after = {"nvim-compe"},
    setup = function() vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets/" end,
    config = function()
        vim.api.nvim_set_keymap("i", "<Tab>",
                                "vsnip#available(1)  ? '<Plug>(vsnip-jump-next)': '<Tab>'",
                                {expr = true})
        vim.api.nvim_set_keymap("s", "<Tab>",
                                "vsnip#available(1)  ? '<Plug>(vsnip-jump-next)': '<Tab>'",
                                {expr = true})
        vim.api.nvim_set_keymap("i", "<S-Tab>",
                                "vsnip#available(-1)  ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'",
                                {expr = true})
        vim.api.nvim_set_keymap("i", "<S-Tab>",
                                "vsnip#available(-1)  ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'",
                                {expr = true})
    end
}

local friendly_snippets = {
    "rafamadriz/friendly-snippets",
    after = {"vim-vsnip"}
}
return {vim_vsnip, friendly_snippets}
