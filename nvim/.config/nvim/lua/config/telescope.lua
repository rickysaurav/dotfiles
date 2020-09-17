_TelescopeConfigurationValues = {}
_TelescopeConfigurationValues["vimgrep_arguments"]  = {'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case','--hidden',"-g","!.git"}
local api = vim.api
local telescope_builtin = require "telescope.builtin"
local M = {}

local function check_valid_source(source)
    return telescope_builtin[source]~=nil
end

local source_args = {
    find_files = {find_command = { "rg", "-i", "--hidden", "--files", "-g", "!.git" }}
}

function M.telescope(source)
    if check_valid_source(source) then
        telescope_builtin[source](source_args[source])
    else
        print("Invalid source")
    end
end
return M
