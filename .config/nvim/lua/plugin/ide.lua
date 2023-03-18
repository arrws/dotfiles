require('mini.bufremove').setup()
require('mini.comment').setup()
require('mini.trailspace').setup()
require('mini.align').setup()
require('mini.pairs').setup()
require('mini.surround').setup()

require('mini.jump').setup({
    mappings = {
        forward = 'f',
        backward = 'F',
        forward_till = '',
        backward_till = '',
        repeat_jump = ''
    }
})

require('mini.jump2d').setup({
      -- Characters used for labels of jump spots (in supplied order)
      labels = 'abcdefghijklmnopqrstuvwxyz',
      -- Which lines are used for computing spots
      allowed_lines = {
        blank = true, -- Blank line (not sent to spotter even if `true`)
        cursor_before = true, -- Lines before cursor line
        cursor_at = true, -- Cursor line
        cursor_after = true, -- Lines after cursor line
        fold = true, -- Start of fold (not sent to spotter even if `true`)
      },
      -- Which windows from current tabpage are used for visible lines
      allowed_windows = {
        current = true,
        not_current = true,
      },
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        start_jumping = 't',
      },
    }
)

minimap = require('mini.move').setup({
  mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = '<left>',
      right = '<right>',
      down = '<down>',
      up = '<up>',
  
      -- Move current line in Normal mode
      line_left = '<left>',
      line_right = '<right>',
      line_down = '<down>',
      line_up = '<up>',
    },
    options = {
    -- Automatically reindent selection during linewise vertical move
    reindent_linewise = true,
  },
})

minimap = require('mini.map')
minimap.setup({
  integrations = { 
      minimap.gen_integration.diagnostic({
      error = 'DiagnosticFloatingError',
      warn  = 'DiagnosticFloatingWarn',
      info  = 'DiagnosticFloatingInfo',
      hint  = 'DiagnosticFloatingHint',
      }),
      minimap.gen_integration.gitsigns({
      add = 'GitSignsAdd',
      change  = 'GitSignsChange',
      delete  = 'GitSignsDelete',
      })
  },
  symbols = {
    encode = minimap.gen_encode_symbols.dot('3x2'),
    -- Scrollbar parts for view and line. Use empty string to disable any.
    scroll_line = '',
    scroll_view = '│',
  },
  window = {
    focusable = true,
    show_integration_count = false,
    side = 'right', -- window position left/right
    width = 10, -- window width
    winblend = 0, -- window transparency 0-100
  },
})

require("indent_blankline").setup({
    char = "│",
    buftype_exclude = {"terminal", "help", "NvimTree"}
})
