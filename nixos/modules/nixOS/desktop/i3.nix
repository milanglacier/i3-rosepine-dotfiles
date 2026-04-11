{ pkgs, ... }: {
    services.xserver = {
        enable = true;

        desktopManager = {
            xterm.enable = false;
        };

        displayManager = {
            startx.enable = true;
        };

        # use the default log file location for startx. To avoid setting it to
        # /dev/null which is the default value set by nixOS.
        logFile = null;

        windowManager.i3 = {
            enable = true;
            extraPackages = with pkgs; [
                rofi
                dunst
                i3lock
                xautolock
                xss-lock
                # used for screen lock with blurring
                imagemagick
                picom
                feh
                dex
                polybarFull
                libxcvt
                playerctl
                pulseaudio # although we are using pipewire, we still need this for pactl
                scrot
                xclip
                xdotool # for automating x11 by simulating keyboard events
            ];
        };

        xkb.layout = "us";
        xkb.variant = "";
    };
}
