local utils = require "config.utils"
local comps = {"clipboard","comment","navigation","pairs","profiling","terminal"}
comps = vim.tbl_map(function(entry) return require("plugins.misc." .. entry) end,
                    comps)
return utils.concat_lists(unpack(comps))
