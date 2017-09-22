import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Actions.NoBorders
import XMonad.Layout.NoBorders
import XMonad.Hooks.SetWMName
import qualified XMonad.StackSet as S
import System.IO

myManageHook = composeAll
    [ className =? "Gimp" --> doFloat ]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook
                        <+> manageHook defaultConfig
        , startupHook = setWMName "LG3D"
        , layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
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
                 , ("M-a", windows S.focusDown)
                 , ("M-q", windows S.focusUp)
                 ]
