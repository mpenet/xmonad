import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.NoBorders
main = xmonad
    gnomeConfig {
          modMask = mod4Mask
          , layoutHook  = smartBorders (layoutHook gnomeConfig)
    }