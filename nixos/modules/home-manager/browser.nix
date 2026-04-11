{ pkgs, lib, ... }: {
    programs.firefox = {
        enable = true;
        profiles = {
            default = {
                id = 0;
                settings = {
                    "sidebar.position_start" = false;
                    "sidebar.revamp" = true;
                    "sidebar.verticalTabs" = true;
                    "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
                    "sidebar.visibility" = "expand-on-hover";

                };
            };
        };
    };
}
