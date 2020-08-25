local api = vim.api
local golden_size = require("golden_size")

local M = {}
api.nvim_set_var("golden_size_off", 0)

local ignored_buftypes = {quickfix = true}
local ignored_filetypes = {LuaTree = true}

local function ignore_by_buftype()
    local buftype = vim.bo.buftype
    return ignored_buftypes[buftype] and 1 or nil
end

local function ignore_by_filetype()
    local filetype = vim.bo.filetype
    return ignored_filetypes[filetype] and 1 or nil
end

function GoldenSizeToggle()
    local current_value = api.nvim_get_var("golden_size_off") or 0
    api.nvim_set_var("golden_size_off", current_value == 1 and 0 or 1)
end

local function golden_size_ignore()
    return api.nvim_get_var("golden_size_off")
end

function M.setup()
    -- set the callbacks, preserve the defaults
    golden_size.set_ignore_callbacks({
      { golden_size_ignore },
      { ignore_by_buftype  },
      { ignore_by_filetype },
      { golden_size.ignore_float_windows }, -- default one, ignore float windows
      { golden_size.ignore_by_window_flag }, -- default one, ignore windows with w:ignore_gold_size=1
    })
end
return M
