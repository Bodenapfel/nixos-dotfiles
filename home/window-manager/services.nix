{ config, pkgs, ... }:
{
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
  services.kdeconnect.enable = true;
  services.kdeconnect.indicator = true;

}
