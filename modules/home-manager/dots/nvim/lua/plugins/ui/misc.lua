local indent_guides = {
    "glepnir/indent-guides.nvim",
    setup = function()
        vim.defer_fn(function()
            vim.cmd("doautocmd User LoadIndentGuides")
        end, 1000)
    end,
    event = {"User LoadIndentGuides"},
    config = function()
        require("indent_guides").setup({indent_tab_guides = true})
        vim.cmd("IndentGuidesEnable")
    end
}
local golden_size = {
    "dm1try/golden_size",
    event = {"WinEnter *"},
    config = function()
        local golden_size = require("golden_size")

        vim.api.nvim_set_var("golden_size_off", 0)

        local ignored_buftypes = {quickfix = true}
        local ignored_filetypes = {NvimTree = true}

        local function ignore_by_buftype()
            local buftype = vim.bo.buftype
            return ignored_buftypes[buftype] and 1 or nil
        end

        local function ignore_by_filetype()
            local filetype = vim.bo.filetype
            return ignored_filetypes[filetype] and 1 or nil
        end

        local function ignore_by_tab()
            return vim.t.ignore_gold_size and 1 or nil
        end

        function GoldenSizeToggle()
            local current_value = vim.api.nvim_get_var("golden_size_off") or 0
            vim.api.nvim_set_var("golden_size_off",
                                 current_value == 1 and 0 or 1)
        end

        -- temporary workaround for diffview.nvim
        function GoldenSizeTabToggle() vim.t.ignore_gold_size = true end

        local function golden_size_ignore()
            return vim.api.nvim_get_var("golden_size_off")
        end
        -- set the callbacks, preserve the defaults
        golden_size.set_ignore_callbacks(
            {
                {golden_size_ignore}, {ignore_by_buftype}, {ignore_by_filetype},
                {ignore_by_tab}, {golden_size.ignore_float_windows}, -- default one, ignore float windows
                {golden_size.ignore_by_window_flag} -- default one, ignore windows with w:ignore_gold_size=1
            })
    end
}
local colorizer = {
    "norcalli/nvim-colorizer.lua",
    cmd = {
        "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers",
        "ColorizerToggle", "ColorizerAttachToBuffer"
    },
    config = function() require"colorizer".setup() end
}

local which_key = {
    "folke/which-key.nvim",
    setup = function()
        vim.defer_fn(function()
            vim.cmd("doautocmd User LoadWhichKey")
        end, 1000)
    end,
    event = {"User LoadWhichKey"},
    config = function()
        vim.cmd("doautocmd VimEnter")
        require("which-key").setup {
            spelling = {
                enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                suggestions = 20 -- how many suggestions should be shown in the list?
            }
        }
    end
}
return {indent_guides, golden_size, colorizer,which_key}
