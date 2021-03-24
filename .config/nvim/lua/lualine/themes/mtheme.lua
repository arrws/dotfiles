
local colors = {
  color2   = "#000000",
  color3   = "#ffee99",
  color4   = "#e6e1cf",
  color5   = "#14191f",
  color13  = "#b8cc52",
  color10  = "#36a3d9",
  color8   = "#f07178",
  color9   = "#e6e1cf",
}

local mtheme = {
  visual = {
    a = { fg = colors.color2, bg = colors.color3 , "bold", },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  replace = {
    a = { fg = colors.color2, bg = colors.color8 , "bold", },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  inactive = {
    c = { fg = colors.color4, bg = colors.color2 },
    a = { fg = colors.color4, bg = colors.color5 , "bold", },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  normal = {
    c = { fg = colors.color9, bg = colors.color2 },
    a = { fg = colors.color2, bg = colors.color10 , "bold", },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  insert = {
    a = { fg = colors.color2, bg = colors.color13 , "bold", },
    b = { fg = colors.color4, bg = colors.color5 },
  },
}

return mtheme

