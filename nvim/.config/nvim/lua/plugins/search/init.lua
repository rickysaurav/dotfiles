local utils = require "config.utils"
local comps = {"fuzzy_finder"}
comps = vim.tbl_map(function(entry) return require("plugins.search." .. entry) end,
                    comps)
return utils.concat_lists(unpack(comps))
