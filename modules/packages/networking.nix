{ self, inputs, ... }: {
  flake.nixosModules.networking = { config, ... }: {
    networking.networkmanager.enable = true;
    services.tailscale.enable = true;

    networking.nftables.enable = true;

    networking.firewall = {
      enable = true;
      # ssh
      allowedTCPPorts = [ 22 ];
      # tailscale
      trustedInterfaces = [ config.services.tailscale.interfaceName ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };

    # make tailscale use nftables
    systemd.services.tailscaled.serviceConfig.Environment = [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];

    systemd.network.wait-online.enable = false;
    boot.initrd.systemd.network.wait-online.enable = false;
  };
}
