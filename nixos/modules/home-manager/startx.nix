{ pkgs, config, osConfig, lib, ... }: {
    options.milanglacier.windowManager = {
        shell = lib.mkOption {
            type = lib.types.package;
            default = pkgs.zsh;
            description = ''
            The shell used to create the profile for launching the X server.
            This should likely be your interactive login shell.
            '';
        };
        name = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "The primary window manager session to be launched by startx.";
        };
    };

    config = let
        sysShell = if (osConfig != null) then osConfig.users.users.${config.home.username}.shell else null;
        sysSession = if (osConfig != null) then osConfig.services.displayManager.defaultSession else null;
        cfg = config.milanglacier.windowManager;
    in {
        milanglacier.windowManager = {
            shell = lib.mkIf (sysShell != null) (lib.mkDefault sysShell);
            name = lib.mkIf (sysSession != null) (lib.mkDefault sysSession);
        };

        programs.${cfg.shell.pname} = lib.mkIf (cfg.name != null) {
            # Only startx if there is no DISPLAY and we are on the first
            # virtual terminal
            profileExtra = lib.mkOrder 1000 ''
            [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
            '';
        };

        home.file.".xinitrc" = lib.mkIf (cfg.name != null) {
            # Extract the session name (e.g., "i3" from "none+i3") and execute it.
            text = ''
            exec ${lib.last (builtins.split "\\+" cfg.name)}
            '';
        };
    };
}
