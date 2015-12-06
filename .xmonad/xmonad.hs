{-
    The original author of this config is David Brewer, with some mods by
    Jess Robertson.

    There are changes made by me (arnaudoff) as I got comfortable with XMonad.
-}

import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Layout.Grid
import XMonad.Layout.ResizableTile
import XMonad.Layout.IM
import XMonad.Layout.ThreeColumns
import XMonad.Layout.NoBorders
import XMonad.Layout.Circle
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Fullscreen
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Actions.Plane
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Data.Ratio ((%))

myModMask            = mod4Mask       -- changes the mod key to "Windows"
myFocusedBorderColor = "#080808"
myNormalBorderColor  = "#000000"
myBorderWidth        = 1
myTerminal           = "urxvt"

{-
  Xmobar configuration variables. These settings control the appearance
  of text which xmonad is sending to xmobar via the DynamicLog hook.
-}

myTitleColor     = "#727788"  -- color of window title
myTitleLength    = 80         -- truncate window title to this length
myCurrentWSColor = "#4CAD64"  -- color of active workspace
myVisibleWSColor = "#B8904C"  -- color of inactive workspace
myUrgentWSColor  = "#C2465F"  -- color of workspace with 'urgent' window
myCurrentWSLeft  = "["        -- wrap active workspace with these
myCurrentWSRight = "]"
myVisibleWSLeft  = "("        -- wrap inactive workspace with these
myVisibleWSRight = ")"
myUrgentWSLeft  = "{"         -- wrap urgent workspace with these
myUrgentWSRight = "}"


{-
    Changing those requires changes where they are referenced.
-}

myWorkspaces =
  [
    "", "", "",
    "4:chat", "5:dev", "6:media",
    "", "", ""
  ]

startupWorkspace = "5:dev"

{-
    Note that all layouts are wrapped within "avoidStruts". What this does
    is make the layouts avoid the status bar area at the top of the screen.
    Without this, they would overlap the bar. You can toggle this behavior
    by hitting "super-b" (bound to ToggleStruts in the keyboard bindings
    in the next section).
-}

-- Define group of default layouts used on most screens, in the
-- order they will appear.
-- "smartBorders" modifier makes it so the borders on windows only
-- appear if there is more than one visible window.
-- "avoidStruts" modifier makes it so that the layout provides
-- space for the status bar at the top of the screen.
defaultLayouts = smartBorders(avoidStruts(
  -- ResizableTall layout has a large master window on the left,
  -- and remaining windows tile on the right.
  ResizableTall 1 (3/100) (1/2) []

  -- Mirrored variation of ResizableTall. In this layout, the large
  -- master window is at the top, and remaining windows tile at the
  -- bottom of the screen.
  ||| Mirror (ResizableTall 1 (3/100) (1/2) [])

  -- Full layout makes every window full screen. When you toggle the
  -- active window, it will bring the active window to the front.
  ||| noBorders Full

  -- Grid layout tries to equally distribute windows in the available
  -- space, increasing the number of columns and rows as necessary.
  -- Master window is at top left.
  ||| Grid

  -- ThreeColMid layout puts the large master window in the center
  -- of the screen. As configured below, by default it takes of 3/4 of
  -- the available space. Remaining windows tile to both the left and
  -- right of the master window.
  ||| ThreeColMid 1 (3/100) (3/4)

  -- Circle layout places the master window in the center of the screen.
  -- Remaining windows appear in a circle around it
  ||| Circle))


myLayouts = defaultLayouts

{-
  It can be difficult to find a good list of keycodes for use
  in xmonad. I have found this page useful -- just look
  for entries beginning with "xK":

  http://xmonad.org/xmonad-docs/xmonad/doc-index-X.html

  Note that in the example below, the last three entries refer
  to nonstandard keys which do not have names assigned by
  xmonad.

  If you have special keys on your keyboard which you
  want to bind to specific actions, you can use the "xev"
  command-line tool to determine the code for a specific key.
  Launch the command, then type the key in question and watch
  the output.
-}

