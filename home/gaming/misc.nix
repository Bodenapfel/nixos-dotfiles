{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
    beyond-all-reason
  ];
}
