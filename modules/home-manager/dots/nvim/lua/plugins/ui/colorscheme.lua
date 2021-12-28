local one_nvim = {
    "Th3Whit3Wolf/one-nvim",
    branch = "main",
    event = {"FocusLost *", "CursorHold *"},
    config = function()
        vim.cmd [[colorscheme one-nvim]]
        vim.cmd [[doautocmd User ColorSchemeLoaded]]
    end
}
return {one_nvim}
