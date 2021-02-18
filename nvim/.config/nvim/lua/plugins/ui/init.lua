local utils = require "config.utils"
local comps = {"colorscheme", "file_explorer", "misc", "statusline"}
comps = vim.tbl_map(function(entry) return require("plugins.ui." .. entry) end,
                    comps)
return utils.concat_lists(unpack(comps))
