local hop = {
    "phaazon/hop.nvim",
    cmd = {"HopWord", "HopLine", "HopChar1", "HopChar2", "HopPattern"},
    setup = function()
        local utils = require "config.utils"
        local hop_keymap = {
            [""] = {
                ["\\w"] = "<cmd>HopWord<CR>",
                ["\\f"] = "<cmd>HopChar1<CR>",
                ["\\/"] = "<cmd>HopPattern<CR>",
                ["\\j"] = "<cmd>HopLine<CR>"
            }
        }
        utils.set_keymap(hop_keymap, nil, nil, false, {})
    end
}

return {hop}
