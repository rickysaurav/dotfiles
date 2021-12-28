local utils = require "config.utils"
local comps = {"syntax","treesitter"}
comps = vim.tbl_map(function(entry) return require("plugins.syntax." .. entry) end,
                    comps)
return utils.concat_lists(unpack(comps))
