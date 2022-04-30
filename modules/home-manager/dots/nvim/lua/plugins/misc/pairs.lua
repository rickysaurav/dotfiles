local surround = {
    "ur4ltz/surround.nvim",
    keys = {{"n", "cs"}, {"n", "ds"}, {"n", "ys"}, {"x", "S"}},
    config = function() require"surround".setup {mappings_style = "surround"} end
}

-- local dot_repeat = {"tpope/vim-repeat", keys = {"."}}

local lexima = {
    "windwp/nvim-autopairs",
    keys = {
        {"i", "("}, {"i", "["}, {"i", "<"}, {"i", "'"}, {"i", "{"}, {"i", '"'}
    },
    config = function()
        local npairs = require('nvim-autopairs')
        npairs.setup()
        -- skip it, if you use another global object
        _G.MUtils = {}
        vim.g.completion_confirm_key = ""
        MUtils.completion_confirm = function()
            if vim.fn.pumvisible() ~= 0 then
                if vim.fn.complete_info()["selected"] ~= -1 then
                    return vim.fn["compe#confirm"](npairs.esc("<cr>"))
                else
                    return npairs.esc("<cr>")
                end
            else
                return npairs.autopairs_cr()
            end
        end
        vim.api.nvim_set_keymap('i', '<CR>',
                                'v:lua.MUtils.completion_confirm()',
                                {expr = true, noremap = true})
        vim.cmd [[doautocmd autopairs_buf BufEnter]]
    end
}

return {surround, lexima}
