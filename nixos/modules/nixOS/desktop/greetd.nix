{ pkgs, config, lib, username, ... }: {
    imports = [ ./options.nix ];
    services.greetd = lib.mkIf config.milanglacier.wayland.windowManager.autostart {
        enable = true;
        settings = {
            default_session = {
                # Use $SHELL to make sure init profile is sourced.
                command = "$SHELL -lc 'exec ${config.milanglacier.wayland.windowManager.name}'";
                user = username;
            };
        };
    };
}
