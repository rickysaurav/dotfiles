local vim = vim
local M = {}

function M.set_globals(globals)
   for key, value in pairs(globals) do
        vim.g[key] = value
    end
end

function M.set_options(options)
    for key, value in pairs(options) do
        vim.o[key] = value
    end
end

function M.set_local_options(options)
    for k, v in pairs(options) do
        if v == true or v == false then
            vim.api.nvim_command("set " .. k)
        else
            vim.api.nvim_command("set " .. k .. "=" .. v)
        end
    end
end

function M.leader_key_mapper(key)
    return "<leader>" .. key
end

function M.set_keymap(keymap, key_mapper, value_mapper, should_add_new_line,opts)
    value_mapper = value_mapper or function(value)
            return value
        end
    key_mapper = key_mapper or function(key)
            return key
        end
    opts = opts or {noremap=true}
    local new_line = ( should_add_new_line == false  ) and "" or "<CR>"
    for mode, map in pairs(keymap) do
        for k, v in pairs(map) do
            vim.api.nvim_set_keymap(
                mode,
                key_mapper(k),
                value_mapper(v) .. new_line,
                opts
            )
        end
    end
end
function M.set_buf_keymap(keymap, key_mapper, value_mapper, should_add_new_line,opts)
    value_mapper = value_mapper or function(value)
            return value
        end
    key_mapper = key_mapper or function(key)
            return key
        end
    opts = opts or {noremap=true}
    local new_line = (should_add_new_line == false) and "" or "<CR>"
    for mode, map in pairs(keymap) do
        for k, v in pairs(map) do
            vim.api.nvim_buf_set_keymap(
                0,
                mode,
                key_mapper(k),
                value_mapper(v) .. new_line,
                opts
            )
        end
    end
end


function M.concat_lists(t, ...)
    local new = {unpack(t)}
    for _,v in ipairs({...}) do
        for _,vv in ipairs(v) do
            new[#new+1] = vv
        end
    end
    return new
end

return M
