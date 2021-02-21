-- Core
import XMonad hiding( (|||) )
import XMonad.Layout.LayoutCombinators

import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.IO
import System.Exit
import Graphics.X11.Xlib
import Graphics.X11.ExtraTypes.XF86
import Data.List
import Data.Ratio ((%))
import Data.Bits ((.|.))
import Control.Monad (liftM2)

-- Prompts
import XMonad.Prompt
import XMonad.Prompt.Shell

-- Actions
import XMonad.Actions.MouseGestures
import XMonad.Actions.UpdatePointer
import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS

-- Utils
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Loggers
import XMonad.Util.EZConfig
import XMonad.Util.Scratchpad

-- Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.Place
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.FadeInactive

-- Layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.DecorationMadness
import XMonad.Layout.Spiral
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutHints
-- import XMonad.Layout.ToggleLayouts
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Gaps
-- import XMonad.Layout.Fullscreen
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Renamed



my_workspaces :: [WorkspaceId]
my_workspaces = ["one", "main", "alt", "web", "five", "six", "seven", "inf", "thrash"] -- + (map show [5 .. 9 :: Int])

my_ModMask :: KeyMask
my_ModMask = mod1Mask -- use ALT key
my_terminal = "kitty" -- "xterm -bg black -fg white" -- "urxvt"

my_dmenu = "dmenu_run -nb black -nf '#DDDDDD' -sb darkred -sf white -fn 'Source Code Pro-12.0:antialias=true' -p '>'"
my_dmenu_music_script = "mpc play \"$(mpc ls | sort | nl -nln -s' ' -ba \
                        \ | dmenu -nb black -nf '#DDDDDD' -sb darkblue -sf white -fn 'Source Code Pro-12.0:antialias=true' -p '>' -i -l 43 \
                        \ | cut -d' ' -f1)\""


my_keys_bindings :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
my_keys_bindings conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launching and killing programs
    [ ((modMask                 , xK_Return ), spawn $ XMonad.terminal conf)        -- launch default terminal
    , ((modMask                 , xK_p      ), spawn my_dmenu)                      -- launch dmenu command search
    , ((modMask .|. shiftMask   , xK_p      ), spawn my_dmenu_music_script)         -- launch dmenu music search
    , ((modMask                 , xK_x      ), kill)                                -- close the focused window

    -- volume control
    , ((0                       , 0x1008ff11), spawn "amixer -q sset Master 5%-")
    , ((0                       , 0x1008ff13), spawn "amixer -q sset Master 5%+")
    , ((0                       , 0x1008ff12), spawn "amixer set Master toggle")

    -- brightness control
    , ((0                       , 0x1008ff02), spawn "light -A 5")
    , ((0                       , 0x1008ff03), spawn "light -U 5")
    , ((modMask                 , xK_i      ), spawn "xcalib -invert -alter")           -- invert colors

    -- screenshots
    , ((modMask                 , xK_Print  ), spawn "sleep 0.2; scrot `date +%s`.png -s -z -e 'mv $f ~/screenshots'")
    , ((0                       , xK_Print  ), spawn "scrot `date +%s`.png -z -e 'mv $f ~/screenshots'")

    -- music control
    , ((modMask                 , xK_Up     ), spawn "mpc random")
    , ((modMask                 , xK_Down   ), spawn "mpc toggle")
    , ((modMask                 , xK_Left   ), spawn "mpc prev")
    , ((modMask                 , xK_Right  ), spawn "mpc next")
    , ((modMask .|. shiftMask   , xK_Right  ), spawn "mpc seek +2%")
    , ((modMask .|. shiftMask   , xK_Left   ), spawn "mpc seek -2%")


    -- workspaces management
    , ((modMask                 , xK_q      ), sendMessage $ Toggle NBFULL)         -- go fullscreen
    , ((modMask                 , xK_space  ), sendMessage NextLayout)              -- rotate through the available layout algorithms
    , ((modMask .|. shiftMask   , xK_space  ), setLayout $ XMonad.layoutHook conf)  -- reset current workspace layout to default
    , ((modMask                 , xK_Tab    ), moveTo Next NonEmptyWS)              -- move to next workspace
    , ((modMask .|. shiftMask   , xK_Tab    ), moveTo Prev NonEmptyWS)              -- move to previous workspace

    -- focusing windows
    , ((modMask,                  xK_o      ), windows W.focusMaster)               -- focus master window
    , ((modMask,                  xK_j      ), windows W.focusDown)                 -- focus next window
    , ((modMask,                  xK_k      ), windows W.focusUp)                   -- focus previous window

    -- moving windows
    , ((modMask .|. shiftMask   , xK_o      ), windows W.swapMaster)                -- swap focused window with the master window
    , ((modMask .|. shiftMask   , xK_j      ), windows W.swapDown)                  -- swap focused window with the next window
    , ((modMask .|. shiftMask   , xK_k      ), windows W.swapUp)                    -- swap focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask                 , xK_h      ), sendMessage Shrink)                  -- shrink the master area
    , ((modMask                 , xK_l      ), sendMessage Expand)                  -- expand the master area
    , ((modMask                 , xK_n      ), refresh)                             -- reset window size

    -- -- increase or decrease number of windows in the master area
    -- , ((modMask                 , xK_comma  ), sendMessage (IncMasterN 1))          -- increment the number of windows in the master area
    -- , ((modMask                 , xK_period ), sendMessage (IncMasterN (-1)))       -- deincrement the number of windows in the master area

    -- quit, or restart
    , ((modMask .|. shiftMask   , xK_Escape ), io (exitWith ExitSuccess))               -- quit xmonad
    , ((modMask                 , xK_Escape ), spawn "if type xmonad; \
                                \ then xmonad --recompile && xmonad --restart; \
                                \ else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")  -- restart xmonad

    ] ++
    [ ((modMask                 , k         ), windows $ W.greedyView i)                 -- switch to k-th workspace
                                            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    ] ++
    [ ((modMask .|. shiftMask   , k         ), (windows $ W.shift i)                     -- move window to the k-th workspace
                                            >> (windows $ W.greedyView i))
                                            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    ]


