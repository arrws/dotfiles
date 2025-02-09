local c = require("xtheme.colors")

return {
    visual = {
        a = { fg = c.black,    bg = c.pink,     },
        b = { fg = c.white,    bg = c.blackish  },
    },
    replace = {
        a = { fg = c.black,    bg = c.pink,     },
        b = { fg = c.white,    bg = c.blackish  },
    },
    inactive = {
        a = { fg = c.whiteish, bg = c.blackish, },
        b = { fg = c.whiteish, bg = c.blackish  },
        c = { fg = c.whiteish, bg = c.black     },
    },
    normal = {
        a = { fg = c.black,    bg = c.blue,     },
        b = { fg = c.white,    bg = c.blackish  },
        c = { fg = c.whiteish, bg = c.black     },
    },
    insert = {
        a = { fg = c.black,    bg = c.green,    },
        b = { fg = c.white,    bg = c.blackish  },
    },
    command = {
        a = { fg = c.black,    bg = c.red,      },
        b = { fg = c.white,    bg = c.blackish  },
    },
}
