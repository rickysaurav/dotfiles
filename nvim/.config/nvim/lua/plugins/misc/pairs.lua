local surround = {
    "tpope/vim-surround",
    keys = {{"n", "cs"}, {"n", "ds"}, {"n", "ys"}, {"x", "S"}}
}

local dot_repeat = {"tpope/vim-repeat", keys = {"."}}

local lexima = {
    "cohama/lexima.vim",
    keys = {
        {"i", "("}, {"i", "["}, {"i", "<"}, {"i", "'"}, {"i", "{"}, {"i", '"'}
    },
    config = function()
        vim.cmd [[doautocmd lexima-init InsertEnter]]
        vim.cmd [[doautocmd lexima InsertEnter]]
        vim.cmd [[doautocmd User LeximaLoaded]]
    end
}

return {surround, dot_repeat, lexima}
