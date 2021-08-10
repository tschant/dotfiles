local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local gls = gl.section
gl.short_line_list = {"NvimTree", "vista", "dbui", "packer"}
local i = require("plugin-configs.statusline.icons")
local c = require("plugin-configs.statusline.colors")
local u = require("plugin-configs.statusline.utils")
local diagnostic = require("plugin-configs.statusline.providers.diagnostic")
local vcs = require("plugin-configs.statusline.providers.vcs")
local fileinfo = require("plugin-configs.statusline.providers.fileinfo")
local extension = require("plugin-configs.statusline.providers.extension")
local buffer = require("plugin-configs.statusline.providers.buffer")
local vimode = require("plugin-configs.statusline.providers.vimode")

bufferIcon = buffer.get_buffer_type_icon
bufferNumber = buffer.get_buffer_number
diagnosticError = diagnostic.get_diagnostic_error
diagnosticWarn = diagnostic.get_diagnostic_warn
diagnosticInfo = diagnostic.get_diagnostic_info
diagnosticEndSpace = diagnostic.end_space
diagnosticSeperator = diagnostic.seperator
diffAdd = vcs.diff_add
diffModified = vcs.diff_modified
diffRemove = vcs.diff_remove
fileFormat = fileinfo.get_file_format
fileEncode = fileinfo.get_file_encode
fileSize = fileinfo.get_file_size
fileIcon = fileinfo.get_file_icon
fileName = fileinfo.get_current_file_name
fileType = fileinfo.get_file_type
fileTypeName = buffer.get_buffer_filetype
filetTypeSeperator = fileinfo.filetype_seperator
gitBranch = vcs.get_git_branch_formatted
gitSeperator = vcs.seperator
lineColumn = fileinfo.line_column
linePercent = fileinfo.current_line_percent
scrollBar = extension.scrollbar_instance
space = u.space
viMode = vimode.get_mode
viModeSeperator = vimode.seperator

gls.left[1] = {
    ViMode = {
        provider = viMode,
        separator = "  ",
				separator_highlight = {"NONE", c.Color("act1")},
        highlight = {c.Color("act1"), c.Color("DarkGoldenrod2")}
    }
}

gls.left[3] = {
    FileName = {
        provider = fileName,
        condition = u.buffer_not_empty,
        separator = i.slant.Left,
        separator_highlight = {c.Color("cyan"), c.Color("act1")},
        highlight = {c.Color("SkyBlue2"), c.Color("act1"), "bold"}
    }
}

gls.left[4] = {
    FileType = {
        provider = fileType,
        condition = u.buffer_not_empty,
        highlight = {c.Color("base"), c.Color("cyan")}
    }
}

gls.left[5] = {
    GitIcon = {
        provider = function()
            return "  "
        end,
        condition = condition.check_git_workspace,
        separator = " ",
        separator_highlight = {"NONE", c.Color("act1")},
        highlight = {c.Color("orange"), c.Color("act1")}
    }
}

gls.left[6] = {
   GitBranch = {
       provider = gitBranch,
       condition = condition.check_git_workspace,
       separator = ' ',
       separator_highlight = {'NONE', c.Color('act1')},
       highlight = {c.Color('base'), c.Color('act1')}
   }
}

gls.left[7] = {
   DiffAdd = {
       provider = 'DiffAdd',
       condition = condition.hide_in_width,
       icon = '  ',
       highlight = {c.Color('green'), c.Color('act1')}
   }
}

gls.left[8] = {
   DiffModified = {
       provider = 'DiffModified',
       condition = condition.hide_in_width,
       icon = ' 柳',
       highlight = {c.Color('blue'), c.Color('act1')}
   }
}

gls.left[9] = {
   DiffRemove = {
       provider = 'DiffRemove',
       condition = condition.hide_in_width,
       icon = '  ',
       highlight = {c.Color('red'), c.Color('act1')}
   }
}

gls.left[10] = {
    DiagnosticError = {
        provider = diagnosticError,
        icon = " " .. i.bullet,
        highlight = {c.Color("error"), c.Color("act1")}
    }
}

gls.left[11] = {
    DiagnosticWarn = {
        provider = diagnosticWarn,
        icon = " " .. i.bullet,
        highlight = {c.Color("warning"), c.Color("act1")}
    }
}

gls.left[12] = {
    DiagnosticInfo = {
        provider = diagnosticInfo,
        icon = " " .. i.bullet,
        highlight = {c.Color("info"), c.Color("act1")}
    }
}

gls.left[13] = {
    DiagnosticEndSpace = {
        provider = diagnosticEndSpace,
        highlight = {c.Color("act1"), c.Color("act1")}
    }
}

gls.left[14] = {
    DiagnosticSeperator = {
        provider = diagnosticSeperator,
        highlight = {c.Color("cyan"), c.Color("act1")}
    }
}

gls.right[1] = {
    FileSize = {
        provider = fileSize,
        condition = u.buffer_not_empty,
        highlight = {c.Color("base"), c.Color("act1")}
    }
}

gls.right[2] = {
    FileFormat = {
        provider = fileFormat,
        separator = " ",
				separator_highlight = {"NONE", c.Color("cyan")},
        highlight = {c.Color("base"), c.Color("cyan")}
    }
}
gls.right[3] = {
    LineInfo = {
        provider = lineColumn,
        separator = " | ",
        separator_highlight = {c.Color("base"), c.Color("cyan")},
        highlight = {c.Color("base"), c.Color("cyan")}
    }
}
gls.right[4] = {
    PerCent = {
        provider = linePercent,
        separator = i.slant.Left,
        separator_highlight = {c.Color("act1"), c.Color("cyan")},
        highlight = {c.Color("base"), c.Color("act1")}
    }
}
gls.right[5] = {
    ScrollBar = {
        provider = scrollBar,
        highlight = {c.Color("SkyBlue2"), c.Color("cyan")}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = fileTypeName,
        separator = i.slant.Right,
        separator_highlight = {c.Color("cyan"), c.Color("bg")},
        highlight = {c.Color("base"), c.Color("cyan")}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = bufferIcon,
        separator = i.slant.Left,
        separator_highlight = {c.Color("cyan"), c.Color("bg")},
        highlight = {c.Color("base"), c.Color("cyan")}
    }
}
