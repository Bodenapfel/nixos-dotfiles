{ ... }:

{
  networking.hostName = "nixbtw"; # Define your hostname.
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # for vpn
  networking.firewall.checkReversePath = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
