local c = require "colors"

local function section(a_fg, a_bg)
    return {
        a = { fg = a_fg, bg = a_bg },
        b = { fg = c.gray_light, bg = c.black },
        c = { fg = c.gray_soft, bg = c.black },
    }
end

return {
    normal   = section(c.black, c.blue),
    insert   = section(c.black, c.green),
    visual   = section(c.black, c.purple),
    replace  = section(c.black, c.red),
    command  = section(c.black, c.white_soft),
    terminal = section(c.black, c.white_soft),
    inactive = section(c.gray_dark, c.black),
}
