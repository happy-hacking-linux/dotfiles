import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import System.Posix.Env

import qualified XMonad.StackSet as W
import qualified Data.Map as M
--import qualified System.IO.UTF8        as U
import qualified XMonad.Actions.Search as S
import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Prompt         as P

import XMonad.Layout.WindowNavigation
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane
import XMonad.Layout.MosaicAlt
import XMonad.Layout.Combo
import XMonad.Layout.WindowNavigation
import XMonad.Layout.Cross

import XMonad.Layout.PerWorkspace

import XMonad.Layout.NoBorders

myManageHook = composeAll
    [
      className =? "Emacs"            --> doF (W.shift "code"),
      className =? "delicious-surf"   --> doF (W.shift "www"),
      className =? "Firefox"          --> doF (W.shift "www"),
      className =? "Chromium-browser" --> doF (W.shift "www")
    ]

myKeys =
    [
      ((mod4Mask, xK_p), spawn "dmenu_run"),
      ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s"),
      ((mod4Mask, xK_o), sendMessage ToggleStruts),
      ((mod4Mask, xK_a), windows (W.view "home")),
      ((mod4Mask, xK_s), windows (W.view "code")),
      ((mod4Mask, xK_d), windows (W.view "www")),
      ((0, xK_Print), spawn "scrot")
       -- multimedia keys
       -- XF86AudioLowerVolume
       , ((0            , 0x1008ff11), spawn "ossmix -- vmix0-outvol -2")
       -- XF86AudioRaiseVolume
       , ((0            , 0x1008ff13), spawn "ossmix vmix0-outvol +2")
       -- XF86AudioMute
       , ((0            , 0x1008ff12), spawn "amixer -q set PCM toggle")
       -- XF86AudioNext
       , ((0            , 0x1008ff17), spawn "mocp -f")
       -- XF86AudioPrev
       , ((0            , 0x1008ff16), spawn "mocp -r")
       -- XF86AudioPlay
       , ((0            , 0x1008ff14), spawn "mocp -G")
    ]
    where modMask     = mod1Mask
          modShft     = modMask .|. shiftMask
          modCtrl     = modMask .|. controlMask
          modShCr     = modMask .|. shiftMask .|. controlMask
          modMod2     = mod2Mask
          modM1Cr     = modMask .|. mod2Mask .|. controlMask
          search      = SM.submap $ searchMap $ S.promptSearch P.defaultXPConfig
          nilMask     = 0
          jstShft     = shiftMask
          searchMap m = M.fromList $
              [ ((nilMask, xK_g), m S.google),
                ((nilMask, xK_w), m S.wikipedia),
                ((nilMask, xK_i), m S.imdb)
              ]

myTabConfig = defaultTheme { inactiveColor = "#050505", activeColor = "#050505",  inactiveBorderColor = "#050505", inactiveTextColor = "#666666", activeBorderColor = "#050505", activeTextColor = "#eeeeee"}

main = do
    putEnv "BROWSER=w3"
    xmproc <- spawnPipe "xmobar $HOME/.xmonad/xmobar.hs"
    xmonad $ defaultConfig {
        -- basic conf
        modMask            = mod4Mask,
        terminal           = "urxvt",
        borderWidth        = 2,
        workspaces         = ["home","www","code", "4", "5", "6", "7", "8", "9"],
        -- colors
        normalBorderColor  = "#002b36",
        focusedBorderColor = "#657b83",
        -- hooks
        manageHook = myManageHook <+> manageDocks,
       -- layoutHook = avoidStruts $ layoutHook defaultConfig,
        layoutHook      = windowNavigation $ smartBorders $ (avoidStruts (tall ||| Mirror tall ||| noBorders (tabbed shrinkText myTabConfig) ||| noBorders Full ||| onWorkspace "WWW" (tabbed shrinkText myTabConfig) tall)) ||| simpleCross,
        logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 100
                        }
        } `additionalKeys` myKeys
        where
          tall  = Tall 1 (3/100) (488/792)
          -- mosaic  = MosaicAlt M.empty
          -- combo   = combineTwo (TwoPane 0.03 (3/10)) (mosaic) (Full)
