local utils = require "config.utils"
local comps = {"dap"}
comps = vim.tbl_map(function(entry) return require("plugins.debug." .. entry) end,
                    comps)
return utils.concat_lists(unpack(comps))

