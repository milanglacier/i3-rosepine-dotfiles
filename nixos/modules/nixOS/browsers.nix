{
pkgs,
config,
username,
...
}: {
    programs = {
        firefox = {
            enable = true;
        };
    };
}
