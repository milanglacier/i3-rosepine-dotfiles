{ pkgs, config, lib, ... }:
let
    windowManager = import ../../../lib/x11-window-manager.nix {
        inherit lib pkgs;
        osConfig = config;
    };
    startwm = pkgs.writeShellApplication {
        name = "startwm";
        # Use $SHELL to make sure init profile is sourced.
        text = "exec $SHELL -lc 'exec ${windowManager}'";
    };
in {
    services.xrdp = lib.mkIf (windowManager != null) {
        enable = true;
        # HACK: The `defaultWindowManager` option in xrdp uses
        # `runShellCommand` internally. This causes `$SHELL` to be interpolated
        # at build time, resolving to the system default (bash). We need
        # `$SHELL` to resolve at runtime to support per-user shells. Therefore,
        # we use `writeShellApplication` to create a wrapper script that
        # prevents premature interpolation, allowing the user's configured
        # shell to be used.

        # See also nixpkgs#372265: This system-level workaround is currently
        # necessary because a bug prevents xrdp from correctly respecting a
        # user's `~/startwm.sh` script.
        defaultWindowManager = ''
            exec ${startwm}/bin/startwm
        '';
        openFirewall = true;
    };
}
