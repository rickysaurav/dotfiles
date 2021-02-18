local galaxyline = {
    "glepnir/galaxyline.nvim",
    branch = "main",
    event = {"FocusLost *", "CursorHold *"},
    -- some optional icons
    requires = {{"kyazdani42/nvim-web-devicons", opt = true}},
    -- your statusline
    config = function()
        require("packer.load")({"nvim-web-devicons"}, {}, _G.packer_plugins)
        local gl = require("galaxyline")
        local gls = gl.section
        gl.short_line_list = {"NvimTree", "vista", "dbui"}
        local function is_treesitter_active()
            return pcall(vim.treesitter.get_parser)
        end
        local function is_lsp_active()
            return #vim.lsp.buf_get_clients() > 0
        end
        local colors = {
            bg = "#282c34",
            line_bg = "#21242b",
            fg = "#c0c0c0",
            yellow = "#fabd2f",
            cyan = "#008080",
            darkblue = "#081633",
            green = "#afd700",
            orange = "#FF8800",
            purple = "#5d4d7a",
            magenta = "#c678dd",
            blue = "#51afef",
            red = "#ec5f67",
            pink = "#e4a1b2",
            lavender = "#bda3e7"
        }

        local buffer_not_empty = function()
            if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
                return true
            end
            return false
        end

        local function find_git_root()
            local path = vim.fn.expand("%:p:h")
            local get_git_dir = require("galaxyline.provider_vcs").get_git_dir
            return get_git_dir(path)
        end
        local checkwidth = function()
            local squeeze_width = vim.fn.winwidth(0) / 2
            if squeeze_width > 40 then return true end
            return false
        end
        local tabpage_icon_map = {
            "", "", "", "", "", "", "", "", ""
        }
        gls.left = {
            {
                FirstElement = {
                    provider = function() return "▊ " end,
                    highlight = {colors.blue, colors.line_bg}
                }
            }, {
                ViMode = {
                    provider = function()
                        -- auto change color according the vim mode
                        local mode_color =
                            {
                                n = colors.magenta,
                                i = colors.green,
                                v = colors.blue,
                                [""] = colors.blue,
                                V = colors.blue,
                                c = colors.red,
                                no = colors.magenta,
                                s = colors.orange,
                                S = colors.orange,
                                [""] = colors.orange,
                                ic = colors.yellow,
                                R = colors.purple,
                                Rv = colors.purple,
                                cv = colors.red,
                                ce = colors.red,
                                r = colors.cyan,
                                rm = colors.cyan,
                                ["r?"] = colors.cyan,
                                ["!"] = colors.red,
                                t = colors.red
                            }
                        vim.cmd("hi GalaxyViMode guifg=" ..
                                    mode_color[vim.fn.mode()])
                        return "  "
                    end,
                    highlight = {colors.red, colors.line_bg, "bold"}
                }
            }, {
                FileIcon = {
                    provider = "FileIcon",
                    condition = buffer_not_empty,
                    highlight = {
                        require("galaxyline.provider_fileinfo").get_file_icon_color,
                        colors.line_bg
                    }
                }
            }, {
                FileName = {
                    provider = {"FileName"},
                    condition = buffer_not_empty,
                    highlight = {colors.pink, colors.line_bg, "bold"}
                }
            }, {
                CurrentFunctionIcon = {
                    provider = function() return "  " end,
                    condition = is_lsp_active,
                    highlight = {colors.blue, colors.line_bg}
                }
            }, {
                CurrentFunction = {
                    provider = function()
                        return vim.b.lsp_current_function or ""
                    end,
                    condition = is_lsp_active,
                    highlight = {colors.pink, colors.line_bg}
                }
            }, {
                LeftEnd = {
                    provider = function() return "" end,
                    separator = "",
                    separator_highlight = {colors.bg, colors.line_bg},
                    highlight = {colors.line_bg, colors.line_bg}
                }
            }, {
                DiagnosticError = {
                    provider = "DiagnosticError",
                    icon = "  ",
                    highlight = {colors.red, colors.bg}
                }
            }, {Space = {provider = function() return " " end}}, {
                DiagnosticWarn = {
                    provider = "DiagnosticWarn",
                    icon = "  ",
                    highlight = {colors.blue, colors.bg}
                }
            }, {
                TreeSitterIcon = {
                    provider = function() return " פּ " end,
                    condition = is_treesitter_active,
                    highlight = {colors.blue, colors.bg}
                }
            }, {
                TreeSitter = {
                    provider = function()
                        return require"nvim-treesitter".statusline(30)
                    end,
                    condition = is_treesitter_active,
                    highlight = {colors.lavender, colors.bg}
                }
            }
        }
        gls.right = {
            {
                FileFormat = {
                    provider = "FileFormat",
                    separator = " ",
                    separator_highlight = {colors.bg, colors.line_bg},
                    highlight = {colors.pink, colors.line_bg}
                }
            }, {
                GitIcon = {
                    provider = function() return " " end,
                    separator = " ",
                    condition = find_git_root,
                    separator_highlight = {colors.blue, colors.line_bg},
                    highlight = {colors.blue, colors.line_bg}
                }
            }, {
                GitBranch = {
                    provider = "GitBranch",
                    condition = find_git_root,
                    highlight = {colors.lavender, colors.line_bg, "bold"}
                }
            }, {
                DiffAdd = {
                    provider = "DiffAdd",
                    condition = checkwidth,
                    icon = " ",
                    highlight = {colors.green, colors.line_bg}
                }
            }, {
                DiffModified = {
                    provider = "DiffModified",
                    condition = checkwidth,
                    icon = " ",
                    highlight = {colors.orange, colors.line_bg}
                }
            }, {
                DiffRemove = {
                    provider = "DiffRemove",
                    condition = checkwidth,
                    icon = " ",
                    highlight = {colors.red, colors.line_bg}
                }
            }, {
                LineInfo = {
                    provider = "LineColumn",
                    separator = "| ",
                    separator_highlight = {colors.blue, colors.line_bg},
                    highlight = {colors.pink, colors.line_bg}
                }
            }, {
                Time = {
                    provider = function()
                        return vim.fn.strftime("%H:%M") .. " "
                    end,
                    icon = "  ",
                    separator = " ",
                    separator_highlight = {colors.line_bg, colors.line_bg},
                    highlight = {colors.lavender, colors.darkblue}
                }
            }, {
                TabPageIcon = {
                    provider = function()
                        return (tabpage_icon_map[vim.api
                                   .nvim_tabpage_get_number(0)] or "") .. " "
                    end,
                    separator = " ",
                    separator_highlight = {colors.blue, colors.purple},
                    highlight = {colors.blue, colors.purple}
                }
            }
        }
        gls.short_line_left = {
            {
                BufferType = {
                    provider = "FileTypeName",
                    separator = "",
                    separator_highlight = {colors.purple, colors.bg},
                    highlight = {colors.fg, colors.purple}
                }
            }
        }

        gls.short_line_right = {
            {
                BufferIcon = {
                    provider = "BufferIcon",
                    separator = "",
                    separator_highlight = {colors.purple, colors.bg},
                    highlight = {colors.fg, colors.purple}
                }
            }
        }
        vim.cmd [[doautocmd galaxyline BufEnter]]
    end
}
return {galaxyline}
