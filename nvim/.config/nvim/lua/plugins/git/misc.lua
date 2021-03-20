local blame = {
    "f-person/git-blame.nvim",
    cmd = {"GitBlameToggle", "GitBlameEnable", "GitBlameDisable"},
    setup = function()
        -- adjust correct inital state for gitblame enabled
        -- this allows GitBlameToggle enable plugin when lazily loaded
        -- else when lazily loaded the plugin is activated when GitBlameToggle is called
        -- and then the GitBlameToggle disables it
        vim.g.gitblame_enabled = 0
    end
}
local git_signs = {
    "lewis6991/gitsigns.nvim",
    module = {"gitsigns"},
    requires = {{"nvim-lua/plenary.nvim", opt = true}},
    config = function()
        require("packer.load")({"plenary.nvim"}, {}, _G.packer_plugins)
        require('gitsigns').setup()
        vim.cmd [[ doautocmd BufEnter ]]
    end
}
return {blame, git_signs}
