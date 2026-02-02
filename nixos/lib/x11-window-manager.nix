{ lib, pkgs, osConfig ? null }:
let
    osConf = if osConfig != null then osConfig else {};
    windowManagers = [
        { name = "i3"; path = [ "services" "xserver" "windowManager" "i3" "enable" ]; }
        { name = "awesome"; path = [ "services" "xserver" "windowManager" "awesome" "enable" ]; }
        { name = "bspwm"; path = [ "services" "xserver" "windowManager" "bspwm" "enable" ]; }
        { name = "xmonad"; path = [ "services" "xserver" "windowManager" "xmonad" "enable" ]; }
        { name = "qtile"; path = [ "services" "xserver" "windowManager" "qtile" "enable" ]; }
        { name = "herbstluftwm"; path = [ "services" "xserver" "windowManager" "herbstluftwm" "enable" ]; }
    ];
    isEnabled = wm: (lib.attrByPath wm.path false osConf) == true;
    selected =
        # macOS does not have x11 windowManager
        if pkgs.stdenv.isLinux then
            lib.findFirst isEnabled null windowManagers
        else
            null;
in
    if selected == null then null else selected.name
