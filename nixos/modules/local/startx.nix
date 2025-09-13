{ pkgs, config, osConfig, lib, ... }: {
    options.milanglacier.${config.home.username} = {
        shell = lib.mkOption {
            type = lib.types.package;
            default = pkgs.zsh;
            description = "Shell package of the user";
        };
        windowManager = lib.mkOption {
            type = lib.types.str;
            default = "none+i3";
            description = "Window Manager session of the user";
        };
    };

    config = let
        sysShell = if (osConfig != null) then osConfig.users.users.${config.home.username}.shell else null;
        sysSession = if (osConfig != null) then osConfig.services.displayManager.defaultSession else null;
        cfg = config.milanglacier.${config.home.username};
    in {
        milanglacier.${config.home.username} = {
            shell = lib.mkIf (sysShell != null) (lib.mkDefault sysShell);
            windowManager = lib.mkIf (sysSession != null) (lib.mkDefault sysSession);
        };

        programs.${cfg.shell.pname} = {
            # Only startx if there is no DISPLAY and we are on the first
            # virtual terminal
            profileExtra = lib.mkOrder 1000 ''
            [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
            '';
        };

        home.file.".xinitrc".text = let
            windowManager = cfg.windowManager;
        in ''
        export QT_SCALE_FACTOR=2
        # This is required for IM working in kitty
        export GLFW_IM_MODULE=ibus
        export LIBGL_ALWAYS_SOFTWARE=1
        # Extract the session name (e.g., "i3" from "none+i3") and execute it.
        exec ${lib.last (builtins.split "\\+" windowManager)}
        '';
    };
}
