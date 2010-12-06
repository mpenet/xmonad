import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Actions.NoBorders
import System.IO

myManageHook = composeAll
    [ className =? "Gimp"            --> doFloat
     ,className =? "Skype"      --> doFloat
    ]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook
                        <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , normalBorderColor = "#333333"
        , focusedBorderColor = "#666666"
        , terminal = "urxvt"
        , modMask = mod4Mask
        }
        `additionalKeysP`
                 [("M-b", withFocused toggleBorder)
                 ]