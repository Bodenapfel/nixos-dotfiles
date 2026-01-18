{ config, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    corefonts
    nerd-fonts.comic-shanns-mono
  ];
}
