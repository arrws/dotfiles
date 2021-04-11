
local colors = {
    black    = "#000000",
    darkgray = "#303030",
    white    = "#ffffff",
    whiteish = "#dadada",
    green    = "#99df87 ",
    blue     = "#36a3d9",
    red      = "#ff5f5f",
}

local mtheme = {
    visual = {
        a = { fg = colors.black,    bg = colors.yellow,     },
        b = { fg = colors.white,    bg = colors.darkgray    },
    },
    replace = {
        a = { fg = colors.black,    bg = colors.red,        },
        b = { fg = colors.white,    bg = colors.darkgray    },
    },
    inactive = {
        a = { fg = colors.whiteish, bg = colors.darkgray,   },
        b = { fg = colors.whiteish, bg = colors.darkgray    },
        c = { fg = colors.whiteish, bg = colors.black       },
    },
    normal = {
        a = { fg = colors.black,    bg = colors.blue,       },
        b = { fg = colors.white,    bg = colors.darkgray    },
        c = { fg = colors.whiteish, bg = colors.black       },
    },
    insert = {
        a = { fg = colors.black,    bg = colors.green,      },
        b = { fg = colors.white,    bg = colors.darkgray    },
    },
    command = {
        a = { fg = colors.black,    bg = colors.red,        },
        b = { fg = colors.white,    bg = colors.darkgray    },
    },
}

return mtheme

