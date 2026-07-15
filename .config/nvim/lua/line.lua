local c = require "colors"

local function section(a_fg, a_bg)
    return {
        a = { fg = a_fg, bg = a_bg },
        b = { fg = c.gray_light, bg = c.black },
        c = { fg = c.gray,       bg = c.black },
    }
end

return {
    inactive = section(c.gray_dark, c.black),
    visual   = section(c.black, c.t_red),
    replace  = section(c.black, c.t_red),
    normal   = section(c.black, c.t_blue),
    insert   = section(c.black, c.t_green),
    command  = section(c.black, c.white_soft),
    terminal = section(c.black, c.white_soft),
}
