{ config, pkgs, ... }: {
    xdg = {
        enable = true;

        mimeApps = {
            enable = true;
        };
    };

    # Disable picom which creates a desktop entry at /etc/xdg/autostart. We
    # override the entry file at the user level.
    xdg.configFile."autostart/picom.desktop".text = ''
        [Desktop Entry]
        Name=picom
        Hidden=true
    '';
}
