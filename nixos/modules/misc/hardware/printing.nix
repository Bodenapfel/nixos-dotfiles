{ pkgs, config, lib, ... }:

{
  options = { printing.enable = lib.mkEnableOption "enables printing"; };

  config = lib.mkIf config.printing.enable {
    # printing setup
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.printing = {
      enable = true;
      drivers = with pkgs; [ cups-filters cups-browsed ];
    };
  };
}
