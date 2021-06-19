local utils = require "config.utils"
local comps = {"ui","search","git","completion","syntax","misc","language","debug"}
comps = vim.tbl_map(function(entry) return require("plugins." .. entry) end,
                    comps)
return utils.concat_lists(unpack(comps))
