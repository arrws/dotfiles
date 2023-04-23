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


myKeysBindings :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeysBindings conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launching and killing programs
    [ ((modMask                 , xK_Return ), spawn $ XMonad.terminal conf)    -- launch default terminal
    , ((modMask                 , xK_g      ), spawn ".bin/dmenu.sh")           -- launch dmenu command search
    , ((modMask .|. shiftMask   , xK_g      ), spawn ".bin/dmusic.sh")          -- launch dmenu music search
    , ((modMask                 , xK_x      ), kill)                            -- close the focused window

    -- volume control
    , ((0                       , 0x1008ff11), spawn "amixer -q sset Master 5%- && .bin/info_volume.sh")
    , ((0                       , 0x1008ff13), spawn "amixer -q sset Master 5%+ && .bin/info_volume.sh")
    , ((0                       , 0x1008ff12), spawn "amixer set Master toggle && .bin/info_volume.sh")

    -- brightness control
    , ((0                       , 0x1008ff02), spawn "light -A -r 50 && .bin/info_brightness.sh")
    , ((0                       , 0x1008ff03), spawn "light -U -r 50 && .bin/info_brightness.sh")
    , ((0                       , 0x1008ff81), spawn "xcalib -invert -alter")       -- invert colors

    --- redshift control
    , ((modMask                 , 0x1008ff02), spawn ".bin/info_redshift.sh -500")
    , ((modMask                 , 0x1008ff03), spawn ".bin/info_redshift.sh 500")
    , ((modMask                 , 0x1008ff81), spawn ".bin/info_redshift.sh 0")     -- reset redshift

    -- screenshots
    , ((modMask                 , xK_Print  ), spawn "sleep 0.2; scrot `date +'%Y-%m-%d-%H%M%S%N`.png -s -z -e 'mv $f ~/screenshots/$f'")
    , ((0                       , xK_Print  ), spawn "scrot `date +'%Y-%m-%d-%H%M%S%N`.png -z -e 'mv $f ~/screenshots/$f'")

    -- -- music control
    -- , ((modMask                 , xK_Up     ), spawn "mpc random")
    -- , ((modMask                 , xK_Down   ), spawn "mpc toggle")
    -- , ((modMask                 , xK_Left   ), spawn "mpc prev")
    -- , ((modMask                 , xK_Right  ), spawn "mpc next")
    -- , ((modMask .|. shiftMask   , xK_Right  ), spawn "mpc seek +2%")
    -- , ((modMask .|. shiftMask   , xK_Left   ), spawn "mpc seek -2%")

    -- workspaces management
    , ((modMask                 , xK_space  ), sendMessage NextLayout)              -- rotate through the available layout algorithms
    , ((modMask .|. shiftMask   , xK_space  ), setLayout $ XMonad.layoutHook conf)  -- reset current workspace layout to default
    , ((modMask                 , xK_Tab    ), doTo Next (Not emptyWS) getSortByIndex (windows . W.view))   -- move to next workspace
    , ((modMask .|. shiftMask   , xK_Tab    ), doTo Prev (Not emptyWS) getSortByIndex (windows . W.view))   -- move to previous workspace

    -- focusing windows
    , ((modMask                 , xK_r      ), windows W.focusMaster)               -- focus master window
    , ((modMask                 , xK_d      ), windows W.focusDown)                 -- focus next window
    , ((modMask                 , xK_s      ), windows W.focusUp)                   -- focus previous window

    -- moving windows
    , ((modMask .|. shiftMask   , xK_r      ), windows W.swapMaster)                -- swap focused window with the master window
    , ((modMask .|. shiftMask   , xK_d      ), windows W.swapDown)                  -- swap focused window with the next window
    , ((modMask .|. shiftMask   , xK_s      ), windows W.swapUp)                    -- swap focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask .|. shiftMask   , xK_minus  ), sendMessage Shrink)                  -- shrink the master area
    , ((modMask .|. shiftMask   , xK_equal  ), sendMessage Expand)                  -- expand the master area

    -- quit, or restart
    , ((modMask .|. shiftMask   , xK_Escape ), io exitSuccess)                      -- quit xmonad
    , ((modMask                 , xK_Escape ), spawn "if type xmonad; \
                                \ then xmonad --recompile && xmonad --restart; \
                                \ else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")  -- restart xmonad

    ] ++
    [ ((modMask                 , k ), windows $ W.view i)                          -- switch to k-th workspace
                                    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_5]
    ] ++
    [ ((modMask .|. shiftMask   , k ), windows ( W.shift i) >> windows ( W.view i)) -- move window to the k-th workspace
                                    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_5]
    ]


-- mouse buttons for floating windows
myMouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList []

myLayoutHook = myFullscreen ||| myVertical -- ||| myHorizontal -- ||| mySpiral
                where
                    myFullscreen   = renamed [Replace "Full"] $ avoidStruts $ noBorders Full
                    myVertical     = renamed [Replace "Vert"] $ myGaps $ Tall 1 (3/100) (1/2)
                    -- myHorizontal   = renamed [Replace "Horz"] $ myGaps $ Mirror $ Tall 1 (3/100) (1/2)
                    -- mySpiral       = renamed [Replace "Sprl"] $ myGaps $ spiral (6/7)
                    myGaps layout  = let x = 3 in avoidStruts $ spacing x $ gaps [(U,x+20),(D,x),(R,x),(L,x)] layout

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["λ", "Σ", "Ψ", "Γ", "Ω"]

-- myModmask = mod4Mask -- use Windows key
myModmask = mod1Mask -- use ALT key
myTerminal = "kitty"

-- myXmobarPP xmproc = xmobarPP {
myXmobarPP xmproc0 xmproc1 = xmobarPP {
    ppCurrent           = xmobarColor "#00DD00" "" . wrapBrackets
    , ppVisible         = xmobarColor "yellow" "" . wrapBrackets
    , ppHidden          = xmobarColor "grey" "" . wrapBrackets
    , ppHiddenNoWindows = xmobarColor "grey" "" . addSpace
    , ppTitle           = xmobarColor "#77ffff" "" . shorten 80
    , ppSep             = "  "  -- space between WSs and title
    , ppWsSep           = ""    -- space inbetween WSs
    , ppLayout          = xmobarColor "orange" ""
    -- , ppOutput          = hPutStrLn xmproc
    , ppOutput          = \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x
    }
    where
        addSpace = (" " ++)
        wrapBrackets = wrap " [" "]"

main = do
        -- xmproc <- spawnPipe "xmobar"
        xmproc0 <- spawnPipe "xmobar -x 0"
        xmproc1 <- spawnPipe "xmobar -x 1"
        xmonad $ def
            { terminal          = myTerminal
            , modMask           = myModmask
            , workspaces        = myWorkspaces
            , keys              = myKeysBindings
            , mouseBindings     = myMouseBindings
            , focusFollowsMouse = True
            , clickJustFocuses  = True
            , normalBorderColor = "#000000"
            , focusedBorderColor= "#666666"
            , handleEventHook   = fullscreenEventHook
            , manageHook        = manageDocks -- manageHook defaultConfig
            , layoutHook        = avoidStruts myLayoutHook      -- layoutHook defaultConfig
            -- , logHook           = dynamicLogWithPP $ myXmobarPP xmproc        -- load xmobar
            , logHook           = dynamicLogWithPP $ myXmobarPP xmproc0 xmproc1        -- load xmobar
            }
