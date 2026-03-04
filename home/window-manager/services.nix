{ config, lib, ... }:

{
  options = { wmServices.enable = lib.mkEnableOption "window manager tray services"; };

  config = lib.mkIf config.wmServices.enable {
    services.network-manager-applet.enable = true;
    services.blueman-applet.enable = true;
    services.kdeconnect.enable = true;
    services.kdeconnect.indicator = true;
  };
}
