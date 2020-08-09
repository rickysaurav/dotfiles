local chain_complete_list = {
    default = {
        {complete_items = {'lsp', 'snippet'}},
        {complete_items = {'buffer'}},
    },
    string = {
        {complete_items = {'path'}},
    }
}

local disabled_file_types = {clap_input = true}

local M = {}


function M.on_attach()
        local ft = vim.bo.filetype
        if not disabled_file_types[ft] then
            require'completion'.on_attach({
                    chain_complete_list = chain_complete_list,
                })
        end
end

return M
