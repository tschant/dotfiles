local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local gls = gl.section
gl.short_line_list = {"NvimTree", "vista", "dbui", "packer"}
local i = require("plugins.statusline.icons")
local c = require("plugins.statusline.colors")
local u = require("plugins.statusline.utils")
local diagnostic = require("plugins.statusline.providers.diagnostic")
local vcs = require("plugins.statusline.providers.vcs")
local fileinfo = require("plugins.statusline.providers.fileinfo")
local extension = require("plugins.statusline.providers.extension")
local buffer = require("plugins.statusline.providers.buffer")
local vimode = require("plugins.statusline.providers.vimode")

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
        highlight = {c.Color("act1"), c.Color("DarkGoldenrod2")}
    }
}

gls.left[2] = {
    ViModeSeperator = {
        provider = viModeSeperator,
        highlight = {c.Color("act1"), c.Color("DarkGoldenrod2")}
    }
}

gls.left[3] = {
    FileSize = {
        provider = fileSize,
        condition = u.buffer_not_empty,
        highlight = {c.Color("base"), c.Color("act1")}
    }
}

gls.left[4] = {
    FileName = {
        provider = fileName,
        condition = u.buffer_not_empty,
        separator = i.slant.Left,
        separator_highlight = {c.Color("purple"), c.Color("act1")},
        highlight = {c.Color("func"), c.Color("act1"), "bold"}
    }
}

gls.left[5] = {
    FileType = {
        provider = fileType,
        condition = u.buffer_not_empty,
        highlight = {c.Color("base"), c.Color("purple")}
    }
}

gls.left[6] = {
    GitIcon = {
        provider = function()
            return "  "
        end,
        condition = condition.check_git_workspace,
        separator = " ",
        separator_highlight = {"NONE", c.Color("bg")},
        highlight = {c.Color("orange"), c.Color("bg")}
    }
}

gls.left[7] = {
   GitBranch = {
       provider = gitBranch,
       condition = condition.check_git_workspace,
       separator = ' ',
       separator_highlight = {'NONE', c.Color('bg')},
       highlight = {c.Color('grey'), c.Color('bg')}
   }
}

gls.left[9] = {
   DiffAdd = {
       provider = 'DiffAdd',
       condition = condition.hide_in_width,
       icon = '  ',
       highlight = {c.Color('green'), c.Color('bg')}
   }
}

gls.left[10] = {
   DiffModified = {
       provider = 'DiffModified',
       condition = condition.hide_in_width,
       icon = ' 柳',
       highlight = {c.Color('blue'), c.Color('bg')}
   }
}

gls.left[11] = {
   DiffRemove = {
       provider = 'DiffRemove',
       condition = condition.hide_in_width,
       icon = '  ',
       highlight = {c.Color('red'), c.Color('bg')}
   }
}


gls.left[12] = {
    FiletTypeSeperator = {
        provider = filetTypeSeperator
    }
}

gls.left[13] = {
    DiagnosticError = {
        provider = diagnosticError,
        icon = " " .. i.bullet,
        highlight = {c.Color("error"), c.Color("act1")}
    }
}

gls.left[14] = {
    DiagnosticWarn = {
        provider = diagnosticWarn,
        icon = " " .. i.bullet,
        highlight = {c.Color("warning"), c.Color("act1")}
    }
}

gls.left[15] = {
    DiagnosticInfo = {
        provider = diagnosticInfo,
        icon = " " .. i.bullet,
        highlight = {c.Color("info"), c.Color("act1")}
    }
}

gls.left[16] = {
    DiagnosticEndSpace = {
        provider = diagnosticEndSpace,
        highlight = {c.Color("act1"), c.Color("act1")}
    }
}

gls.left[17] = {
    DiagnosticSeperator = {
        provider = diagnosticSeperator,
        highlight = {c.Color("purple"), c.Color("act1")}
    }
}

gls.right[1] = {
    FileFormat = {
        provider = fileFormat,
        highlight = {c.Color("base"), c.Color("purple")}
    }
}
gls.right[2] = {
    LineInfo = {
        provider = lineColumn,
        separator = " | ",
        separator_highlight = {c.Color("base"), c.Color("purple")},
        highlight = {c.Color("base"), c.Color("purple")}
    }
}
gls.right[3] = {
    PerCent = {
        provider = linePercent,
        separator = i.slant.Left,
        separator_highlight = {c.Color("act1"), c.Color("purple")},
        highlight = {c.Color("base"), c.Color("act1")}
    }
}
gls.right[4] = {
    ScrollBar = {
        provider = scrollBar,
        highlight = {c.Color("yellow"), c.Color("purple")}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = fileTypeName,
        separator = i.slant.Right,
        separator_highlight = {c.Color("purple"), c.Color("bg")},
        highlight = {c.Color("base"), c.Color("purple")}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = bufferIcon,
        separator = i.slant.Left,
        separator_highlight = {c.Color("purple"), c.Color("bg")},
        highlight = {c.Color("base"), c.Color("purple")}
    }
}