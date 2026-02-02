{ pkgs, name, ... }:
# Referenced from https://github.com/ryan4yin/nix-config/blob/main/modules/nixos/desktop/fhs.nix
# FHS environment, flatpak, appImage, etc.
# create a fhs environment by command `fhs`, so we can run non-nixos packages in nixos!

let
    base = pkgs.appimageTools.defaultFhsEnvArgs;
in
    pkgs.buildFHSEnv (base // {
        name = "${name}";
        targetPkgs = pkgs: (base.targetPkgs pkgs) ++ [pkgs.pkg-config];
        profile = "export FHS=1";
        # NOTE: the runScript commands are passed straight to `exec`. If you go
        # with runScript = "bash" (the default), running something like a
        # Python command gets super annoying because you have to deal with
        # escape rules. For example:
        #
        # fhs -c "python3 -c 'print(\"hello world\")'"
        #
        # But if you ditch the `bash` part and do runScript = "", everything is
        # so much cleaner:
        #
        # fhs python -c "print('hello world')"
        #
        # No awkward escaping. No headaches.
        runScript = "";
        extraOutputsToInstall = ["dev"];
    })

