local utils = require "config.utils"

local global_settings = {
    -- disable automatic vim plugins
    loaded_gzip = 1,
    loaded_tar = 1,
    loaded_tarPlugin = 1,
    loaded_zip = 1,
    loaded_zipPlugin = 1,
    loaded_getscript = 1,
    loaded_getscriptPlugin = 1,
    loaded_vimball = 1,
    loaded_vimballPlugin = 1,
    loaded_matchit = 1,
    -- matchparen impacts completion nvim auto signature help
    -- loaded_matchparen = 1,
    loaded_2html_plugin = 1,
    loaded_logiPat = 1,
    loaded_rrhelper = 1,
    loaded_netrw = 1,
    loaded_netrwPlugin = 1,
    loaded_netrwSettings = 1,
    loaded_netrwFileHandlers = 1,
    -- map leader
    mapleader = " ",
    -- python
    loaded_python_provider = 0,
    python3_host_prog = "/usr/bin/python"
}

local options = {
    mouse = "a",
    termguicolors = true,
    showmatch = true,
    swapfile = false,
    autowriteall = true,
    background = "dark",
    splitright = true,
    clipboard = "unnamedplus",
    hlsearch = false,
    inccommand = "nosplit",
    updatetime = 300,
    completeopt = "menuone,noinsert,noselect",
    ignorecase = true,
    smartcase = true,
    smarttab = true,
    list = true,
    listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
    showtabline = 0
}

local bw_local = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = true,
    relativenumber = true,
    number = true
}

local leader_key_mappings = {
    n = {
        bn = ":bnext",
        bp = ":bprevious",
        bd = ":bdelete",
        fy = ":let @+ = expand('%')",
        fv = ":edit $MYVIMRC",
        fr = ":source $MYVIMRC",
    }
}

local non_leader_key_mappings = {
    n = {["<leader>bc"] = "<C-^>", ["<leader>w"] = "<C-w>"},
    i = {
        ["<C-a>"] = "<Home>",
        ["<C-b>"] = "<Left>",
        ["<C-f>"] = "<Right>",
        ["<C-n>"] = "<Down>",
        ["<C-p>"] = "<Up>",
        ["<A-b>"] = "<S-Left>",
        ["<A-f>"] = "<S-Right>",
        ["<A-BS>"] = "<C-w>",
        ["<C-c>"] = "<Del>"
    },
    c = {
        ["<C-a>"] = "<Home>",
        ["<C-b>"] = "<Left>",
        ["<C-f>"] = "<Right>",
        ["<C-n>"] = "<Down>",
        ["<C-p>"] = "<Up>",
        ["<A-b>"] = "<S-Left>",
        ["<A-f>"] = "<S-Right>",
        ["<A-BS>"] = "<C-w>",
        ["<C-c>"] = "<Del>"
    }
}

utils.set_globals(global_settings)
utils.set_options(options)
utils.set_local_options(bw_local)

utils.set_keymap(leader_key_mappings, utils.leader_key_mapper)
utils.set_keymap(non_leader_key_mappings, nil, nil, false)

-- autosave/load setup
-- Save whenever switching windows or leaving vim. This is useful when running
-- the tests inside vim without having to save all files first.
vim.cmd [[au FocusLost,WinLeave * :silent! wa]]
-- Trigger autoread when changing buffers or coming back to vim.
vim.cmd [[au FocusGained,BufEnter * :silent! !]]

-- autocmd for packer compilation
vim.cmd [[augroup PackerAutocmd]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]
vim.cmd [[augroup END]]

vim.cmd [[augroup custom_term]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd TermOpen * setlocal bufhidden=hide]]
vim.cmd [[augroup END]]

-- Packer Bootstrap

local install_path = vim.fn.stdpath('data') ..
                         '/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " ..
                install_path)
end

vim.cmd("packadd packer.nvim")
-- Packer plugin load
local packer = require("packer")
packer.startup(function(use)
    use {"wbthomason/packer.nvim", opt = true}
    local plugins = require "plugins"
    for _, plugin in pairs(plugins) do use(plugin) end
end)
