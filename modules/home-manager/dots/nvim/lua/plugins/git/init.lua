local utils = require "config.utils"
local comps = {"fugitive","neogit","misc"}
comps = vim.tbl_map(function(entry) return require("plugins.git." .. entry) end,
                    comps)
return utils.concat_lists(unpack(comps))
