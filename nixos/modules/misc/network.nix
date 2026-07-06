{ config, lib, ... }:

{
  options = {
    network.enable = lib.mkEnableOption "enable network configuration";
  };

  config = lib.mkIf config.network.enable {
    networking.hostName = "nixbtw"; # Define your hostname.
    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = true;
    networking.networkmanager.insertNameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];

    # for vpn
    networking.firewall.checkReversePath = false;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
