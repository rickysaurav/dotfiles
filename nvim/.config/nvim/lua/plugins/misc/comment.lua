local kommentary = {
    "b3nj5m1n/kommentary",
    setup = function()
        vim.g.kommentary_create_default_mappings = false
        local utils = require "config.utils"
        local kommentary_keymap = {
            n = {ci = "<Plug>kommentary_motion_default_",  cc = "<Plug>kommentary_motion_default"},
            v = {ci = "<Plug>kommentary_visual_default"}
        }
        utils.set_keymap(kommentary_keymap, utils.leader_key_mapper, nil, false,
        {})
    end,
    keys = {"<Plug>kommentary_"},
    config = function()
        require('kommentary.config').configure_language("default", {
            prefer_single_line_comments = true
        })
    end
}
return {kommentary}
