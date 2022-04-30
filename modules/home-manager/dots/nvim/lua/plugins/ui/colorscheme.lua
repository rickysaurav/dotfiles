local one_dark = {
    "navarasu/onedark.nvim",
    event = {"FocusLost *", "CursorHold *"},
    config = function()
        require('onedark').setup {
            style = 'dark'
        }
        require('onedark').load()
        vim.cmd [[doautocmd User ColorSchemeLoaded]]
    end
}
return {one_dark}
