{ config, lib, pkgs, ... }:

{
  options = {
    wmServices.enable = lib.mkEnableOption "window manager tray services";
  };

  config = lib.mkIf config.wmServices.enable {
    services.network-manager-applet.enable = true;
    services.blueman-applet.enable = true;
    services.kdeconnect.enable = true;
    services.kdeconnect.indicator = true;

    # blueman package now ships its own unit with ExecStart; the home-manager
    # drop-in adds a second ExecStart which systemd rejects. Clear it first.
    systemd.user.services.blueman-applet.serviceConfig.ExecStart = lib.mkForce [
      ""
      "${pkgs.blueman}/bin/blueman-applet"
    ];
  };
}
