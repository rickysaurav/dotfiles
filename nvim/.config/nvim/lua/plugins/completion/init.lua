local utils = require "config.utils"
local comps = {"completion","snippets"}
comps = vim.tbl_map(function(entry) return require("plugins.completion." .. entry) end,
                    comps)
return utils.concat_lists(unpack(comps))
