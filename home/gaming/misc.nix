{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    prismlauncher
    beyond-all-reason
    heroic
    vesktop
    teamspeak6-client
  ];
}
