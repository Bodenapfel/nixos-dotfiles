{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
    beyond-all-reason
    heroic
    parsec-bin
    vesktop
    teamspeak6-client
  ];
}
