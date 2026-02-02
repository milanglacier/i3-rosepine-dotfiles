{ pkgs, wallpapers, ... }: {
    # Certain programs rely on the /libexec directory, necessitating a symlink
    # from the generated Nix directory to the canonical FHS directory.
    environment.pathsToLink = ["/libexec"];
    services.xserver = {
        enable = true;

        desktopManager = {
            xterm.enable = false;
        };

        displayManager = {
            lightdm.enable = true;
            lightdm.background = "${wallpapers}/rose-pine-dawn-wallpaper.jpeg";
            gdm.enable = false;
        };

        windowManager.i3 = {
            enable = true;
            extraPackages = with pkgs; [
                rofi
                dunst
                i3lock
                xautolock
                # used for screen lock with blurring
                imagemagick
                picom
                feh
                dex
                polybarFull
                xorg.libxcvt
                playerctl
                pulseaudio # although we are using pipewire, we still need this for pactl
                xclip
            ];
        };

        xkb.layout = "us";
        xkb.variant = "";
    };

    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
    services.playerctld.enable = true;

    fonts = {
        packages = with pkgs; [
            noto-fonts-cjk-sans
            eb-garamond
            work-sans
            source-code-pro
        ];

        fontconfig.defaultFonts = {
            serif = ["EB Garamond"];
            sansSerif = ["Work Sans"];
            monospace = ["Source Code Pro"];
        };
    };


}
