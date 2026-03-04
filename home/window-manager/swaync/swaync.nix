{ config, lib, ... }:

{
  options = { swaync.enable = lib.mkEnableOption "SwayNC notification center"; };

  config = lib.mkIf config.swaync.enable {
    services.swaync = {
      enable = true;
      style = ./style.css;
    };
  };
}
