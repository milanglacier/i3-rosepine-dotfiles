{ pkgs, config, osConfig, lib, ... }:
let
    shell = if (osConfig != null) then osConfig.users.users.${config.home.username}.shell else pkgs.zsh;
    systemWindowManager = if (osConfig != null) then osConfig.services.displayManager.defaultSession else null;
    windowManager = if (systemWindowManager != null) then systemWindowManager else "none+i3";
in {
    programs.${shell.pname} = {
        # Only startx if there is no DISPLAY and we are on the first
        # virtual terminal
        profileExtra = lib.mkOrder 1000 ''
            [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
        '';
    };

    home.file.".xinitrc".text = ''
        export QT_SCALE_FACTOR=2
        # This is required for IM working in kitty
        export GLFW_IM_MODULE=ibus
        export LIBGL_ALWAYS_SOFTWARE=1
        # Extract the session name (e.g., "i3" from "none+i3") and execute it.
        exec ${lib.last (builtins.split "\\+" windowManager)}
    '';
}
