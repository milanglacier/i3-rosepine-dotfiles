{ pkgs, ... }: {
    imports = [ ./options.nix ];

    # Enable the gnome-keyring secrets vault.
    # Will be exposed through DBus to programs willing to store secrets.
    services.gnome.gnome-keyring.enable = true;
    i18n.inputMethod.fcitx5.waylandFrontend = true;
    milanglacier.wayland.windowManager = {
        name = "sway";
        autostart = true;
    };

    # enable Sway window manager
    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraPackages = with pkgs; [
            # Screeshot utilities
            grim
            slurp
            wl-clipboard
            dunst
            pulseaudio
            imagemagick
            swaylock
            swayidle
            swayimg
            rofi
            waybar
            # HACK: The `gsettings` utility is required to manually update GTK
            # themes at runtime.
            # See: https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
            # Check out my script at `bin/import-gtk-settings`
            glib
            wayvnc
            wtype # for simulating keyboard events
        ];
    };

    # Open port 5900 for vnc
    networking.firewall.allowedTCPPorts = [ 5900 ];
}

