local utils = require "config.utils"
local comps = {"org_mode"}
comps = vim.tbl_map(
            function(entry) return require("plugins.notes." .. entry) end, comps)
return utils.concat_lists(unpack(comps))
