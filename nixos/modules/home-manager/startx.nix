{ pkgs, config, osConfig, lib, ... }: {
    imports = [ ./options.nix ];

    programs.${config.milanglacier.shell} =
        lib.mkIf (config.milanglacier.x11.windowManager.name != null) {
            # Only startx if there is no DISPLAY and we are on the first
            # virtual terminal
            profileExtra = lib.mkOrder 1000 ''
            [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
            '';
        };

    home.file.".xinitrc" = lib.mkIf (config.milanglacier.x11.windowManager.name != null) {
        # Extract the session name (e.g., "i3" from "none+i3") and execute it.
        text = ''
            exec ${config.milanglacier.x11.windowManager.name}
        '';
    };
}
