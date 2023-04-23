local lush = require("lush")
local hsl = lush.hsl
local hsluv = lush.hsl

local theme = lush(function(injected_functions)
    local sym = injected_functions.sym

    -- Run :Lushify
    --
    -- Relative adjustment (rotate(), saturate(), desaturate(), lighten(), darken())
    -- Absolute adjustment (prefix above with abs_)
    -- Combination         (mix())
    -- Overrides           (hue(), saturation(), lightness())
    -- Access              (.h, .s, .l)
    -- Coercion            (tostring(), "Concatination: " .. color)
    -- Helpers             (readable())
    --
    -- Adjustment functions have shortcut aliases, ro, sa, de, li, da
    --                                             abs_sa, abs_de, abs_li, abs_da
    --
    -- Remember hue: [0-360], saturation and lightness: [0-100].
    -- (HSL will fix any invalid values internally.)
    --
    -- Option gui= ...
    --      bold:          boolean, bold.
    --      italic:        boolean, italics.
    --      underline:     boolean, underline.
    --      underlineline: boolean, double underline.
    --      underdouble:   boolean, underlineline in nvim 0.8
    --      undercurl:     boolean, undercurl.
    --      underdot:      boolean, underdot.
    --      underdotted:   boolean, underdot in nvim 0.8
    --      underdash:     boolean, underdash.
    --      underdashed:   boolean, underdash in nvim 0.8
    --      strikethrough: boolean, strikethrough.
    --      reverse:       boolean, flipping fg and bg values.
    --      standout:      boolean, standout.
    --      nocombine:     boolean, nocombine.
                                              

    local t = {
        it        = "italic",
        bo        = "bold",
        st        = "strikethrough",
        rv        = "reverse",
        white     = hsl(0,0,100),
        black     = hsl(0,0,0),
        red       = hsl(0,100,60),
        yellow    = hsl(60,100,60),
        green     = hsl(120,100,60),
        blue      = hsl(200,100,65),
        cyan      = hsl(180,100,50),
        selection = hsl(120,100,75),
        matches   = hsl(330,100,85),
    }

    return {
        -- ---- Buildin Groups
 
        -- default group
        Normal              { fg=t.white.da(20) , bg=t.black    },  -- normal text
        NormalNC            { fg=t.white.da(20) , bg=t.black    },  -- normal text in non-current windows

        -- floating windows
        NormalFloat         { fg=t.white.da(20) , bg=t.black    },  -- Normal text in floating windows.
        FloatBorder         { fg=t.black.li(40)                 },
 
        -- Cursor Highlighting
        Cursor              { fg=t.white.da(20)     },   -- char under the cursor
        lCursor             { Cursor                },   -- the char under the cursor when language-mappin
        CursorIM            { Cursor                },   -- like Cursor, but used when in IME mode CursorIM
        CursorLine          { bg=t.black.li(10)     },   -- Screen-column at the cursor, when cursorcolumn is set .
        CursorColumn        { CursorLine            },   -- Screen-line at the cursor  , when cursorline is set.  Low-priority if foreground (ctermfg OR guifg) is not set .
        TermCursor          { fg=t.black.li(25)     },   -- cursor in a focused terminal
        TermCursorNC        { TermCursor            },   -- cursor in an unfocused terminal
        Directory           {                       },   -- directory names (and other special names in listings)

        -- Conditional Line/Column Highlighting
        Conceal             {                       },  -- placeholder characters substituted for concealed text (see 'conceallevel')
        CursorLineNr        { fg=t.yellow.li(20)    },  -- Like LineNr when 'cursorline' or 'relativenumber' is set for  the cursor line.
        LineNr              { fg=t.white.da(60)     },  -- Line number for  :number and commands, and when 'number'or 'relativenumber' option is set.
        QuickFixLine        { bg=t.white.da(60)     },  -- Current quickfix item in the quickfix window. Combined with l-CursorLine when the cursor is there.
        Visual              { bg=t.white.da(80)     },  -- Visual mode selection
        VisualNOS           { Visual                },  -- Visual mode selection when vim is  Not Owning the Selection .
        ColorColumn         {                       },  -- columns color
        SignColumn          { fg=t.white.da(35)     },  -- column where signs are displayed
        Folded              {                       },  -- line used for closed folds
        FoldColumn          {                       },  -- foldcolumn
        VertSplit           { fg=t.black            },  -- column separating vertically split windows
        Title               {                       },  -- titles for output from :set all   :autocmd etc.


        -- Searching
        IncSearch           { fg=t.black , bg=t.matches , gui=t.bo  },  -- /smth 'incsearch' highlighting
        Search              { fg=t.black , bg=t.matches             },  -- /smth all other, last search pattern highlighting
        MatchParen          { fg=t.matches , bg=t.black , gui=t.bo  },  -- :%s/matching matched text highlighting
        Substitute          { fg=t.matches , bg=t.black , gui=t.bo  },  -- :%s/matching/substitute replacement text highlighting

        -- statusbar popup menu
        WildMenu            { fg=t.selection    , bg=t.black.li(10) },  -- active selection
        StatusLine          { fg=t.white.da(40) , bg=t.black.li(10) },  -- inactive selection
        StatusLineNC        { fg=t.black                            },  -- status lines of not-current windows
        StatusLineTerm      { StatusLine                            },
        StatusLineTermNC    { StatusLineNC                          },

        -- autocomplete popup menu
        PMenu               { StatusLine            },  -- Popup menu: normal item.
        PMenuSel            { WildMenu              },  -- Popup menu: selected item.
        PMenuSbar           { StatusLine            },  -- Popup menu: scrollbar.
        PMenuThumb          { StatusLine            },  -- Popup menu: Thumb of the scrollbar.

        -- tabs selection menu
        TabLine             { fg=t.white.da(40)     },  -- inactive tab text
        TabLineFill         {                       },  -- empty tab line color
        TabLineSel          { WildMenu              },  -- active tab text

        -- ---- OpenAI GPT
        AIIndicator         { fg=t.cyan             },  -- group to color the indicator text
        AIHighlight         { fg=t.matches          },  -- group to color the text being processed


        -- ---- Hop
        MiniJump2dSpot      {fg=t.cyan              },
        MiniJump            {fg=t.cyan , gui=t.bo   },


        -- ---- MiniMap
        MiniMapNormal       { fg=t.black.li(40)     },  -- basic highlight of whole window.
        MiniMapSymbolLine   { MiniMapNormal         },  -- scrollbar part representing current line.
        MiniMapSymbolView   { MiniMapNormal         },  -- scrollbar part representing current view.


        -- ---- Telescope
        TelescopeBorder     { FloatBorder               },
        TelescopeNormal     { Normal                    },
        TelescopeMatching   { fg=t.matches , gui=t.bo   },
        TelescopeSelection  { fg=t.selection            },


        -- ---- Nvim Tree View
        NvimTreeCursorColumn        { CursorColumn                  },
        NvimTreeCursorLine          { CursorLine                    },
        NvimTreeCursorLineNr        { CursorLineNr                  },
        NvimTreeNormal              { Normal                        },
        NvimTreePopup               { Normal                        },
        NvimTreeStatusLine          { StatusLine                    },
        NvimTreeStatusLineNC        { StatusLineNC                  },
        NvimTreeWindowPicker        { WildMenu                      },

        NvimTreeLiveFilterPrefix    { fg=t.matches, gui=t.bo        },
        NvimTreeLiveFilterValue     { Normal                        },

        NvimTreeLineNr              { LineNr                        },
        NvimTreeIndentMarker        { fg=t.black.li(30)             },
        NvimTreeFolderIcon          { NvimTreeIndentMarker          },
        NvimTreeClosedFolderIcon    { NvimTreeFolderIcon            },
        NvimTreeOpenedFolderIcon    { NvimTreeFolderIcon            },

        NvimTreeRootFolder          { fg=t.black.li(60)             },
        NvimTreeFolderName          { fg=t.green.li(40) , gui=t.it  },
        NvimTreeEmptyFolderName     { NvimTreeFolderName            },
        NvimTreeOpenedFolderName    { NvimTreeFolderName            },

        NvimTreeSpecialFile         { Normal                        },
        NvimTreeExecFile            { fg=t.blue.li(50)              },
        NvimTreeImageFile           { fg=t.black.li(50)             },
        NvimTreeSymlink             { fg=t.yellow.li(50)            },
        NvimTreeBookmark            { fg=t.red.li(60)               },



        -- Messages
        ErrorMsg                    { fg=t.red.li(20)               },   -- error messages on the command line
        WarningMsg                  { fg=t.yellow.de(40).li(20)     },   -- warning messages
        InfoMsg                     { fg=t.blue.de(40).li(20)       },   -- 'showmode' message (e.g., INSERT)
        HintMsg                     { fg=t.blue.de(70).li(20)       },   -- error messages on the command line
        ModeMsg                     { Normal                        },   -- 'showmode' message (e.g., INSERT)
        Question                    { Normal                        },   -- hit enter prompt and yes/no questions
        MsgArea                     { Normal                        },   -- Area for messages and cmdline
        MsgSeparator                { Normal                        },   -- Separator for scrolled messages, `msgsep` flag of 'display

        -- base highlight group. Other Diagnostic highlights link to this by default. See :h diagnostic-highlights 
        DiagnosticError             { ErrorMsg                      },
        DiagnosticWarn              { WarningMsg                    },
        DiagnosticInfo              { InfoMsg                       },
        DiagnosticHint              { HintMsg                       },

        NvimTreeLspDiagnosticsError       { DiagnosticError         },
        NvimTreeLspDiagnosticsHint        { DiagnosticHint          },
        NvimTreeLspDiagnosticsInformation { DiagnosticInfo          },
        NvimTreeLspDiagnosticsWarning     { DiagnosticWarn          },

        -- Git Signs
        GitSignsAdd                 { fg=t.green                    },
        GitSignsChange              { fg=t.yellow                   },
        GitSignsDelete              { fg=t.red                      },
        GitSignsStagedAdd           { fg=t.green.de(40).li(20)      },
        GitSignsStagedChange        { fg=t.red.li(20)               },
        GitSignsStagedDelete        { fg=t.yellow.de(40).li(20)     },
        GitSignsUntracked           { fg=t.blue.de(80).li(20)       },

        -- Inlay Hints
        InlayHints                  { fg=t.green.de(90).da(40)      },



        -- ---- Buildin Coding Syntax   

        -- Text
        Comment            { fg=hsl(0,0,45) , gui=t.it      },   -- any comment
        NonText            { fg=hsl(0,0,30)                 },   -- other chars that do not really exist in the text
        EndOfBuffer        { fg=hsl(0,0,25)                 },
        Whitespace         { fg=hsl(0,0,20)                 },

        -- Literals
        Constant           { fg=hsl(300,90,85)              },   -- any other constant
        Character          { fg=hsl(295,90,85)              },   -- char constant: c, \n
        String             { fg=hsl(290,90,85)              },   -- string constant: this is a string
        Number             { fg=hsl(270,90,85)              },   -- number constant: 234, 0xff
        Float              { fg=hsl(265,90,85)              },   -- floating point constant: 2.3e10
        Boolean            { fg=hsl(260,90,85)              },   -- boolean constant: TRUE, false

        -- Identifiers
        Identifier         { fg=hsl(0,0,80)                 },   -- any variable name
        Function           { fg=hsl(60,90,80)               },   -- function name (also: methods for classes)

        -- Syntax
        Statement          { fg=hsl(10,90,75)               },   -- statements
        Conditional        { fg=hsl(15,90,75)               },   -- if, then, else, endif, switch, etc.
        Repeat             { fg=hsl(20,90,75)               },   -- for, do, while, etc.
        Label              { fg=hsl(0,0,100)                },   -- case, default, etc.
        Operator           { fg=hsl(0,0,100)                },   -- sizeof, +, * etc.
        Keyword            { fg=hsl(210,100,80)             },   -- any other keyword
        Exception          { fg=hsl(200,100,70) , gui=t.it  },   -- try, catch, throw
        Noise              { fg=hsl(0,0,80)                 },

        -- Semantics
        StorageClass       { fg=hsl(105,60,70)              },   -- static, register, volatile, etc.
        Type               { fg=hsl(115,60,70)              },   -- int, long, char, etc.
        Structure          { fg=hsl(125,60,70)              },   -- struct, union, enum, etc.
        Typedef            { fg=hsl(135,60,70)              },   -- A typedef

        -- Meta Text
        PreProc            { fg=hsl(235,90,80)              },   -- Preprocessor generic ??? functoin params in typescript
        Include            { fg=hsl(230,90,80)              },   -- preprocessor #include
        Define             { fg=hsl(225,90,80)              },   -- preprocessor #define
        Macro              { fg=hsl(185,100,80) , gui=t.it  },   -- same as Define
        PreCondit          { fg=hsl(180,100,80) , gui=t.it  },   -- preprocessor #if, #else, #endif, etc.

        -- Edge Cases
        Special            { fg=hsl(30,80,80)               },   -- any special symbol
        SpecialChar        { fg=hsl(290,90,85)              },   -- special char in a constant
        SpecialKey         { fg=hsl(165,80,80)              },   -- special char in a constant
        SpecialComment     { fg=hsl(0,0,60) , gui=t.bo      },   -- special things inside a comment
        Tag                { fg=hsl(330,100,80)             },   -- you can use CTRL-] on this
        Delimiter          { fg=hsl(0,0,100)                },   -- char that needs attention
        Debug              { fg=hsl(0,0,80)                 },   -- debugging statements

        -- Help Syntax
        Underlined         { fg=hsl(230,30,70)              },  -- text that stands out, HTML links
        Ignore             { fg=hsl(0,0,70)                 },  -- left blank, hidden  hl-Ignore
        Error              { fg=hsl(0,30,70)                },  -- any erroneous construct
        Warning            { fg=hsl(40,30,70)               },
        Info               { fg=hsl(180,30,70)              },
        Todo               { fg=hsl(180,30,70)              },          
        Hint               { fg=hsl(100,30,70)              },



        -- TreeSitter
        sym"@boolean"               { Boolean       },
        sym"@character"             { Character     },
        sym"@character.special"     { SpecialChar   },
        sym"@comment"               { Comment       },
        sym"@conditional"           { Conditional   },
        sym"@constant"              { Constant      },
        sym"@constant.builtin"      { Special       },
        sym"@constant.macro"        { Define        },
        sym"@constructor"           { Special       },
        sym"@debug"                 { Debug         },
        sym"@define"                { Define        },
        sym"@exception"             { Exception     },
        sym"@field"                 { Identifier    },
        sym"@float"                 { Float         },
        sym"@function"              { Function      },
        sym"@function.builtin"      { Special       },
        sym"@function.macro"        { Macro         },
        sym"@include"               { Include       },
        sym"@keyword"               { Keyword       },
        sym"@label"                 { Label         },
        sym"@macro"                 { Macro         },
        sym"@method"                { Function      },
        sym"@namespace"             { Identifier    },
        sym"@number"                { Number        },
        sym"@operator"              { Operator      },
        sym"@parameter"             { Identifier    },
        sym"@preproc"               { PreProc       },
        sym"@property"              { Identifier    },
        sym"@punctuation"           { Delimiter     },
        sym"@repeat"                { Repeat        },
        sym"@storageclass"          { StorageClass  },
        sym"@string"                { String        },
        sym"@string.escape"         { SpecialChar   },
        sym"@string.special"        { SpecialChar   },
        sym"@structure"             { Structure     },
        sym"@tag"                   { Tag           },
        sym"@text.literal"          { Comment       },
        sym"@text.reference"        { Identifier    },
        sym"@text.title"            { Title         },
        sym"@text.todo"             { Todo          },
        sym"@text.underline"        { Underlined    },
        sym"@text.uri"              { Underlined    },
        sym"@type"                  { Type          },
        sym"@type.definition"       { Typedef       },
        sym"@variable"              { Identifier    },

    }
end)
return theme
