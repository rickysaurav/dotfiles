local utils = require "config.utils"
local comps = {"clipboard","comment","find_replace","navigation","pairs","profiling","terminal"}
comps = vim.tbl_map(function(entry) return require("plugins.misc." .. entry) end,
                    comps)
return utils.concat_lists(unpack(comps))
