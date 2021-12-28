local neogit = {
    'TimUntersberger/neogit',
    wants = {"plenary.nvim"},
    requires = {
        {"nvim-lua/plenary.nvim", opt = true},
    },
    cmd = {"Neogit"}
}

return {neogit}
