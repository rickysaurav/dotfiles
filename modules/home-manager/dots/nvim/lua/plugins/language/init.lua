local utils = require "config.utils"
local comps = {"lsp","lsp_java"}
comps = vim.tbl_map(function(entry) return require("plugins.language." .. entry) end,
                    comps)
return utils.concat_lists(unpack(comps))
