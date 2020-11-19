local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
    -- TODO: Maybe handle windows better?
    if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
        return
    end

    local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

    vim.fn.mkdir(directory, "p")

    local out =
        vim.fn.system(
        string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
    )

    print(out)
    print("Downloading packer.nvim...")

    return
end

vim.cmd [[packadd packer.nvim]]

local packer = require("packer")

packer.startup(
    function(use)
        -- Packer can manage itself as an optional plugin
        use {"wbthomason/packer.nvim", opt = true}
        -- Colorschemes
        use {
            "nvim-lua/telescope.nvim",
            requires = {{"nvim-lua/popup.nvim", opt = true}, {"nvim-lua/plenary.nvim", opt = true}},
            cmd = {"Telescope"},
        }
    end
)
