{ pkgs, lib, config, ... }: {

    xdg.mime.enable = true;

    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
    services.playerctld.enable = true;
    services.printing.enable = true;
    programs.dconf.enable = true;

    services = {
        geoclue2.enable = true;

        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };
    };


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