myKeyBindings =
  [
    ((myModMask, xK_b), sendMessage ToggleStruts)
    , ((myModMask, xK_a), sendMessage MirrorShrink)
    , ((myModMask, xK_z), sendMessage MirrorExpand)
    , ((myModMask, xK_p), spawn "gmrun")
    , ((myModMask, xK_u), focusUrgent)
    , ((0, 0x1008FF12), spawn "amixer -q set Master toggle")
    , ((0, 0x1008FF11), spawn "amixer -q set Master 10%-")
    , ((0, 0x1008FF13), spawn "amixer -q set Master 10%+")

    , ((myModMask, xK_v), spawn "urxvt -e vim")
    , ((myModMask, xK_g), spawn "google-chrome-stable &")
    , ((myModMask, xK_w), spawn "urxvt -e sh -c 'sudo wifi-menu'")
    , ((myModMask, xK_c), spawn "urxvt -e cmus")
    , ((myModMask, xK_i), spawn "urxvt -e irssi")
    , ((myModMask, xK_s), spawn "spotify &")
    , ((myModMask, xK_t), spawn "urxvt &")
    , ((myModMask, xK_r), spawn "urxvt -e rtorrent")
    , ((myModMask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock &")
  ]


{-
  Management hooks. You can use management hooks to enforce certain
  behaviors when specific programs or windows are launched. This is
  useful if you want certain windows to not be managed by xmonad,
  or sent to a specific workspace, or otherwise handled in a special
  way.

  Each entry within the list of hooks defines a way to identify a
  window (before the arrow), and then how that window should be treated
  (after the arrow).

  To figure out to identify your window, you will need to use a
  command-line tool called "xprop". When you run xprop, your cursor
  will temporarily change to crosshairs; click on the window you
  want to identify. In the output that is printed in your terminal,
  look for a couple of things:
    - WM_CLASS(STRING): values in this list of strings can be compared
      to "className" to match windows.
    - WM_NAME(STRING): this value can be compared to "resource" to match
      windows.

  The className values tend to be generic, and might match any window or
  dialog owned by a particular program. The resource values tend to be
  more specific, and will be different for every dialog. Sometimes you
  might want to compare both className and resource, to make sure you
  are matching only a particular window which belongs to a specific
  program.

  Once you've pinpointed the window you want to manipulate, here are
  a few examples of things you might do with that window:
    - doIgnore: this tells xmonad to completely ignore the window. It will
      not be tiled or floated. Useful for things like launchers and
      trays.
    - doFloat: this tells xmonad to float the window rather than tiling
      it. Handy for things that pop up, take some input, and then go away,
      such as dialogs, calculators, and so on.
    - doF (W.shift "Workspace"): this tells xmonad that when this program
      is launched it should be sent to a specific workspace. Useful
      for keeping specific tasks on specific workspaces. In the example
      below I have specific workspaces for chat, development, and
      editing images.
-}

myManagementHooks :: [ManageHook]
myManagementHooks = [
    (title =? "rtorrent") --> doF (W.shift "6:media")
  , (title =? "irssi") --> doF (W.shift "4:chat")
  , (title =? "vim") --> doF (W.shift "5:dev")
  , (resource =? "Google-chrome") --> doF (W.shift "6:media")
  , (title =? "cmus") --> doF (W.shift "6:media")
  , (className =? "spotify") --> doF (W.shift "6:media")
  ]

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

{-
  Workspace navigation keybindings. This is probably the part of the
  configuration I have spent the most time messing with, but understand
  the least. Be very careful if messing with this section.
-}

-- We define two lists of keycodes for use in the rest of the
-- keyboard configuration. The first is the list of numpad keys,
-- in the order they occur on the keyboard (left to right and
-- top to bottom). The second is the list of number keys, in an
-- order corresponding to the numpad. We will use these to
-- make workspace navigation commands work the same whether you
-- use the numpad or the top-row number keys. And, we also
-- use them to figure out where to go when the user
-- uses the arrow keys.
numPadKeys =
  [
    xK_KP_Home, xK_KP_Up, xK_KP_Page_Up
    , xK_KP_Left, xK_KP_Begin,xK_KP_Right
    , xK_KP_End, xK_KP_Down, xK_KP_Page_Down
    , xK_KP_Insert, xK_KP_Delete, xK_KP_Enter
  ]

numKeys =
  [
    xK_7, xK_8, xK_9
    , xK_4, xK_5, xK_6
    , xK_1, xK_2, xK_3
    , xK_0, xK_minus, xK_equal
  ]

-- Here, some magic occurs that I once grokked but has since
-- fallen out of my head. Essentially what is happening is
-- that we are telling xmonad how to navigate workspaces,
-- how to send windows to different workspaces,
-- and what keys to use to change which monitor is focused.
myKeys = myKeyBindings ++
  [
    ((m .|. myModMask, k), windows $ f i)
       | (i, k) <- zip myWorkspaces numPadKeys
       , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
  ] ++
  [
    ((m .|. myModMask, k), windows $ f i)
       | (i, k) <- zip myWorkspaces numKeys
       , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
  ] ++
  M.toList (planeKeys myModMask (Lines 4) Finite) ++
  [
    ((m .|. myModMask, key), screenWorkspace sc
      >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [1,0,2]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
  ]


{-
  Here we actually stitch together all the configuration settings
  and run xmonad. We also spawn an instance of xmobar and pipe
  content into it via the logHook..
-}

main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
    focusedBorderColor = myFocusedBorderColor
  , normalBorderColor = myNormalBorderColor
  , focusFollowsMouse = myFocusFollowsMouse
  , terminal = myTerminal
  , borderWidth = myBorderWidth
  , layoutHook = myLayouts
  , workspaces = myWorkspaces
  , modMask = myModMask
  , handleEventHook = fullscreenEventHook
  , startupHook = do
      setWMName "LG3D"
      windows $ W.greedyView startupWorkspace
      spawn "~/.xmonad/startup-hook"
  , manageHook = manageHook defaultConfig
      <+> composeAll myManagementHooks
      <+> manageDocks
  , logHook = dynamicLogWithPP $ xmobarPP {
      ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor myTitleColor "" . shorten myTitleLength
      , ppCurrent = xmobarColor myCurrentWSColor ""
        . wrap myCurrentWSLeft myCurrentWSRight
      , ppVisible = xmobarColor myVisibleWSColor ""
        . wrap myVisibleWSLeft myVisibleWSRight
      , ppUrgent = xmobarColor myUrgentWSColor ""
        . wrap myUrgentWSLeft myUrgentWSRight
    }
  }
    `additionalKeys` myKeys
