{ pkgs, config, osConfig, lib, ... }: let
    inherit (lib) attrByPath mkOption pipe replaceStrings types;
    osConf = if osConfig != null then osConfig else {};
    x11WindowManagerName = import ../../lib/x11-window-manager.nix {
        inherit lib pkgs;
        osConfig = osConf;
    };
in {
    options.milanglacier = {
        x11.windowManager = {
            name = mkOption {
                type = types.nullOr types.str;
                default = x11WindowManagerName;
            };
        };

        shell = mkOption {
            type = types.str;
            default =
                let
                    rawShell = attrByPath [ "users" "users" config.home.username "shell" ] null osConf;

                    cleanedShell = pipe rawShell [
                        # Get the package.pname if rawShell is a package
                        (
                            value:
                            if value == null then
                                null
                            else if builtins.isAttrs value then
                                attrByPath [ "pname" ] null value
                            else
                                value
                        )
                        # "shadow" is the default value of
                        # users.users.<name>.shell and is not meaningful here.
                        (value: if value == "shadow" then null else value)
                        # Some Nix shell package names contain "Interactive",
                        # which we remove.
                        (value: if value == null then null else replaceStrings [ "Interactive" ] [ "" ] value)
                    ];
                in
                    if cleanedShell != null then cleanedShell else "bash";
            description = "The shell used by the user";
        };
    };
}