-- mouse buttons for floating windows
my_mouse_bindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
my_mouse_bindings (XConfig {XMonad.modMask = modMask}) = M.fromList []
-- my_mouse_bindings (XConfig {XMonad.modMask = modMask}) = M.fromList
--     [ ((modMask,    button1 ), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)     -- set the window to floating mode and move by dragging
--     , ((modMask,    button2 ), windows . (W.shiftMaster .) . W.focusWindow)                     -- raise the window to the top of the stack
--     , ((modMask,    button3 ), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)   -- set the window to floating mode and resize by dragging
--     -- you may also bind events to the mouse scroll wheel (button4 and button5)
--     , ((modMask,    button4 ), withFocused $ windows . W.sink)                                  -- push window back into tiling
--     ]


my_layout_hook = mkToggle (single NBFULL) $ my_maximize ||| my_vertical ||| my_horizontal -- ||| my_spiral
                where
                    -- my_spiral       = renamed [Replace "Sprl"] $ my_gaps $ spiral (6/7)
                    -- my_fullscreen   = renamed [Replace "Full"] $ avoidStruts $ noBorders $ Full
                    my_maximize     = renamed [Replace "Maxi"] $ my_gaps $ Full
                    my_vertical     = renamed [Replace "Vert"] $ my_gaps $ Tall 1 (3/100) (1/2)
                    my_horizontal   = renamed [Replace "Horz"] $ my_gaps $ Mirror $ Tall 1 (3/100) (1/2)
                    my_gaps layout  = let x = 3 in avoidStruts $ spacing x $ gaps [(U,x+20),(D,x),(R,x),(L,x)] layout


my_manage_hook = composeAll
    [ className =? "Firefox"  --> doShift (my_workspaces !! 3)
    , className =? "Firefox"  --> viewShift (my_workspaces !! 3)
    -- , className =? "Google-chrome"  --> doShift (my_workspaces !! 1)
    -- , className =? "Google-chrome"  --> viewShift (my_workspaces !! 1)
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    , manageHook defaultConfig ]
    where viewShift = doF . liftM2 (.) W.greedyView W.shift


main = do
        xmproc <- spawnPipe "xmobar"
        xmonad $ defaultConfig
            { terminal          = my_terminal
            , modMask           = my_ModMask
            , workspaces        = my_workspaces
            , keys              = my_keys_bindings
            , mouseBindings     = my_mouse_bindings
            , focusFollowsMouse = True
            , clickJustFocuses  = True
            , normalBorderColor = "#222222"
            , focusedBorderColor= "#666666"

            , handleEventHook   = fullscreenEventHook
            , manageHook        = manageDocks <+> my_manage_hook    -- manageHook defaultConfig
            , layoutHook        = avoidStruts $ my_layout_hook      -- layoutHook defaultConfig
            , logHook           = dynamicLogWithPP xmobarPP         -- load xmobar
                    { ppOutput  = hPutStrLn xmproc
                    , ppTitle   = xmobarColor "lightblue" "" . shorten 50
                    , ppSep     = "  "  -- space between WSs and title
                    , ppWsSep   = " "
                    , ppLayout  = xmobarColor "orange" ""
                    }
            }


