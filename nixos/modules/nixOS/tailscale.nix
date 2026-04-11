{ pkgs, ... }: {
    services.tailscale = {
        enable = true;
        # You may want to run this: sudo tailscale cert ${MACHINE_NAME}.${TAILNET_NAME}
        # periodicallh to avoid certificate issues.

        # Use userspace networking to only expose HTTPS/SOCKS5 port as we may
        # need other proxy software globally.
        interfaceName = "userspace-networking";
        useRoutingFeatures = "both";
        extraDaemonFlags = [
            "--socks5-server=localhost:1055"
            "--outbound-http-proxy-listen=localhost:1055"
        ];
    };
}
