{ config, pkgs, ... }:
{
  services.swaync = {
    enable = true;
    style = ./swaync/style.css;
  };
}
