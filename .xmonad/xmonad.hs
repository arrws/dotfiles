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
import XMonad.Util.WorkspaceCompare

-- Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.Place
import XMonad.Hooks.EwmhDesktops hiding (fullscreenEventHook)
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
import XMonad.Layout.Fullscreen
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Renamed



my_keys_bindings :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
my_keys_bindings conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launching and killing programs
    [ ((modMask                 , xK_Return ), spawn $ XMonad.terminal conf)      -- launch default terminal
    , ((modMask                 , xK_p      ), spawn "./.scripts/dmenu.sh")       -- launch dmenu command search
    , ((modMask .|. shiftMask   , xK_p      ), spawn "./.scripts/dmusic.sh")      -- launch dmenu music search
    , ((modMask                 , xK_x      ), kill)                              -- close the focused window

    -- volume control
    , ((0                       , 0x1008ff11), spawn "amixer -q sset Master 5%- && ./.scripts/info_volume.sh")
    , ((0                       , 0x1008ff13), spawn "amixer -q sset Master 5%+ && ./.scripts/info_volume.sh")
    , ((0                       , 0x1008ff12), spawn "amixer set Master toggle && ./.scripts/info_volume.sh")

    -- brightness control
    , ((0                       , 0x1008ff02), spawn "light -A -r 50 && ./.scripts/info_brightness.sh")
    , ((0                       , 0x1008ff03), spawn "light -U -r 50 && ./.scripts/info_brightness.sh")
    , ((0                       , 0x1008ff81), spawn "xcalib -invert -alter")           -- invert colors

    --- redshift control
    , ((modMask                 , 0x1008ff02), spawn "./.scripts/info_redshift.sh -500")
    , ((modMask                 , 0x1008ff03), spawn "./.scripts/info_redshift.sh 500")
    , ((modMask                 , 0x1008ff81), spawn "./.scripts/info_redshift.sh 0")     -- reset redshift

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
    --, ((modMask                 , xK_q      ), sendMessage $ Toggle NBFULL)         -- go fullscreen
    , ((modMask                 , xK_space  ), sendMessage NextLayout)              -- rotate through the available layout algorithms
    , ((modMask .|. shiftMask   , xK_space  ), setLayout $ XMonad.layoutHook conf)  -- reset current workspace layout to default
    , ((modMask                 , xK_Tab    ), doTo Next NonEmptyWS getSortByIndex (windows . W.view))              -- move to next workspace
    , ((modMask .|. shiftMask   , xK_Tab    ), doTo Prev NonEmptyWS getSortByIndex (windows . W.view))              -- move to previous workspace

    -- focusing windows
    , ((modMask,                  xK_o      ), windows W.focusMaster)               -- focus master window
    , ((modMask,                  xK_d      ), windows W.focusDown)                 -- focus next window
    , ((modMask,                  xK_s      ), windows W.focusUp)                   -- focus previous window

    -- moving windows
    , ((modMask .|. shiftMask   , xK_o      ), windows W.swapMaster)                -- swap focused window with the master window
    , ((modMask .|. shiftMask   , xK_d      ), windows W.swapDown)                  -- swap focused window with the next window
    , ((modMask .|. shiftMask   , xK_s      ), windows W.swapUp)                    -- swap focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask                 , xK_a      ), sendMessage Shrink)                  -- shrink the master area
    , ((modMask                 , xK_f      ), sendMessage Expand)                  -- expand the master area
    , ((modMask                 , xK_c      ), refresh)                             -- reset window size

    -- -- increase or decrease number of windows in the master area
    -- , ((modMask                 , xK_comma  ), sendMessage (IncMasterN 1))          -- increment the number of windows in the master area
    -- , ((modMask                 , xK_period ), sendMessage (IncMasterN (-1)))       -- deincrement the number of windows in the master area

    -- quit, or restart
    , ((modMask .|. shiftMask   , xK_Escape ), io (exitWith ExitSuccess))               -- quit xmonad
    , ((modMask                 , xK_Escape ), spawn "if type xmonad; \
                                \ then xmonad --recompile && xmonad --restart; \
                                \ else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")  -- restart xmonad

    ] ++
    [ ((modMask                 , k         ), windows $ W.view i)                 -- switch to k-th workspace
                                            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    ] ++
    [ ((modMask .|. shiftMask   , k         ), (windows $ W.shift i)                     -- move window to the k-th workspace
                                            >> (windows $ W.view i))
                                            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    ]


-- mouse buttons for floating windows
my_mouse_bindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
my_mouse_bindings (XConfig {XMonad.modMask = modMask}) = M.fromList []

my_layout_hook = my_fullscreen ||| my_vertical ||| my_horizontal -- ||| my_spiral
                where
                    -- my_spiral       = renamed [Replace "Sprl"] $ my_gaps $ spiral (6/7)
                    my_fullscreen   = renamed [Replace "Full"] $ avoidStruts $ noBorders $ Full
                    my_vertical     = renamed [Replace "Vert"] $ my_gaps $ Tall 1 (3/100) (1/2)
                    my_horizontal   = renamed [Replace "Horz"] $ my_gaps $ Mirror $ Tall 1 (3/100) (1/2)
                    my_gaps layout  = let x = 3 in avoidStruts $ spacing x $ gaps [(U,x+20),(D,x),(R,x),(L,x)] layout


my_workspaces :: [WorkspaceId]
my_workspaces = ["λ", "main", "web"] ++ (map show [4 .. 9 :: Int])

my_manage_hook = composeAll
    [ className =? "Firefox"  --> doShift (my_workspaces !! 2)
    , className =? "Firefox"  --> viewShift (my_workspaces !! 2)
    -- , className =? "Google-chrome"  --> doShift (my_workspaces !! 1)
    -- , className =? "Google-chrome"  --> viewShift (my_workspaces !! 1)
    , fullscreenManageHook
    , manageHook defaultConfig ]
    where viewShift = doF . liftM2 (.) W.view W.shift


my_modmask = mod1Mask -- use ALT key
my_terminal = "xterm -bg black -fg white -fa Inconsolata -fs 11 zsh"

my_xmobarPP xmproc = xmobarPP {
    ppCurrent           = xmobarColor "green" "" . wrapBrackets
    , ppVisible         = xmobarColor "yellow" "" . wrapBrackets
    , ppHidden          = xmobarColor "grey" "" . wrapBrackets
    , ppHiddenNoWindows = xmobarColor "grey" "" . addSpace
    , ppOutput          = hPutStrLn xmproc
    , ppTitle           = xmobarColor "#77ffff" "" . shorten 80
    , ppSep             = "  "  -- space between WSs and title
    , ppWsSep           = ""    -- space inbetween WSs
    , ppLayout          = xmobarColor "orange" ""
    }
    where
        addSpace = (\x -> " " ++ x)
        wrapBrackets = wrap " [" "]"

main = do
        xmproc <- spawnPipe "xmobar"
        xmonad $ defaultConfig
            { terminal          = my_terminal
            , modMask           = my_modmask
            , workspaces        = my_workspaces
            , keys              = my_keys_bindings
            , mouseBindings     = my_mouse_bindings
            , focusFollowsMouse = True
            , clickJustFocuses  = True
            , normalBorderColor = "#000000"
            , focusedBorderColor= "#666666"

	    , handleEventHook   = fullscreenEventHook
            , manageHook        = manageDocks <+> my_manage_hook    -- manageHook defaultConfig
            , layoutHook        = avoidStruts $ my_layout_hook      -- layoutHook defaultConfig
            , logHook           = dynamicLogWithPP $ my_xmobarPP xmproc        -- load xmobar
            }


