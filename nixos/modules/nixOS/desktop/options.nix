{ pkgs, lib, config, ... }: {
    options.milanglacier = {
        wayland.windowManager = {
            name = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "The primary window manager session to be launched by Wayland.";
            };
            autostart = lib.mkEnableOption "Whether to automatically start the specified Wayland compositor using greetd.";
        };
    };
}
