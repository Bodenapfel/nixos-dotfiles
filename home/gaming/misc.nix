{ config, pkgs, lib, ... }:

{
  options = { gaming.enable = lib.mkEnableOption "gaming packages"; };

  config = lib.mkIf config.gaming.enable {
    home.packages = with pkgs; [
      prismlauncher
      beyond-all-reason
      heroic
      vesktop
      teamspeak6-client
    ];
  };
}
