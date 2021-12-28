local oscyank = {
    "ojroques/vim-oscyank",
    event = {"TextYankPost *"},
    config = function()
        if (vim.env.SSH_CLIENT or vim.env.SSH_TTY) then
            vim.cmd [[augroup IronRepl]]
            vim.cmd [[autocmd!]]
            vim.cmd("autocmd TextYankPost * OSCYankReg +<CR>")
            vim.cmd("OSCYankReg +")
            vim.cmd [[augroup END]]
        end
    end
}
return {oscyank}
