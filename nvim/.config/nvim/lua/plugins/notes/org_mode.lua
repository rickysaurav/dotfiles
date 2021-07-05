local org_mode = {
    "kristijanhusak/orgmode.nvim",
    ft = {"org"},
    config = function()
        require('orgmode').setup({
            org_agenda_files = {"~/pCloudDrive/org/agenda"},
            org_default_notes_file = "~/pCloudDrive/org/refile.org"
        })
    end
}

return {org_mode}
